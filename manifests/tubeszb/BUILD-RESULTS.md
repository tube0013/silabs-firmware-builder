# TubeZB stable build results

Verified 2026-09-13. **16/16 firmware builds succeeded**, as did the full workflow.

- [Workflow and downloadable artifacts](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664)
- Tested source commit: `e3646ec0a3675cd0bb87aa9df8c9559dfb7269d8`
- Artifacts: 16 firmware bundles (GBL, HEX, ELF/OUT), plus `manifest.json`.
- This record is a documentation-only follow-up to the tested source commit.
- Build success does not establish hardware behavior; nothing was flashed.

| Manifest | Result |
| --- | --- |
| `tubeszb-BM-MG24B2-hw-max_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664/job/103772244186) |
| `tubeszb-bm24-openthread_rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664/job/103772244148) |
| `tubeszb-bm24-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664/job/103772244395) |
| `tubeszb-mgm21-2023-sw_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664/job/103772244178) |
| `tubeszb-mgm24-hw-ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664/job/103772244160) |
| `tubeszb-mgm24-hw-ncp-uart-hw_2025.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664/job/103772244151) |
| `tubeszb-mgm24-openthread-rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664/job/103772244167) |
| `tubeszb-mgm24-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664/job/103772244350) |
| `tubeszb-mgm24PB-hw-max_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664/job/103772244212) |
| `tubeszb-mgm24PB-openthread_rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664/job/103772244140) |
| `tubeszb-mgm24_bootloader.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664/job/103772244194) |
| `tubeszb-mgm24router-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664/job/103772244195) |
| `tubeszb_BM24-MG24_bootloader-uart-xmodem.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664/job/103772244184) |
| `tubeszb_MGM240PB_bootloader-uart-xmodem.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664/job/103772244242) |
| `tubeszb_mgm12-2021_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664/job/103772244168) |
| `tubeszb_mgm12-2022_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/34775289664/job/103772244213) |

## CI fixes made during validation

Both workflows reuse Nabu Casa's published build image only when the dependency
hash matches exactly. Firmware matrices disable fail-fast to check every device.
Stable router key-table size is passed as a compiler define because that SDK
has no generated header override for it. Beta XNCP selects USART versus EUSART
headers and flow-control constants to support EUSART-only configurations.
Upstream extension vendor attribution remains unchanged.
