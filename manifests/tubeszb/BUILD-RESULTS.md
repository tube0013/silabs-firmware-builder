# TubeZB beta build results

## PTI follow-up — 2026-09-17

**4/4 affected coordinator builds succeeded**, along with the full workflow.

- [PTI firmware artifacts and workflow](https://github.com/tube0013/silabs-firmware-builder/actions/runs/35260973250)
- Tested source commit: `4f4a89ed4a897b41da271809d5ea50bd7540762f`.
- PTI UART: 1,600,000 baud; PC04 DOUT and PC05 DFRAME, ported from `pti_nonsense`.
- The user reports the earlier firmware is running well; these PTI-enabled
  artifacts still require capture verification on hardware.

| Manifest | Result |
| --- | --- |
| `tubeszb-BM-MG24B2-hw-max_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/35260973250/job/105336500089) |
| `tubeszb-mgm24-hw-ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/35260973250/job/105336500082) |
| `tubeszb-mgm24-hw-ncp-uart-hw_2025.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/35260973250/job/105336500131) |
| `tubeszb-mgm24PB-hw-max_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/35260973250/job/105336500081) |

## Original full beta validation

Verified 2026-09-13. **14/14 firmware builds succeeded**, as did the full workflow.

- [Workflow and downloadable artifacts](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775291246)
- Tested source commit: `ebd86babfee5e74571e86fd0aa0ed4a7e2ddc7dc`
- Artifacts: 14 firmware bundles (GBL, HEX, ELF/OUT), plus `manifest.json`.
- This record is a documentation-only follow-up to the tested source commit.
- Build success does not establish hardware behavior; nothing was flashed.

| Manifest | Result |
| --- | --- |
| `tubeszb-BM-MG24B2-hw-max_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775291246/job/103772229897) |
| `tubeszb-bm24-openthread_rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775291246/job/103772229847) |
| `tubeszb-bm24-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775291246/job/103772229876) |
| `tubeszb-mgm21-2023-sw_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775291246/job/103772229853) |
| `tubeszb-mgm24-hw-ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775291246/job/103772229877) |
| `tubeszb-mgm24-hw-ncp-uart-hw_2025.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775291246/job/103772229864) |
| `tubeszb-mgm24-openthread-rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775291246/job/103772229857) |
| `tubeszb-mgm24-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775291246/job/103772229851) |
| `tubeszb-mgm24PB-hw-max_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775291246/job/103772229863) |
| `tubeszb-mgm24PB-openthread_rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775291246/job/103772229888) |
| `tubeszb-mgm24_bootloader.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775291246/job/103772229889) |
| `tubeszb-mgm24router-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775291246/job/103772229916) |
| `tubeszb_BM24-MG24_bootloader-uart-xmodem.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775291246/job/103772229854) |
| `tubeszb_MGM240PB_bootloader-uart-xmodem.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775291246/job/103772229865) |

## CI fixes made during validation

Both workflows reuse Nabu Casa's published build image only when the dependency
hash matches exactly. Firmware matrices disable fail-fast to check every device.
Stable router key-table size is passed as a compiler define because that SDK
has no generated header override for it. Beta XNCP selects USART versus EUSART
headers and flow-control constants to support EUSART-only configurations.
Upstream extension vendor attribution remains unchanged.
