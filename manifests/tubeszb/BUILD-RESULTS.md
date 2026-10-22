# TubeZB stable build results

## Simple identities and experimental PB router — 2026-10-22

**17/17 firmware builds succeeded** across the full target run and the added
PB router run. Existing-target and PB source commits are recorded separately.

- [Full 16-target build and artifacts](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653); source `5a13f6a9b3522c5573eff9ab9f924e305c18e04f`.
- [Additional MGM24PB router and artifacts](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833796596); source `1e88727cd9eb53c68dc7414cb7f3afcb7ea2f2f3`.
- Router Basic-cluster ManufacturerName (0x0004) is `TubesZB`.
- Router ModelIdentifier (0x0005) is `MGM24`, `BM24`, or `MGM24PB`.
- Coordinator XNCP manufacturer is `TubesZB`, with simple hardware model names:
  `MGM12`, `MGM21`, `MGM24`, `MGM24PB`, or `BM24`, as applicable to this branch.
- Checked compiled router ELF files for the length-prefixed ZCL manufacturer/model
  strings, and every coordinator ELF for its firmware XNCP identity strings.
- Router LED/join/button host checks pass. Configuration merge checks cover file-ID
  replacement, preservation of unrelated entries, repeated merges, and path fallback.
- Fix manifest configuration-file merging to replace the base ZAP by file ID;
  initially appending the BM24 ZAP caused SLC to reject duplicate definitions.
- The user-supplied flashing tokens used manufacturer `TubesZB`, with older board
  names `MG24-2024` / `BM MG24-2024`. Firmware now uses the requested simple names.
- PB router is an experimental personal target, explicitly built for `MGM240PB32VNN`.
  Earlier PB operation was reportedly unsuccessful; no hardware test is claimed.
  Use the PB target and matching PB bootloader when testing. The supplied older
  MGM24 flash scripts select the PA target. No flashing scripts or tokens were changed.
- Revision/baud/flow details remain in build labels and filenames. No PR was opened.

| Manifest | Result |
| --- | --- |
| `tubeszb-BM-MG24B2-hw-max_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653/job/120015116346) |
| `tubeszb-bm24-openthread_rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653/job/120015116438) |
| `tubeszb-bm24-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653/job/120015116277) |
| `tubeszb-mgm21-2023-sw_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653/job/120015116387) |
| `tubeszb-mgm24-hw-ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653/job/120015116324) |
| `tubeszb-mgm24-hw-ncp-uart-hw_2025.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653/job/120015116539) |
| `tubeszb-mgm24-openthread-rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653/job/120015116411) |
| `tubeszb-mgm24-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653/job/120015116258) |
| `tubeszb-mgm24PB-hw-max_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653/job/120015116399) |
| `tubeszb-mgm24PB-openthread_rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653/job/120015116492) |
| `tubeszb-mgm24PB-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833796596/job/120016917013) |
| `tubeszb-mgm24_bootloader.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653/job/120015116212) |
| `tubeszb-mgm24router-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653/job/120015116192) |
| `tubeszb_BM24-MG24_bootloader-uart-xmodem.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653/job/120015116343) |
| `tubeszb_MGM240PB_bootloader-uart-xmodem.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653/job/120015116254) |
| `tubeszb_mgm12-2021_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653/job/120015116432) |
| `tubeszb_mgm12-2022_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833303653/job/120015116287) |

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
