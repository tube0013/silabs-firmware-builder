# TubeZB SDK build results

## SDK 2026.6.2 migration — 2026-10-22

**14/14 TubeZB firmware builds succeeded**, along with the full workflow.

- [Workflow and downloadable artifacts](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39808283510)
- Tested source commit: `d3fb4a948e16238590a3946ba6fe1696768d8f60`.
- Every artifact reports SDK **2026.6.2** in the generated manifest.
- All five coordinators: **9.1.2.1**, preserving upstream's DLK policy patch suffix.
- All three OpenThread RCPs: **SL-OPENTHREAD/3.1.2.0_GitHub-fb274efe6**.
- All three TubeZB bootloaders: **3.2.0**, rebuilt with the new SDK.
- Both AMD64 and ARM64 SDK containers were built and published successfully
  in [the initial run](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39803892800).
- Initial Zigbee jobs compiled but failed the reproducibility check because
  SDK prebuilt libraries referenced a new `silabs_core` Conan package path.
  Add that path to the existing remaps; the final run passes with verification enabled.
- Existing OpenThread SDK patches still apply. TubeZB PTI, LED, UART, clock,
  and router behavior settings are preserved. Local router callback tests passed.
- Upstream reference manifests also select the new SDK; this run validates
  the 14 TubeZB targets. MGM12 stays on the stable branch.
- Hardware testing of this SDK update remains. No PR has been opened.

| Manifest | Result |
| --- | --- |
| `tubeszb-BM-MG24B2-hw-max_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39808283510/job/119927487693) |
| `tubeszb-bm24-openthread_rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39808283510/job/119927487229) |
| `tubeszb-bm24-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39808283510/job/119927486878) |
| `tubeszb-mgm21-2023-sw_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39808283510/job/119927487050) |
| `tubeszb-mgm24-hw-ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39808283510/job/119927487164) |
| `tubeszb-mgm24-hw-ncp-uart-hw_2025.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39808283510/job/119927486976) |
| `tubeszb-mgm24-openthread-rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39808283510/job/119927486985) |
| `tubeszb-mgm24-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39808283510/job/119927487132) |
| `tubeszb-mgm24PB-hw-max_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39808283510/job/119927487017) |
| `tubeszb-mgm24PB-openthread_rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39808283510/job/119927487217) |
| `tubeszb-mgm24_bootloader.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39808283510/job/119927487117) |
| `tubeszb-mgm24router-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39808283510/job/119927487434) |
| `tubeszb_BM24-MG24_bootloader-uart-xmodem.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39808283510/job/119927487043) |
| `tubeszb_MGM240PB_bootloader-uart-xmodem.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39808283510/job/119927487088) |

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
