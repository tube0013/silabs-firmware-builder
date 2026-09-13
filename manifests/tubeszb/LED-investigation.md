# TubeZB PD02 LED investigation

Historical findings before migration. See [SYNC-NOTES.md](SYNC-NOTES.md) for
the current integration draft and user-confirmed shipped router baseline.

Investigated on 2026-09-13. No firmware was built or flashed in this investigation.

## Repository sync

Local main now includes Nabu Casa main at `c9fa1d6` and preserves the fork's
TubeZB manifests and manual workflow trigger. The only merge conflict was in
`.gitignore`; both sides' entries were retained.

GitHub's release API confirms the latest prerelease is `v2026.08.18-beta1`
(`11d8f3a`). It is already an ancestor of upstream main; main also contains
the router KEEPALIVE_CLUSTER fix and encrypted-GBL manifest fix. There is no
upstream branch named beta. Nothing was pushed to the fork.

## NCP: MGM24 2025 and BM-MG24B2

Both manifests create `simple_led` instance `board_activity`, with port D,
pin 2, and active-low polarity. The pin mapping agrees with the supplied
hardware information; polarity still requires hardware confirmation.

The installed Gecko SDK 4.4.6 source has `halStackIndicateActivity()` and
conditional discovery of `sl_led_board_activity`. Therefore a missing GPIO
definition is not established as the cause. However, upstream explicitly
introduced a linker wrapper to fix activity indication with `simple_led`
in commit `e85c1de` (PR #158). Neither TubeZB manifest enables that workaround.
This is the strongest software lead, pending a build and hardware test.

To enable the existing workaround, use the Yellow manifest as the reference:

```yaml
sdk_extension:
  - id: board_activity
    vendor: nabucasa
    version: 1.0.0

add_components:
  # Retain the existing simple_led instance and other components.
  - id: board_activity_led
    vendor: nabucasa
    package: board_activity

c_defines:
  BOARD_ACTIVITY_LED_INSTANCE: sl_led_board_activity
```

The wrapper is in `extension/board_activity_extension`. The NCP template
already exposes that extension through a symlink. Activity indication is
traffic-dependent, so an idle NCP need not illuminate continuously.

## Router: findings depend on the build branch

The fork's main had no TubeZB router manifests. Existing router configurations
were inspected directly on `origin/router` and `origin/BM24_router`, without
merging their older application source over current upstream.

- `origin/router` MGM24 manifest has no LED component or LED pin settings.
- `origin/BM24_router` MGM24 hardware-flow manifest also omits the LED.
  Its application's `SL_CATALOG_LED0_PRESENT` guard therefore makes its LED
  operations no-ops. Add `simple_led` instance `led0` with port D, pin 2,
  and the correct electrical polarity to address this configuration gap.
- `origin/BM24_router` BM24 hardware/software-flow manifests already create
  `led0` on PD02, active-low. The SDK's simple_led component contributes the
  `LED0` catalog entry, matching the application's guard. The application
  turns it on during commissioning and on network-up, and off on network-down
  or failed steering. No definite pin/instance mismatch was found for BM24.
  Check which exact firmware was flashed, joining state, and electrical polarity.

Current upstream's generic router `app.c` has no simple-LED status callbacks.
Porting old TubeZB router manifests alone will not restore that status behavior;
an optional TubeZB status component/callback implementation is also needed.

## Build compatibility and validation still needed

The sync brings Simplicity SDK 2026.6.1 and GCC 14.2.1.20241119, while the
TubeZB NCP manifests still select Gecko SDK 4.4.6 and GCC 12.2.1.20221205.
Those manifests need a separate migration before using the updated templates:
Zigbee define names, XNCP extensions, SDK/toolchain selection, and MG24 EUSART
settings must follow the new templates while preserving each board's UART
pins, baud rate, flow control, oscillator tuning, and memory limits.
The old TubeZB router manifests also target an older SDK (2024.6.2).

Only SDKs through 2025.6.3 were found in the local SimplicityStudio SDK folder;
the current 2026.6.1 SDK was not available there. No build or hardware success
is claimed. Before releasing, generate and inspect the LED config and component
catalog, confirm the NCP linker wrapper is enabled, build the selected variants,
then test PD02 on hardware at startup, while joining, after joining, and during
traffic. For BM24, a temporary steady on/off test distinguishes a software
state issue from polarity or electrical wiring.
