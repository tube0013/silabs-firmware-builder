# TubeZB SDK build results

## Experimental PB startup test — 2026-10-23

[Build and artifacts](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39901169755); tested source `d3fa4ac1e44ab768f7efbd271722be0683613040`.
The PB router build and complete workflow pass. On 2026-10-23 the user confirmed
that this firmware boots, joins the network, serves Basic attributes correctly,
and remains online overnight.

- Investigating the user's repeating legacy-token-manager assertion on a PB
  device after a full erase. The original serial line was truncated before its
  source line number, so the precise assertion has not been confirmed.
- The previous compiled router has 195 Zigbee token objects and only 200 NVM3
  cache entries. Secure Vault/PSA storage also uses the default NVM3 instance.
- Set `NVM3_DEFAULT_CACHE_SIZE` to 512 only for the experimental PB router.
  The built ELF confirms `defaultCache` is 4,096 bytes rather than 1,600 bytes.
  Keep the 32 KiB flash storage region and existing token formats.
- Apply a PB-only SDK patch that prints the assertion filename basename and
  line number. Build logs confirm the patch applied; disassembly confirms the
  path-stripping code and preservation of original crash filename/line values.
- Host router behavior checks pass. Assertions remain enabled.
- User hardware feedback confirms startup and entry into joining mode. This
  strongly supports cache exhaustion as the cause of the earlier reset loop,
  although the original assertion line was not captured. The user subsequently
  confirmed successful joining, Basic-attribute reads, and overnight online
  operation. Forwarded routing volume and RF range remain unverified; PB was
  beside the coordinator without an antenna. Other builds are unchanged.

## Simple identities and experimental PB router — 2026-10-22

**15/15 firmware builds succeeded** across the full target run and the added
PB router run. Existing-target and PB source commits are recorded separately.

- [Full 14-target build and artifacts](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833461370); source `ef6e5241ff2322567fa65ffb9bffa42ac263cc8a`.
- [Additional MGM24PB router and artifacts](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833813595); source `97382e007ed416ddb59197f8fca2024adbbc2b83`.
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
| `tubeszb-BM-MG24B2-hw-max_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833461370/job/120016623703) |
| `tubeszb-bm24-openthread_rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833461370/job/120016623756) |
| `tubeszb-bm24-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833461370/job/120016623769) |
| `tubeszb-mgm21-2023-sw_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833461370/job/120016624057) |
| `tubeszb-mgm24-hw-ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833461370/job/120016623956) |
| `tubeszb-mgm24-hw-ncp-uart-hw_2025.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833461370/job/120016623560) |
| `tubeszb-mgm24-openthread-rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833461370/job/120016623911) |
| `tubeszb-mgm24-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833461370/job/120016623660) |
| `tubeszb-mgm24PB-hw-max_ncp-uart-hw.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833461370/job/120016623913) |
| `tubeszb-mgm24PB-openthread_rcp.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833461370/job/120016623622) |
| `tubeszb-mgm24PB-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833813595/job/120016929439) |
| `tubeszb-mgm24_bootloader.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833461370/job/120016623637) |
| `tubeszb-mgm24router-zigbee_router.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833461370/job/120016624007) |
| `tubeszb_BM24-MG24_bootloader-uart-xmodem.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833461370/job/120016623746) |
| `tubeszb_MGM240PB_bootloader-uart-xmodem.yaml` | [Passed](https://github.com/tube0013/silabs-firmware-builder/actions/runs/39833461370/job/120016623652) |

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


## Source-route control removal — 2026-10-23

Source commit: `02b314b`. All four router build jobs passed: MGM24 HW flow,
MGM24 SW flow, BM24, and experimental MGM24PB. Pre-commit and the host router
behavior checks passed. Coordinator/Thread/bootloader builds were not repeated
for this router-only change.

Run and downloadable artifacts: https://github.com/tube0013/silabs-firmware-builder/actions/runs/39966569528

The newly built BM24 ELF on each branch was checked: both custom source-route
button messages and the optional concentrator init callback are absent; the
serial bootloader reboot handler remains. Runtime button and LED verification
of these new artifacts is still pending hardware testing. See ROUTER-BEHAVIOR.md
for the resulting behavior.


## Joining LED blink — 2026-10-23

Source commit: `e539aa2`. All four router build jobs passed: MGM24 HW flow,
MGM24 SW flow, BM24, and experimental MGM24PB. Pre-commit and the host behavior
tests passed, including 500 ms blink cadence, stopping after a failed attempt,
and switching to solid on after joining or restoring a joined network.

Run and downloadable artifacts: https://github.com/tube0013/silabs-firmware-builder/actions/runs/39967461591

The final BM24 ELF on each branch contains the joining LED event handler and
serial bootloader handler, with the optional concentrator init callback and
custom source-route toggle messages absent. Hardware validation of the new
blink remains pending. Button timing and automatic joining are unchanged.


## Router button reliability — 2026-10-25

Source commit: `55d3abf`. All four router build jobs passed: MGM24 HW flow,
MGM24 SW flow, BM24, and experimental MGM24PB. Pre-commit and host behavior
tests passed. Regression coverage includes repeated held samples, unmatched
releases, startup-held buttons, exact five-second classification, 32-bit tick
wrap, holds longer than 65.536 seconds, joining LED behavior, and Basic-command
bootloader entry. The host stub supplies debounced states; it does not simulate
the physical switch or prove electrical noise rejection.

Run and artifacts: https://github.com/tube0013/silabs-firmware-builder/actions/runs/40245892995

The SDK 2026.6.2 PB ELF was inspected: its button context selects polling with
debounce (mode 1), GPIO initialization uses filtered input pull (mode 3) and
DOUT=1 for pull-up, the polling handler is present, serial bootloader entry
remains, and the earlier 4,096-byte NVM cache is preserved. Hardware validation
of the button reliability fix remains pending.


## BM24 NCP 460800 beta-feed build — 2026-10-26

Source commit: `7564029`. Successful targeted build:
https://github.com/tube0013/silabs-firmware-builder/actions/runs/40327073654

The new `tubeszb-BM-MG24B2-hw-max_ncp-uart-hw_460800.yaml` target retains the
existing BM24 hardware configuration and changes the application baud to
460800. The original 115200 target remains available. The ELF contains the
strong DLK negotiation policy callback and BM24 identity. The GBL end-tag CRC
checks correctly; metadata confirms Zigbee NCP 9.1.2.1, SDK 2026.6.2, baud460800.
Hardware testing of the new BM24 baud variant is still pending.

The local tube_gateways beta feed was updated (not committed/deployed) with:

| Variant | Public filename | Bytes | MD5 |
| --- | --- | ---: | --- |
| BM24 | `tubeszb-bm24-zigbee_ncp_9.1.2.1_460800_hw_flow.gbl` | 263184 | `781f6f0746688118ee58710f414ec226` |
| MGM24 | `tubeszb-mgm24-zigbee_ncp_9.1.2.1_460800_hw_flow.gbl` | 264200 | `8a0e8ba93dc610f4ef417c1f2586afa9` |

MGM24 is the unchanged, previously validated NCP artifact from run39833461370,
source `ef6e5241ff2322567fa65ffb9bffa42ac263cc8a`. Both images were verified
as NCP9.1.2.1 at460800 and passed GBL CRC checks before copying. The existing
8.2.2 images were retained for legacy feed URLs. All four populated local update
feeds passed URL-to-local-file, size, and MD5 checks, and MkDocs built a temporary
Pages preview successfully.


## Experimental router OTA — 2026-10-26

Branch: `codex/tubeszb-router-ota-2026.6.2`, based on `dd4dae3` of the SDK
2026.6.2 branch. No PR, release, OTA feed publication or HA configuration change.

- [Router build run 40379270559](https://github.com/tube0013/silabs-firmware-builder/actions/runs/40379270559),
  source `0f2e03c`: MGM24 hardware flow, MGM24 software flow, MGM24PB and BM24
  all built successfully with GBL, HEX, ELF and Zigbee OTA outputs.
- [Combined UART/OTA bootloader run 40380359745](https://github.com/tube0013/silabs-firmware-builder/actions/runs/40380359745),
  source `41dd191`: all three modules built successfully as Gecko bootloader
  **3.2.1** (customer version 1).
- CI includes the OTA file/manifest and FORCE reset tests plus the existing
  button/LED tests with OTA both disabled and enabled. All passed.
- Independent zigpy **2.3.0** parsing accepted all four OTA images, recovered each
  exact GBL, and confirmed manufacturer 0x1002, distinct image types 0x5424–0x5427,
  file version 2026102601, and file lengths. The manufacturer code is provisional.
- All four router ELFs reserve OTA flash starting at **0x080C0000**, ending at
  **0x08176000**, with the existing NVM region **0x08176000–0x0817E000** unchanged.
- All three compiled bootloader `storageLayout` tables specify internal flash,
  one slot, start **0x080C0000**, size **0xB4000**. Thus the application writes
  the GBL where the bootloader reads it. The SDK stores the OTA header/progress
  metadata near the end of the same slot.
- Bootloader tables advertise **both storage and communication** (capabilities
  0x001104F0) and application start **0x08006000**. Installed bootloader size
  including CRC is 0x3688 for MGM24/BM24 and 0x36A8 for PB, safely below that start.
- PB compiled-code inspection confirmed FORCE (0x0205) for the existing button,
  Basic command and CLI recovery paths, with the normal SDK install path retained
  for OTA. Its `defaultCache` is still 4096 bytes (512 NVM3 cache entries).

Artifacts inspected locally under `/private/tmp/tubeszb-router-ota-artifacts`:

| Artifact | Bytes | SHA-256 |
| --- | ---: | --- |
| `tubeszb-bm24-zigbee_router_2026.6.2_460800_sw_flow.ota` | 362138 | `aa0cffe520b61c4b9eee9e0874aefc2735418fb7624d2a0ae35d0460fca32c76` |
| `tubeszb-bm24_bootloader-uart-ota_3.2.1.gbl` | 14172 | `36b1b5eced6bf94ec0a3a551af9b99e4553c6145368eee175aefd2c93f02950a` |
| `tubeszb-mgm24-zigbee_router_2026.6.2_460800_hw_flow.ota` | 353918 | `9bf5eac289661d4a7ba230e74f146f0668e45eb537132d8204574531eee9b10f` |
| `tubeszb-mgm24PB-zigbee_router_2026.6.2_460800_hw_flow.ota` | 368478 | `219d80c82b2609efdf3c053217eb48e74d2ee15c794c3bad396d68319267d07b` |
| `tubeszb-mgm24PB_bootloader-uart-ota_3.2.1.gbl` | 14204 | `529746faadfa401478d1b5adf4b0fec25078eb63516d0e19c880a329064677f5` |
| `tubeszb-mgm24_bootloader-uart-ota_3.2.1.gbl` | 14172 | `36b1b5eced6bf94ec0a3a551af9b99e4553c6145368eee175aefd2c93f02950a` |
| `tubeszb-mgm24router-zigbee_router_2026.6.2_460800_sw_flow.ota` | 353854 | `9b4b40ef6d84ab6368d8ccf0ce11da9b0f5adc946b800867f3920cc79a2319db` |

Hardware OTA installation, interrupted-download recovery, retention through an
OTA install, and UART recovery with a staged image have not yet been exercised
on physical devices. Use the matching new bootloader before the first OTA test.
See [ROUTER-OTA.md](ROUTER-OTA.md) for the setup and test sequence.
