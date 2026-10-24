# Automatic HB-RF-ETH stack recovery

The recovery service is installed through the common OpenCCU rootfs overlay and
started automatically by `S98HBRFEthRecovery`. No add-on installation or enable
marker is required. Without an eligible HB-RF-ETH configuration it sleeps in the
background, rechecking eligibility every 30 seconds. It does not poll the RF
link, query Monit or change RF services while in standby.

When a supported gateway is detected, it activates monitoring and can recover
the RF stack after a network interruption. Recovery restarts the RF daemons and
ReGaHss to renew its event subscriptions. Such restarts interrupt RF
communication and may interrupt running automations.

## Problem and scope

The kernel driver reconnects the Ethernet transport, but userspace can retain
unusable RF connections or an incomplete interface registry. A connected sysfs
link does not establish that multimacd, rfd, HMIPServer and ReGaHss recovered.
A field recovery hook addressed this by reinitializing RF hardware and services.
This proposal ports that approach to the current init layout and addresses its
failure handling.

The supported combination is deliberately restricted to `HM_MODE=NORMAL`,
`RPI-RF-MOD` for both protocols, `/dev/raw-uart` for both device paths, and
`HB-RF-ETH@...` for both transport identifiers in `/var/hm_mode`. Other radios,
mixed USB/Ethernet installations, LAN gateway mode and safe mode are excluded.
A gateway that was never identified at boot, leaving no valid hardware identity
in `/var/hm_mode`, is outside this proposal. Guessing which radio should be
initialized would broaden the scope and risk resetting unrelated hardware.

Current images use `S49InitInterfaces` to rebuild the interface list. For
persistent test installations on older images, the script also accepts
`S49hs485d` when that script explicitly contains interface-list generation.
Current Monit has `rfdDevice` and `HMIPServerDevice`, which must be paused during
recovery. Older images can omit these two checks: only an explicit Monit
not-found response is accepted; connection errors still abort the transaction.
No kernel driver patch or gateway firmware change is included. Recovery does
not diagnose or fix the underlying Ethernet interruption.

## Recovery transaction

1. Wait until normal system startup has finished. Sleep in standby until the
   existing `/etc/config/hb_rf_eth` configuration and supported hardware identity
   are present. Recheck every 30 seconds, so late detection requires no restart.
   Return to standby if eligibility is lost. A safe-mode boot stays in standby
   for that worker's lifetime, even after OpenCCU removes its safe-mode marker.
2. Observe the link every two seconds. After a disconnection, require 30 seconds
   of continuous connectivity. Check the existing stack once at monitor startup.
3. Keep recovery pending across a five-minute cooldown and after failures.
   Cooldown uses monotonic uptime, so NTP corrections cannot postpone recovery.
4. Snapshot all relevant Monit states before changing any dependency. Journal
   the previously monitored checks and pause them, including enabled predicates
   and stale-device checks. Unknown Monit states abort service changes.
5. Stop HMIPServer, rfd and multimacd. Retain each original PID while verifying
   termination, because init scripts may remove PID files before exit. If a stop
   fails, avoid starting a duplicate and restore monitoring.
6. Run `S47InitRFHardware`, recheck the hardware identity, rebuild the registry
   with the matching init script, invalidate `/var/tmp/api_ipc.cache` and recreate the
   multimacd endpoints. Wait up to 30 additional seconds for hardware readiness,
   aborting that wait if the link drops. Start rfd only with ready hardware and
   an existing BidCos device node; this also guards partial-stop rollback paths.
   Start HMIPServer. Invalidate the HmIP readiness
   marker before starting HMIPServer, so stale readiness cannot count as success.
7. Restart ReGaHss after the RF stack is ready, even when the interface registry
   was already complete. A userspace RF restart can invalidate event
   subscriptions while leaving the XML intact and WebUI datapoints stale.
   On older images, retain and check the old ReGa PID through a separate stop
   before permitting start, because legacy init scripts can hide timeouts.
   Updated `S70ReGaHss` returns startup/shutdown failures, retains its PID file
   on a termination timeout, and aborts restart after a failed stop.
   Restore the original Monit checks and verify that previously
   monitored checks are `Monitored/OK`. Intentionally disabled checks remain
   outside the restoration journal.
8. Check the link, hardware, interfaces, process PIDs and HmIP readiness again.
   Only then clear the HB-RF-ETH transport alarm. Retain unrelated watchdog
   alarms, including HMIPServer restart alarms. Failures retain pending recovery;
   there is no automatic CCU reboot.

Init commands are limited to 360 seconds plus a ten-second termination grace.
An advisory lifetime lock prevents concurrent workers. It is closed in child
service commands so background RF daemons cannot keep it alive. BusyBox `flock`
is enabled in the image configuration. Failed Monit restoration retains its
journal under `/var/run` for another attempt or worker restart. A reboot clears
that volatile journal and normal OpenCCU boot establishes monitoring anew.

TERM/INT/HUP restore journaled monitoring through an exit trap after the current
bounded command completes. Stop waits for cleanup before returning. SIGKILL and
power loss cannot execute traps; a subsequent worker restores the retained
journal. Use syslog (`hb-rf-eth-recovery`) for diagnostics; no separate persistent
flash log is written.

## Automatic installation and migration

Use an OpenCCU image built with this change. The common `overlay/base` installs
`/bin/hb-rf-eth-recovery` and its executable SysV init hook. The standard boot
sequence launches one background worker on every normal image; no manual
installation, gateway-specific image or extra activation file is needed.

The worker reads OpenCCU's existing gateway configuration and detected hardware
identity. It remains asleep if no HB-RF-ETH is configured, hardware identification
is incomplete, or the radio combination is unsupported. Once eligibility is
established it activates without a restart. Configuration removal or switching
to another radio returns it to standby. Activation still requires 30 seconds of
stable link state before any pending recovery transaction.

Remove or disable any previous custom recovery hook first, while its transaction
is idle. An executable `/etc/config/rc.d/hb-rf-eth-recovery` keeps the built-in
worker in standby, preventing two implementations from controlling the same
RF stack. Removing that conflict is detected automatically on a later check.
The built-in worker uses a separate PID file so standby cannot overwrite the
legacy hook's worker identity.

For maintenance, stop the worker with:

```sh
/etc/init.d/S98HBRFEthRecovery stop
```

The normal boot sequence starts it again on the next boot. Standby sleeps are
interruptible so a stop request does not wait for the 30-second recheck period.
The worker refuses to signal a stale PID unless `/proc/<pid>/cmdline` identifies
its own worker. Concurrent starts are serialized by the kernel lock. An ordinary
activation leaves a healthy RF stack running while the link remains connected.

## Review of the original field hook

The audited active source had SHA-256
`6a3071b048a45329266be2d5991c772fda0d18f2d011999f82b9e8d88d178c39`.
One active recovery hook and an older backup were found; the hook was launched
by `S98StartAddons`. The original running system was inspected without changing its
configuration or restarting services. Its shell syntax check passed.

| Finding | Consequence | Proposal |
| --- | --- | --- |
| A cooldown return was followed by marking the link recovered | A second outage inside cooldown could remain unrepaired indefinitely; observed in field logs | Keep pending state until recovery succeeds |
| Cooldown used wall clock | Time corrections could distort retry timing | Use uptime |
| Hardware failure escalated to reboot | Persistent failure or a different radio could cause repeated full-system restarts | Restrict supported hardware and retry without reboot |
| Monit restoration deleted its journal even on failure | A later attempt could lose the original monitoring state | Retain failed entries |
| Monit state was read while dependencies were being changed | Dependent states could be mistaken for intentionally disabled states | Snapshot all checks first |
| Only selected process checks were paused | Current stale-device checks could race device recreation | Include dependency predicates and stale-device checks |
| Startup restored monitoring before checking for an existing worker | Duplicate starts could interfere with an active transaction | Restore only inside the locked worker |
| PID file and `kill -0` were the only worker identity checks | Parallel starts and PID reuse were insufficiently protected | Lifetime lock and command-line identity validation |
| Stop killed only the monitor, with no cleanup trap or wait | RF operations and monitoring restoration could race shutdown | Exit trap, bounded commands, awaited cleanup |
| Init script success and a readiness marker were trusted | Failed starts or stale readiness could be reported as recovered | Check saved stop PIDs, fresh readiness, stack and Monit health |
| Both link and HMIP restart alarms were cleared | Unrelated failure evidence could disappear | Clear only the verified transport alarm |
| Interface rebuilding used `S49hs485d` | Current OpenCCU would not rebuild the registry | Prefer `S49InitInterfaces`, with a checked fallback for older images |

Field logs showed both successful recoveries and an outage whose recovery was
suppressed by cooldown with no deferred attempt. These logs describe the
original hook; they do not constitute hardware validation of this proposal.
The transport root cause remains undetermined.

## Validation and outstanding work

Run the isolated BusyBox ash regression suite:

```sh
python3 scripts/testcases/runtime/test_hb_rf_eth_recovery.py -v
python3 scripts/testcases/runtime/test_rega_init.py -v
shellcheck -e SC3010,SC3014,SC3057,SC3036,SC3028,SC3020 \
  buildroot-external/overlay/base/bin/hb-rf-eth-recovery \
  buildroot-external/overlay/base/etc/init.d/S98HBRFEthRecovery
```

The tests exercise real shell functions with isolated paths, a simulated clock,
Monit state changes and service failures. They cover pending retries, flapping,
interface/cache repair, restoration failures, stale readiness, unsuccessful
termination, unsupported hardware, stale worker PIDs and actual lock contention.
Real worker start/stop and signal cleanup are also exercised. They do not
reset a radio or prove RF packet exchange. CI runs the regression
suite alongside existing checks.

Local validation passed: 47 recovery regression tests plus seven ReGa init tests, eight existing
runtime-path/recovery-service tests, ShellCheck, BusyBox ash syntax checks,
YAML/Markdown/Python lint and whitespace checks. All 59 Python test/helper
functions have docstrings. Regression coverage includes delayed hardware,
bounded timeout, missing nodes, another link loss during the wait, and guarded
rfd startup in both the normal path and partial-stop rollback.

### Cable interruption test

A physical cable interruption was performed on an RPI-RF-MOD / HB-RF-ETH OVA
installation on 2026-10-24, before the readiness-guard follow-up. Times below
are Europe/Berlin:

| Event | Time |
| --- | --- |
| Driver detects the lost link | 14:53:06 |
| Driver reconnects after the cable is restored | 14:53:53 |
| Recovery begins after continuous link stability | 14:54:25 |
| Recovery and Monit verification complete | 14:55:42 |

The interruption lasted approximately 47 seconds. Recovery finished 109 seconds
after reconnection, including the stability window. Read-only
`listBidcosInterfaces` calls for BidCos and HmIP both reported `CONNECTED=1`,
the transport watchdog was false, all restored Monit checks were OK, and the
CCU did not reboot. No actuator command was issued.

### Readiness-guard follow-up on the CCU

The follow-up source was deployed persistently after isolated tests on the
CCU's own shell. The tests simulated delayed and missing nodes without removing
real device nodes or changing the real RF configuration. They verified that
missing devices skip rfd startup and failed recovery retains its failure/alarm
state while restoring Monit. The real `rfd.conf` checksum was unchanged across
these isolated tests.

A full controlled recovery with the revised code then ran from 15:07:02 to
15:08:20 Europe/Berlin on the same date. It completed successfully, restored all
previous Monit checks and restarted the normal background worker. Subsequent
read-only RPC checks again reported both RF interfaces connected and the
transport watchdog false. This exercises real RF-stack reinitialization;
the missing-node scenarios remain isolated failure-injection tests.

Before merging, validate an image build and remaining scenarios such as an
outage inside cooldown, a worker interruption and boot/shutdown on the target
image. Discuss the approach as required by `CONTRIBUTING.md`. A full image build
and local `make PRODUCT=rpi3 check` have not been run. Individual actuator
operation and the physical missing-node failure case have not been tested.

### ReGa datapoint verification

A subsequent device-level check exposed a gap in the original validation:
a temperature sensor's direct HmIP RPC value was 26.4 degrees C, but ReGa still
held 21.5 degrees C with a timestamp of 01:15:32. Thus the WebUI was stale even
though the adapter reported connected and Monit was healthy. This was not
caught by an interface-file completeness check.

On 2026-10-24, renewing ReGa alone from 15:32:41 to 15:32:55 Europe/Berlin restored
the current value without restarting the RF daemons. A later spontaneous update
to 24.9 degrees C was observed through both direct HmIP RPC and ReGa at 15:34:12.
Home Assistant also received the renewed temperature readings. The recovery
now renews ReGa after every successful RF reinitialization, with regression
coverage for a complete registry and a failed ReGa restart. Adapter readiness
must not be described as proof that all end devices have resumed reporting;
configuration-pending devices require separate observation.

### ReGa timeout and process-replacement follow-up

The native `S70ReGaHss` tests execute the actual wait loops, stop/start functions
and command dispatcher with isolated process fixtures. They cover both timeout
paths, PID-file retention, launcher failures in normal/debug mode, and restart
ordering. Recovery tests separately verify that a legacy init script deleting
its PID file cannot hide a still-running original ReGa process.

On 2026-10-24, seven isolated init scenarios and five isolated recovery scenarios
passed in the CCU's own shell, without touching real device nodes or killing
real daemons for failure injection. The real `rfd.conf` checksum stayed unchanged.
The revised recovery worker was installed persistently with a backup.

A full recovery using the deployed worker's functions and the older firmware's
stock init scripts passed from 16:00:14 to 16:01:44 Europe/Berlin. The fixed
native init script was additionally exercised live from staging from 16:02:02
to 16:02:15: the old ReGa PID exited, a different PID started, and the RF daemon
PIDs did not change during this init-only test. The firmware rootfs remains
read-only and unchanged; the persistent worker's PID guard protects that older
stock init. Future built images receive the fixed native init script.

Direct HmIP RPC, ReGa and Home Assistant all reported 22.0 degrees C for the
selected temperature sensor afterward. Monit was healthy, its journal was clear,
and one background worker resumed. Additional power datapoints were still
awaiting their first post-restart values at the initial checks; this test does
not establish that every end device or actuator is fully verified. Three local
OpenCCU-Base installation checks also passed.
