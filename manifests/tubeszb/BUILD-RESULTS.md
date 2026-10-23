# TubeZB beta build results

## Simple identities and experimental PB router — 2026-10-22

**15/15 firmware builds succeeded** across the full target run and the added
PB router run. Existing-target and PB source commits are recorded separately.

- [Full 14-target build and artifacts](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833452517); source `c170d095789c6f79a5f2bae38436a76f7fb55bca`.
- [Additional MGM24PB router and artifacts](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833804113); source `2c60356fa1da2b2657a8f61874eeda405a7c819b`.
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
| `tubeszb-BM-MG24B2-hw-max_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833452517/job/120015976115) |
| `tubeszb-bm24-openthread_rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833452517/job/120015976088) |
| `tubeszb-bm24-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833452517/job/120015976039) |
| `tubeszb-mgm21-2023-sw_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833452517/job/120015976100) |
| `tubeszb-mgm24-hw-ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833452517/job/120015976041) |
| `tubeszb-mgm24-hw-ncp-uart-hw_2025.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833452517/job/120015976328) |
| `tubeszb-mgm24-openthread-rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833452517/job/120015976098) |
| `tubeszb-mgm24-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833452517/job/120015976188) |
| `tubeszb-mgm24PB-hw-max_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833452517/job/120015976126) |
| `tubeszb-mgm24PB-openthread_rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833452517/job/120015976492) |
| `tubeszb-mgm24PB-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833804113/job/120016876534) |
| `tubeszb-mgm24_bootloader.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833452517/job/120015976043) |
| `tubeszb-mgm24router-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833452517/job/120015976143) |
| `tubeszb_BM24-MG24_bootloader-uart-xmodem.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833452517/job/120015976245) |
| `tubeszb_MGM240PB_bootloader-uart-xmodem.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833452517/job/120015976235) |

## Upstream resync — 2026-10-22

**14/14 firmware builds succeeded**, along with the full workflow.

- [Workflow and downloadable artifacts](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39788425319)
- Tested source commit: `d1321dd9d641b9f78b62ea2bef9ca906953c5917`.
- Upstream: `adafdc2`, release `v2026.09.17-beta2`.
- All five coordinator artifacts report **9.1.1.1**, verified in the generated manifest.
- Includes the upstream dynamic link key policy fix for direct Zigbee 4.0 router joins.
- TubeZB hardware configuration, PTI, and EUSART compatibility changes are preserved.
- Router callback host tests passed. Hardware testing of this update remains.
- Upstream stable is unchanged at `b45d978`; the stable integration already includes it.

| Manifest | Result |
| --- | --- |
| `tubeszb-BM-MG24B2-hw-max_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39788425319/job/119857847838) |
| `tubeszb-bm24-openthread_rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39788425319/job/119857848036) |
| `tubeszb-bm24-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39788425319/job/119857847845) |
| `tubeszb-mgm21-2023-sw_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39788425319/job/119857847908) |
| `tubeszb-mgm24-hw-ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39788425319/job/119857847957) |
| `tubeszb-mgm24-hw-ncp-uart-hw_2025.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39788425319/job/119857847999) |
| `tubeszb-mgm24-openthread-rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39788425319/job/119857847995) |
| `tubeszb-mgm24-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39788425319/job/119857847932) |
| `tubeszb-mgm24PB-hw-max_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39788425319/job/119857848073) |
| `tubeszb-mgm24PB-openthread_rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39788425319/job/119857848107) |
| `tubeszb-mgm24_bootloader.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39788425319/job/119857848060) |
| `tubeszb-mgm24router-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39788425319/job/119857847975) |
| `tubeszb_BM24-MG24_bootloader-uart-xmodem.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39788425319/job/119857848212) |
| `tubeszb_MGM240PB_bootloader-uart-xmodem.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39788425319/job/119857848040) |

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


## Source-route control removal — 2026-10-23

Source commit: `34dec07`. All four router build jobs passed: MGM24 HW flow,
MGM24 SW flow, BM24, and experimental MGM24PB. Pre-commit and the host router
behavior checks passed. Coordinator/Thread/bootloader builds were not repeated
for this router-only change.

Run and downloadable artifacts: https://github.com/tube0013/silabs-firmware-builder/actions/runs/39966559028

The newly built BM24 ELF on each branch was checked: both custom source-route
button messages and the optional concentrator init callback are absent; the
serial bootloader reboot handler remains. Runtime button and LED verification
of these new artifacts is still pending hardware testing. See ROUTER-BEHAVIOR.md
for the resulting behavior.
