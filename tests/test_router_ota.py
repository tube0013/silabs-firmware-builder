"""OTA file interoperability and manifest/layout regression checks."""

import copy
import json
import struct
import subprocess
import tempfile
import unittest
import zlib
from pathlib import Path

from pygbl import (
    GBL3ApplicationInfo,
    GBL3ApplicationType,
    GBL3End,
    GBL3Header,
    GBL3Image,
    GBL3Type,
    GBLError,
)
from ruamel.yaml import YAML

from tools.create_ota import (
    OTA_HEADER,
    OTA_MAGIC,
    create_ota_image,
    validate_ota_manifest,
)

ROOT = Path(__file__).resolve().parents[1]


def application_gbl():
    image = GBL3Image(
        [
            GBL3Header(version=0x03000000, type=GBL3Type(0)),
            GBL3ApplicationInfo(
                type=GBL3ApplicationType.ZIGBEE,
                version=1,
                capabilities=0,
                product_id=bytes(16),
            ),
            GBL3End(crc=0),
        ]
    ).serialize()
    return image[:-4] + struct.pack("<I", zlib.crc32(image[:-4]))


class TestRouterOta(unittest.TestCase):
    def setUp(self):
        self.ota = {
            "manufacturer_id": 0x1002,
            "image_type": 0x5424,
            "file_version": 2026102601,
            "header_string": "MGM24 router",
        }

    def test_standard_header_and_upgrade_subelement(self):
        gbl = application_gbl()
        ota = create_ota_image(gbl, self.ota)
        header = OTA_HEADER.unpack_from(ota)
        self.assertEqual(
            header[:8], (OTA_MAGIC, 0x0100, 56, 0, 0x1002, 0x5424, 2026102601, 2)
        )
        self.assertEqual(header[-1], len(ota))
        self.assertEqual(struct.unpack_from("<HI", ota, 56), (0, len(gbl)))
        self.assertEqual(ota[62:], gbl)

    def test_invalid_image_and_metadata_are_rejected(self):
        with self.assertRaises(GBLError):
            create_ota_image(b"not a GBL", self.ota)
        corrupted = bytearray(application_gbl())
        corrupted[-1] ^= 1
        with self.assertRaises(GBLError):
            create_ota_image(bytes(corrupted), self.ota)
        for field, value in (
            ("manufacturer_id", 0xFFFF),
            ("image_type", 0xFFFF),
            ("file_version", 0),
            ("header_string", "x" * 33),
        ):
            with self.subTest(field=field), self.assertRaises(ValueError):
                create_ota_image(application_gbl(), {**self.ota, field: value})

    def test_manifest_identities_and_storage(self):
        yaml = YAML(typ="safe")
        image_types = set()
        manifests = list((ROOT / "manifests/tubeszb").glob("*zigbee_router.yaml"))
        self.assertEqual(len(manifests), 4)
        for path in manifests:
            manifest = yaml.load(path)
            validate_ota_manifest(manifest)
            image_type = manifest["ota"]["image_type"]
            self.assertNotIn(image_type, image_types)
            image_types.add(image_type)
            self.assertEqual(
                manifest["c_defines"]["SL_BOOTLOADER_STORAGE_SIZE"],
                0x08176000 - 0x080C0000,
            )
            bad = copy.deepcopy(manifest)
            bad["ota"]["file_version"] += 1
            with self.assertRaises(ValueError):
                validate_ota_manifest(bad)
            zap = json.loads(
                (path.parent / manifest["config_file"][0]["path"]).read_text()
            )
            manufacturer = next(
                item["value"]
                for item in zap["keyValuePairs"]
                if item["key"] == "manufacturerCodes"
            )
            self.assertEqual(int(manufacturer, 0), manifest["ota"]["manufacturer_id"])
            clusters = zap["endpointTypes"][0]["clusters"]
            self.assertEqual(
                len(
                    [
                        c
                        for c in clusters
                        if c["code"] == 25 and c["side"] == "client" and c["enabled"]
                    ]
                ),
                1,
            )
        bootloaders = list(
            (ROOT / "manifests/tubeszb").glob("*bootloader-uart-ota.yaml")
        )
        self.assertEqual(len(bootloaders), 3)
        for path in bootloaders:
            config = yaml.load(path)["config_file"][0]
            self.assertEqual(config["file_id"], "btl_storage_slot_cfg")
            header = (path.parent / config["path"]).read_text()
            self.assertIn("#define SLOT0_START 0x080C0000UL", header)
            self.assertIn("#define SLOT0_SIZE 0x000B4000UL", header)

    def test_recovery_sets_force_instead_of_install(self):
        with tempfile.TemporaryDirectory(prefix="tubeszb-ota-recovery-") as directory:
            root = Path(directory)
            (root / "btl_interface.h").write_text(
                "#include <stdint.h>\n"
                "typedef struct { uint16_t reason, signature; } BootloaderResetCause_t;\n"
                "#define BOOTLOADER_RESET_REASON_FORCE 0x0205\n"
                "#define BOOTLOADER_RESET_SIGNATURE_VALID 0xF00F\n"
            )
            (root / "em_device.h").write_text(
                "void test_system_reset(void);\n"
                "#define NVIC_SystemReset test_system_reset\n"
            )
            (root / "main.c").write_text(
                '#include "btl_interface.h"\n#include <assert.h>\n'
                '#include <string.h>\n#include "tubeszb_router_ota.h"\n'
                "uint32_t __ResetReasonStart__;\nstatic int resets;\n"
                "void test_system_reset(void) { resets++; }\n"
                "int main(void) {\n"
                "  BootloaderResetCause_t cause;\n"
                "  tubeszb_router_reboot_to_uart();\n"
                "  memcpy(&cause, &__ResetReasonStart__, sizeof(cause));\n"
                "  assert(cause.reason == BOOTLOADER_RESET_REASON_FORCE);\n"
                "  assert(cause.signature == BOOTLOADER_RESET_SIGNATURE_VALID);\n"
                "  assert(resets == 1);\n}\n"
            )
            extension = ROOT / "src/zigbee_router/extension/tubeszb_router_extension"
            executable = root / "test"
            subprocess.run(
                [
                    "cc",
                    "-std=c11",
                    "-Wall",
                    "-Wextra",
                    "-Werror",
                    "-I",
                    str(root),
                    "-I",
                    str(extension / "inc"),
                    str(root / "main.c"),
                    str(extension / "src/tubeszb_router_ota.c"),
                    "-o",
                    str(executable),
                ],
                check=True,
            )
            subprocess.run([str(executable)], check=True)


if __name__ == "__main__":
    unittest.main()
