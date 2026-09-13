# TubeZB stable integration draft

Branch: `codex/tubeszb-stable-sync`.

## Scope and upstream baseline

Based on the fork's `origin/main` (`db569a3`), merged with upstream stable
`b45d978`. NCP builds match upstream stable: Gecko SDK 4.5.0, firmware 7.5.1.0,
and GCC 12.2.1.20221205. This includes both MGM12 revisions; they remain on 7.5.x.
The router builds match upstream stable's separate Simplicity SDK 2025.6.2
selection, retaining the SDK used by the shipped nerivec router firmware.

This is Zigbee NCP/router preparation. Existing bootloader and OpenThread
manifests have not been migrated and still select older SDKs. Do not treat an
unfiltered build of every TubeZB manifest as validated by this work.
No branches have been pushed and no PRs have been opened.

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

- Parsed and checked all active Zigbee manifests in both drafts (18 total).
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
- Firmware generation/build is not yet verified. The local SLC installation
  was quarantined by macOS; quarantine was removed at the user's suggestion.
  A temporary Intel Java 17 runtime gets the Intel SLC 5.9.2 launcher running.
  The stable MGM24 router generation then fails with: `Cannot build an extension
  framework without a best-fit sdk`. No firmware compilation was reached.
  Local SDKs do not include the required Gecko 4.5.0 or Simplicity 2026.6.1
  NCP versions. SLC/SDK compatibility and selection must be resolved next.
- Before PR/release: build each targeted manifest with its exact SDK/toolchain,
  inspect generated UART/LED configs and XNCP symbols, verify serial startup
  and host integration, then test LED/join/button behavior on hardware.
- Confirm MGM21's exact 2023 part, PD02 availability on all older PA/PB board
  revisions, and BM24 NCP CTUNE. No hardware testing or flashing was performed.

## Manual workflow selection

`build.yaml` follows this branch's upstream workflow, retaining manual dispatch.
The `manifest_glob` input is now applied to the build matrix. For example,
`manifests/tubeszb/*zigbee_router.yaml` selects the three router variants.
A blank input (and automatic push/PR runs) still selects all active YAML manifests;
`.yaml.disabled` files are excluded. An unmatched glob fails clearly.
Legacy bootloader/OpenThread manifests remain unvalidated, so use a targeted
manual run while this integration is a draft. No GitHub Actions run was triggered.
