"""Package a router GBL in the standard Zigbee OTA Upgrade file format."""

from __future__ import annotations

import pathlib
import struct
from typing import Any

from elftools.elf.elffile import ELFFile
from pygbl import GBL3ApplicationInfo, GBL3Image, parse_firmware_image

OTA_HEADER = struct.Struct("<IHHHHHIH32sI")
OTA_MAGIC = 0x0BEEF11E
SLOT_START = 0x080C0000
SLOT_SIZE = 0xB4000
NVM_START = 0x08176000
NVM_END = 0x0817E000


def validate_ota_manifest(config: dict[str, Any]) -> None:
    """Keep OTA header identity and the compiled SDK client policy in agreement."""
    ota = config["ota"]
    if config["gbl"]["fw_type"] != "zigbee_router":
        raise ValueError("OTA packaging is only supported for Zigbee routers")
    defines = config["c_defines"]
    for field, define in (
        ("image_type", "SL_ZIGBEE_AF_PLUGIN_OTA_CLIENT_POLICY_IMAGE_TYPE_ID"),
        ("file_version", "SL_ZIGBEE_AF_PLUGIN_OTA_CLIENT_POLICY_FIRMWARE_VERSION"),
    ):
        if ota[field] != defines[define]:
            raise ValueError(f"OTA {field} does not match the compiled client policy")


def validate_ota_layout(elf_path: pathlib.Path) -> None:
    """Reject builds that move NVM or overlap the reserved OTA download space."""
    with elf_path.open("rb") as file:
        elf = ELFFile(file)
        symbols = elf.get_section_by_name(".symtab")
        expected = {
            "linker_storage_begin": SLOT_START,
            "linker_storage_end": NVM_START,
            "linker_nvm_begin": NVM_START,
            "linker_nvm_end": NVM_END,
        }
        for name, address in expected.items():
            matches = symbols.get_symbol_by_name(name) or []
            if len(matches) != 1 or matches[0]["st_value"] != address:
                raise ValueError(f"Unexpected OTA/NVM layout for {name}")
        for segment in elf.iter_segments():
            if segment["p_type"] != "PT_LOAD" or not segment["p_filesz"]:
                continue
            start = segment["p_paddr"]
            end = start + segment["p_filesz"]
            if start < 0x08180000 and end > SLOT_START:
                raise ValueError("Loadable firmware overlaps OTA storage or NVM")


def create_ota_image(gbl: bytes, ota: dict[str, Any]) -> bytes:
    """Wrap a validated application GBL in one upgrade-image subelement (tag 0)."""
    firmware = parse_firmware_image(gbl)
    if not isinstance(firmware, GBL3Image):
        raise TypeError("A GBL3 application image is required")
    firmware.get_first_tag(GBL3ApplicationInfo)
    manufacturer, image_type, version = (
        ota["manufacturer_id"],
        ota["image_type"],
        ota["file_version"],
    )
    if not 0 <= manufacturer < 0xFFFF or not 0 <= image_type < 0xFFC0:
        raise ValueError("Invalid OTA manufacturer or image type")
    if not 0 < version < 0xFFFFFFFF:
        raise ValueError("Invalid OTA file version")
    label = ota["header_string"].encode("ascii")
    if len(label) > 32:
        raise ValueError("OTA header string exceeds 32 bytes")
    # The SDK stores progress metadata/OTA header in the final flash page.
    if len(gbl) > SLOT_SIZE - 0x2000:
        raise ValueError("GBL exceeds the OTA slot's usable download space")
    payload = struct.pack("<HI", 0, len(gbl)) + gbl
    header = OTA_HEADER.pack(
        OTA_MAGIC,
        0x0100,
        OTA_HEADER.size,
        0,
        manufacturer,
        image_type,
        version,
        2,
        label.ljust(32, b"\0"),
        OTA_HEADER.size + len(payload),
    )
    return header + payload
