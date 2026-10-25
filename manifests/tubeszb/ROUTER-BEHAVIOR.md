# TubeZB router button and LED behavior

Updated 2026-10-25. Applies to MGM24, MGM24 SW-flow/router, BM24, and
experimental MGM24PB router manifests on this branch.

The active-low PA0-to-ground button uses the internal filtered pull-up;
no external pull-up is required. The SDK debounce driver is sampled every
10 ms with five debounce bits (about 50–60 ms of stable input per transition).
The button acts on **debounced release**. A hold strictly longer than 5,000 ms
between debounced press/release transitions is a long press; exactly 5,000 ms
is short. Timing is quantized by polling and application scheduling. The network
state when the release is processed determines the action. A button held during
startup must be released and pressed again before it can trigger an action.
Repeated samples in the same state and releases without a tracked press are
ignored. Hold duration uses wrap-safe subtraction of the 32-bit sleeptimer tick
counter, eliminating the former 65.536-second millisecond-counter limitation.

| Network state | Short press (up to 5 seconds) | Long press (over 5 seconds) |
| --- | --- | --- |
| Joined | No action | Request a network leave. Once NETWORK_DOWN arrives, joining is scheduled after 10 seconds. |
| Unjoined (NO_NETWORK) | Toggle the pending application joining/retry event | Enter the bootloader |
| Other/transitional states | No action | No action |

A leave is requested, not a full token/NVM factory reset. To enter the
bootloader from a joined device using the button, first long-press/release to
leave, then long-press/release again while unjoined. The second action depends
on still being unjoined when its event runs. There is no LED hold-progress cue.
The Basic-cluster Reset to Factory Defaults command intentionally enters the
bootloader, preserving remote access from Z2M. Serial `bootloader reboot` also
enters the bootloader. These entry paths were not changed.

On startup, a joined device lights its status LED; an unjoined device schedules
joining immediately. The LED is a single active-low output on PD02:

| Event/state | LED |
| --- | --- |
| Joined at startup, or NETWORK_UP | Steady on |
| Joining attempt starts | Immediately on, then toggles every 500 ms (one full blink per second) |
| Steering start fails or steering completion reports failure | Off; retry scheduled after 10 seconds |
| NETWORK_DOWN | Off; joining scheduled after 10 seconds |
| Next retry starts | Blinking resumes |
| Joined short press | Unchanged |
| Unjoined short press | No direct LED change |

Joining blinks at 500 ms on / 500 ms off. Blinking stops on network-up,
network-down, or a failed joining attempt. There is no traffic indication or
Identify-command LED feedback. There is no application-defined bootloader
LED pattern. BM24 LEDs should visibly follow these states. The current MGM24
PCBs have a confirmed missing LED trace, so their physical LEDs cannot show
the firmware's PD02 output.

The unjoined short press toggles only the pending application event. It does
not abort an SDK scan already in progress; during an active scan it can queue
another attempt. Cancelling a pending event does not permanently disable
joining: later failure/NETWORK_DOWN callbacks can schedule it again. This
existing limitation is documented rather than changing commissioning policy
as part of removing source-route controls.

The custom joined-button source-route discovery toggle and optional
concentrator component/configuration have been removed. Standard source-route
support in Nabu Casa's shared router project and ordinary Zigbee forwarding
remain. No custom cluster hook has been added.
