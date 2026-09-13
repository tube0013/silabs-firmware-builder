# TubeZB stable integration draft

Branch: `codex/tubeszb-stable-sync`.

## Scope and upstream baseline

Based on the fork's `origin/main` (`db569a3`), merged with upstream stable
`b45d978`. NCP builds match upstream stable: Gecko SDK 4.5.0, firmware 7.5.1.0,
and GCC 12.2.1.20221205. This includes both MGM12 revisions; they remain on 7.5.x.
The router builds match upstream stable's separate Simplicity SDK 2025.6.2
selection, retaining the SDK used by the shipped nerivec router firmware.

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
- GitHub Actions completed successfully for all 16 stable firmware targets,
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
