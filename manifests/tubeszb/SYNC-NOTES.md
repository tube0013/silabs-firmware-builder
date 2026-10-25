# TubeZB beta integration draft

Branch: `codex/tubeszb-beta-sync`.

## Scope and upstream baseline

Based on the locally synced main, including upstream `adafdc2` and latest
beta `v2026.09.17-beta2`. NCP/router builds use Simplicity SDK 2026.6.1 and
GCC 14.2.1.20241119. MGM12 manifests are renamed `.yaml.disabled` so beta
manifest discovery cannot attempt to build unsupported Series-1 devices.
Use the stable branch to produce MGM12 firmware.

All existing active TubeZB manifests now use the corresponding upstream channel's
SDK/toolchain selections. This includes Zigbee, OpenThread, and bootloader builds.
Full workflow and firmware compilation passed. See [BUILD-RESULTS.md](BUILD-RESULTS.md)
for every device result and the exact tested source commit. Hardware testing remains.
Both integration branches have been pushed to the fork. No PRs have been opened.

## NCP changes

- Use upstream's `xncp_core` and `xncp_common_commands` components and corresponding
  SDK extensions. Do not include ZBT-2's RGB, accelerometer, reset-button, or
  board-specific XNCP commands. TubeZB manufacturer and board strings replace
  Nabu Casa branding. Flow-control reporting uses the actual UART configuration.
- MGM21 uses SkyConnect stack/table defaults and its original TubeZB UART pins.
  Correct its device from the mistakenly declared MGM240PA32VNN to MGM210PA32JIA,
  supported by the older local MGM21 project. Confirm this part against the 2023
  hardware before releasing. The beta manifest also takes Yellow's MGM210
  peripheral-clock divider workaround.
- MGM24 PA/PB and BM24 use ZBT-2 stack/table defaults with TubeZB's UART pins.
  Existing NCP filenames and baud rates are retained: the 2025 MGM24 variant
  is 460800; other existing MG24/BM24 NCP manifests remain 115200.
- Stable NCP uses USART, as upstream stable does. Beta MG24/BM24 uses EUSART0,
  cross-checked against `origin/nerivec_v2025.6.2-pre5` at `f6a8909`.
- Enable the existing upstream `board_activity_led` linker wrapper and bind
  `BOARD_ACTIVITY_LED_INSTANCE` to `sl_led_board_activity` on PD02, active-low.
- Network capacities now follow upstream defaults; names retaining `Max` are
  historical filenames, not a promise to retain the old fork's larger limits.
- BM24 NCP retains main's CTUNE 92 pending confirmation; the nerivec NCP
  reference uses 140. Beta MGM24 uses the nerivec clock settings (CTUNE 140).

## Upstream resync — 2026-10-22

Merge upstream `adafdc2` (PR #227, release `v2026.09.17-beta2`). The base NCP
project now includes Nabu Casa's dynamic link key policy to fix direct joins
by Zigbee 4.0 routers without an install code. All five active TubeZB NCP
manifests follow upstream's patch override and report firmware 9.1.1.1.
Firmware version handling now applies the override at compile time and reads
packaging metadata from SDK headers, as upstream does. SDK/toolchain versions
remain unchanged. Existing TubeZB PTI and EUSART compatibility changes are retained.
Upstream stable remains `b45d978`, already present in the stable sync branch.

## PTI coordinator follow-up

Port the final PTI configuration from `pti_nonsense` (`aa5f7fe`) into all four
MGM24 PA/PB and BM24 NCP manifests. Include `rail_util_pti` and select UART mode
at 1,600,000 baud, with DOUT on PC04 and DFRAME on PC05. This is the PTI capture
baud rate; existing host EUSART baud rates remain unchanged. The MGM24PB variant
uses the same PTI routing and needs capture verification on hardware.

The user reports the previous firmware builds are running well. PTI capture
with these updated builds still needs hardware verification.

## Router changes and shipped baseline

The router reference is the user-confirmed shipped
`origin/nerivec_v2025.6.2-pre5`, not the older `router` / `BM24_router` branches.
All three manifests are carried forward: MGM24 hardware flow, MGM24 software
flow (`mgm24router`), and BM24 software flow. Preserve their EUSART0 routing,
460800 baud, PD02 LED, PA0 button, CTUNE 140, RSSI offset, network table sizes,
transmit power, and concentrator settings. Keep the shipped 64-byte serial
receive buffer. BM24 router metadata now correctly says `sw_flow`, matching
its actual EUSART configuration.

The shipped endpoint/cluster configuration is copied into a TubeZB-specific
ZAP override. Beta adds upstream's KEEPALIVE_CLUSTER fix without replacing
those shipped endpoint definitions. Add the missing concentrator, RSSI, and
identify components to the upstream generic router template as needed.

The old router callbacks are moved into an optional `tubeszb_router` extension.
The LED indicates commissioning/network-up, and turns off on network-down or
failed steering. Retain the existing short/long button actions. Small event
handling fixes deactivate fired events, retry immediate steering failures,
cancel retries on network-up, and handle a long button press across the
16-bit timer wrap. Radio calibration remains provided by upstream's app.
The inherited Basic reset callback still reboots into the bootloader, as in
the shipped reference; it has not been redefined as an NVM erase operation.

## Validation and remaining work

- Parsed and checked all active TubeZB manifests in both drafts (30 total:
  16 stable and 14 beta), including OpenThread and bootloaders. All SDK and
  compiler versions match their corresponding upstream manifests.
- Checked bootloader pin/activation settings against the original fork and
  OpenThread routing, patch paths, and watchdog extension selection.
- Checked inherited component merges/removals, extension locations, metadata
  versus serial baud, original NCP pin routing, absence of obsolete USART
  settings in EUSART manifests, and MGM12 exclusion from beta.
- Compared every shipped router manifest C define against the draft: preserved.
- Python lint and formatting checks pass with each branch's pinned Ruff version
  (stable 0.7.3; beta 0.16.1), using repository settings and no user-global rules.
- Host-compiled the actual router callbacks with warnings treated as errors.
  LED/join/retry, restored-network startup, short/long button presses, and
  timer wrap tests pass. Run `python3 tests/test_tubeszb_router.py` with a host C
  compiler. These mocks do not validate Silicon Labs API or linker compatibility.
- GitHub Actions completed successfully for all 14 beta firmware targets,
  including artifact uploads and aggregate manifest generation. See BUILD-RESULTS.md.
- Local SLC was unblocked by removing quarantine and using a temporary Intel Java
  runtime, but local SDK selection remained problematic. CI used the matching
  upstream container and built successfully.
- Before release: verify serial startup and host integration, then test
  LED/join/button behavior on hardware.
- Confirm MGM21's exact 2023 part, PD02 availability on all older PA/PB board
  revisions, and BM24 NCP CTUNE. No hardware testing or flashing was performed.

## Manual workflow selection

`build.yaml` follows this branch's upstream workflow, retaining manual dispatch.
The `manifest_glob` input is now applied to the build matrix. For example,
`manifests/tubeszb/*zigbee_router.yaml` selects the three router variants.
A blank input (and automatic push/PR runs) still selects all active YAML manifests;
`.yaml.disabled` files are excluded. An unmatched glob fails clearly.
All firmware types passed CI compilation. Hardware validation is still pending. Targeted GitHub Actions runs completed successfully; see BUILD-RESULTS.md.

## OpenThread and bootloader migration

All three existing MG24 PA/PB and BM24 bootloaders now match the upstream
channel's SDK and toolchain. Preserve USART0, 115200 baud, hardware flow control,
PA6 TX / PA5 RX / PA7 CTS / PA8 RTS, and active-low PA0 activation. Correct the
copied Yellow/MGM240PB display names. Do not import ZBT-2's dual GPIO activation
or its board-specific customer version override into these single-button boards.

MGM24 OpenThread is migrated to EUSART0 using the nerivec PA6/PA5/PA7/PA8 routing;
the obsolete main manifest incorrectly selected port B for CTS/RTS. Add matching
BM24 and MGM24PB OpenThread manifests. All use upstream's 460800 baud rate and
512-byte receive buffer. This preserves main's MGM24 baud rate but differs from
nerivec's 921600; configure OTBR for 460800 when testing these builds.

Preserve the nerivec OpenThread oscillator configuration (CTUNE 140) and RSSI
offset. The new PB OpenThread variant uses the same configuration and needs
board validation. Beta includes upstream's watchdog component, 4096-byte NCP
TX buffer, GP receive-filter patch, and both EUSART transmit-timeout patches.
Stable tracks its upstream OpenThread settings without backporting beta-only
features. ZBT-2 RGB/accelerometer/reset-button drivers and its product identity
are not applicable to TubeZB and are omitted.

No new MGM12/MGM21 bootloader or OpenThread target has been invented; this update
covers the existing bootloader targets and MG24/BM24 OpenThread hardware whose
routing is available. MGM12 remains on stable Zigbee NCP only.

## Router manufacturer and model attributes

Set the Basic server cluster's ManufacturerName (0x0004) and ModelIdentifier
(0x0005) defaults in the ZAP configuration, matching Nabu Casa's router approach.
Manufacturer is `TubesZB`. Both MGM24 UART variants report
`MGM24`; BM24 reports `BM24`.
The BM24 manifest selects its own ZAP configuration, identical to MGM24 apart
from the model default. These firmware defaults require no manufacturing-token
programming. Endpoints and all other cluster settings are preserved.

Coordinator XNCP model strings also use only the hardware model: `MGM12`,
`MGM21`, `MGM24`, `MGM24PB`, or `BM24`. Manufacturer remains `TubesZB`.
Manifest labels and output filenames retain revision/baud/flow-control details.

Configuration files supplied by a manifest replace a matching base-project
`file_id` (or path when no ID is provided). This lets the BM24 ZAP override the
base ZAP without SLC reporting duplicate `zcl_config.zap` definitions.

## Experimental personal MGM24PB router

Add `tubeszb-mgm24PB-zigbee_router.yaml` for the user's few MGM240PB32VNN
boards, with Basic model `MGM24PB` and manufacturer `TubesZB`. Existing PB
coordinator firmware also reports `MGM24PB`. Use the current MGM24 hardware-flow
router as the reference: EUSART0, 460800 baud, PA6/PA5/PA7/PA8 UART, PD2 LED,
PA0 button, and CTUNE 140, matching the existing PB manifest hardware routing.
This is a personal experimental target, not a hardware-tested product.
Previous PB firmware reportedly did not work; compilation does not resolve
that history. The PB part and matching PB bootloader must be used when testing.

Identity and experimental PB validation: 15/15 firmware targets passed
across the full-target and additional PB builds. Compiled router Basic defaults
and coordinator XNCP identity strings were checked. See BUILD-RESULTS.md for
source commits and download links. Hardware behavior remains unverified for PB.


## Button and remote bootloader behavior clarified — 2026-10-23

Keep the joined-network short-press source-route discovery toggle. First press
disables discovery and the next enables it; this does not disable normal packet
forwarding. Keep the Basic-cluster Reset to Factory Defaults callback entering
the bootloader: this is intentional remote access, including from Z2M. A host
regression test now checks that callback as well as the existing button toggle.

The downloaded router ELFs for all three branches (four router variants each),
plus the PB cache-fix ELF, contain the version handler, bootloader info/reboot
handlers, and both source-route toggle messages. The shared router project
includes upstream `router_bootloader_cli`. No executable firmware changes were
needed for this clarification.

Universal Silabs Flasher's router protocol sends `version` and `bootloader reboot`:
https://github.com/NabuCasa/universal-silabs-flasher/blob/main/universal_silabs_flasher/router.py
Our router UART is 460800 baud and bootloader UART is 115200. Upstream's default
router probe is 115200, so specify `router:460800` when probing these applications.
The current flasher also waits for a `Gecko Bootloader` banner at the application
baud before switching to bootloader probing. The differing baud rates can cause
that wait to time out despite successful reboot. End-to-end automatic flashing
has not been hardware-tested. If this occurs, reconnect to the bootloader at
115200 and flash with `--probe-methods bootloader:115200`, or explicitly issue
`bootloader reboot` from a 460800-baud console, close it, and use that bootloader
probe. The Basic command offers another intentional route into the bootloader.


## Remove customer source-route controls — 2026-10-23

Supersedes the earlier instruction to keep the joined-network button toggle.
Remove its state, source-route API calls/header, and the TubeZB router manifests'
optional concentrator component and concentrator-specific overrides. Retain
standard source-route support from the upstream shared project. No custom
cluster hook is needed now. Joined short presses now do nothing. Preserve
long presses, joining/retry behavior, LED behavior, Basic-command bootloader
entry, and serial bootloader commands. See ROUTER-BEHAVIOR.md for the exact
button and LED behavior, including BM24's working LED and MGM24's missing trace.


## Joining LED feedback — 2026-10-23

Blink PD02 at 500 ms on / 500 ms off while a network-steering attempt is active.
Stop the blink timer and show solid on when joined, or off after a failure or
NETWORK_DOWN while waiting for the next automatic attempt. Keep button and
commissioning timing unchanged: an unjoined startup starts joining immediately,
and a successful leave schedules joining after ten seconds. The host test now
checks blink cadence, failure cleanup, and the transition to solid on.


## PB button reliability — 2026-10-25

The user confirms PA0 is switched to ground with no external pull-up. The old
manifest used the SDK's unpulled input default and raw interrupt mode. That
leaves the released line floating. The old callback also overwrote the hold
start on every pressed notification and accepted releases without a tracked
press, explaining mechanisms for missed holds and phantom long presses. The
console excerpt contains repeated unsolicited button actions and steering
requests while an SDK scan is active; it later joins successfully. It does not
record raw GPIO timing, so electrical noise/bounce details remain unmeasured.

All four router variants now enable the internal filtered pull-up, active-low
polarity, and SDK POLL_AND_DEBOUNCE mode (five bits), sampled by a single 10 ms
application event. Handle only debounced transitions; repeated pressed samples
do not reset timing. Ignore unmatched releases and the first release of a button
held at boot. Use 32-bit sleeptimer ticks instead of the 16-bit millisecond
counter. Keep the established release-time actions, joining LED, automatic
joining/retry policy, and Basic/serial bootloader access. Hardware testing is
needed to confirm the observed PB issue is resolved.

The user subsequently confirmed that the PA0-to-ground button wiring, without
an external pull-up, is the same across all devices. The shared fix therefore
applies to all four router variants. All twelve router build jobs passed across
the three branches; see BUILD-RESULTS.md for the source commits and artifacts.
