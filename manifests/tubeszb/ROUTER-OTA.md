# Experimental MG24 router OTA

Branch: `codex/tubeszb-router-ota-2026.6.2`, based on SDK 2026.6.2.

The four existing MG24 router manifests now include the SDK's standard Zigbee
OTA Upgrade **client** (cluster 0x0019). This covers MGM24 with hardware flow,
MGM24 with software flow, MGM24PB, and BM24. NCP/RCP manifests and the existing
UART-only bootloader targets are unchanged.

## Matching bootloader and flash layout

Use the new matching `*-bootloader-uart-ota.yaml` manifest for each device:

| Router module | Combined bootloader manifest |
| --- | --- |
| MGM24 (either UART flow variant) | `tubeszb-mgm24_bootloader-uart-ota.yaml` |
| MGM24PB | `tubeszb-mgm24PB_bootloader-uart-ota.yaml` |
| BM24 | `tubeszb-bm24_bootloader-uart-ota.yaml` |

These bootloaders retain PA0 active-low activation, USART0 PA6 TX / PA5 RX,
PA7 CTS / PA8 RTS, hardware flow control and 115200 baud XMODEM recovery.
The router console remains at 460800 baud with its existing flow configuration.

All three bootloaders define internal-flash slot 0 at **0x080C0000**, length
**0xB4000** (720 KiB), ending at 0x08174000 (exclusive). The router OTA driver
queries that slot from the installed bootloader using `USE_SPECIFIC_SLOT` / 0;
it does not configure a second independent download address. With SoC bootloading
enabled, the SDK remaps the OTA file so that the **GBL starts at 0x080C0000**;
the Zigbee OTA header and download-progress metadata are stored near the end of
the slot. The bootloader reads the GBL from that same slot start.

The router reserves 0xB6000 bytes below its existing NVM region, covering the
slot and an extra 8 KiB gap. The builder rejects an OTA router ELF unless:

- `linker_storage_begin` is 0x080C0000.
- `linker_storage_end` and `linker_nvm_begin` are 0x08176000.
- `linker_nvm_end` is 0x0817E000.
- No loadable firmware segment overlaps the OTA reservation or NVM.

Network settings, physical manufacturing tokens and the PB's 512-entry NVM3
cache are preserved. Actual retention through an OTA installation still needs
hardware testing; a successful compile is not an end-to-end OTA test.

## Recovery and button behavior

Storage bootloaders normally attempt a staged image before opening their UART
interface. The combined bootloader has one small SDK patch: reset reason
`FORCE`, or PA0 held at reset, bypasses storage and opens UART directly.
The TubesZB OTA extension uses the documented Gecko reset-signalling ABI to
request `FORCE` for existing button, Basic-cluster and CLI recovery paths.
The SDK OTA client continues to use its normal install path (`BOOTLOAD`).

Existing behavior remains:

- Fresh/unjoined startup automatically starts joining; LED blinks at 500 ms
  intervals during an active attempt, and failed attempts retry after 10 seconds.
- Joined: LED solid on; a short press does nothing; a press **longer than five
  seconds**, acted on release, leaves the network and schedules joining again.
- Unjoined: short press toggles the pending joining event; long press enters UART
  recovery. A short press does not cancel an SDK scan already in progress.
- Basic `ResetToFactoryDefaults` intentionally enters UART recovery, as before.
- `bootloader reboot` enters UART recovery; `bootloader info` remains available.
- PA0 uses its internal pull-up and existing polling/debounce settings.
- MGM24 boards with the unrouted PD02 trace still cannot light their LED.

## OTA identity and files

| Router target | Image type |
| --- | --- |
| MGM24 hardware flow | 0x5424 |
| MGM24 software flow (`mgm24router`) | 0x5425 |
| MGM24PB | 0x5426 |
| BM24 | 0x5427 |

The inherited manufacturer ID **0x1002 belongs to Silicon Labs**. It is a
provisional test setting, not an assigned TubesZB manufacturer code. These image
types are local experimental assignments. Resolve the permanent manufacturer ID
before public OTA distribution; update the ZAP configurations and each manifest's
`ota.manufacturer_id` together. Basic strings remain `TubesZB` / the module name.

Initial OTA file version is **2026102601** (decimal). Increase both
`ota.file_version` and `SL_ZIGBEE_AF_PLUGIN_OTA_CLIENT_POLICY_FIRMWARE_VERSION`
for a subsequent update. The builder rejects mismatches. The SDK maintains
readable current-file-version, manufacturer-ID and image-type client attributes.

The builder emits a standard `.ota` file alongside `.gbl`, `.hex` and `.out` for
OTA router manifests. Each OTA file has one upgrade-image subelement (tag 0)
containing the original, CRC-validated GBL. Hardware variants have different
image types so the OTA server can match the correct image. The existing UART GBL
remains available. OTA images currently use the same unsigned/unencrypted GBL
policy as these development builds; GBL verification is enabled in the client.

The SDK discovers an OTA server after joining, with its randomized startup delay,
and checks for an update every 24 hours. It validates a completed download and
uses the server's normal upgrade-end scheduling. Failed downloads are cleared.

## First hardware test

1. Install the matching combined bootloader **and** OTA-capable router using SWD
   or the appropriate UART update process. Do not erase NVM/user data merely to
   add OTA. Confirm the bootloader fits below the application's existing start
   address before flashing; do not use a full-chip erase as an update method.
2. In the router CLI, run `plugin slot-manager slots-info` and `plugin ota-client
   info`. Confirm slot 0 starts at 0x080C0000 with size 0xB4000, and check the
   manufacturer's ID, image type and current file version.
3. Confirm normal joining, button actions, Basic remote recovery and UART upload.
   Return to the router image and confirm the device retains its network.
4. Build a second image with a greater OTA file version (for example 2026102602),
   keeping both version settings synchronized. Serve the matching `.ota` through
   a custom/local ZHA or Zigbee2MQTT OTA source. These are Zigbee OTA files, not
   the ESPHome radio-flasher JSON feeds.
5. Trigger an update check (`plugin ota-client start` can start SDK discovery),
   approve the update on the server, and watch `plugin ota-client status`.
6. After installation, confirm the higher current-file-version, retained IEEE /
   network, immediate device announce, routing, child operation, and button/LED.
7. Interrupt a download and confirm recovery/retry without losing the running
   firmware. Also verify UART recovery with a complete image still in slot 0.

Zigbee2MQTT supports a custom OTA index or a per-request firmware URL. For example,
its local override index can contain this entry (use the real path and file size):

```json
[
  {
    "manufacturerCode": 4098,
    "imageType": 21540,
    "fileVersion": 2026102602,
    "fileSize": 0,
    "url": "/absolute/path/to/tubeszb-mgm24-router.ota"
  }
]
```

Set `ota.zigbee_ota_override_index_location` to that index. ZHA can use the same index through its local Z2M provider:

```yaml
zha:
  zigpy_config:
    ota:
      extra_providers:
        - type: z2m_local
          index_file: /config/tubeszb-ota/index.json
```

Use file paths that exist inside Home Assistant, or serve the OTA files over HTTP.
No public OTA index,
GitHub release, Pages deployment or HA configuration is changed by this branch.

References:
- [Silicon Labs OTA client setup](https://docs.silabs.com/zigbee/latest/ota-bootload-server-client-setup-zigbee-sdk-v7x-higher/03-setting-up-a-client)
- [Zigbee2MQTT custom/local OTA sources](https://www.zigbee2mqtt.io/guide/usage/ota_updates.html)
- [zigpy OTA configuration](https://github.com/zigpy/zigpy/wiki/OTA-Configuration)
