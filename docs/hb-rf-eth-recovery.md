# Optional HB-RF-ETH stack recovery

This opt-in service is a contribution proposal for recovering a previously
initialized, dual-protocol RPI-RF-MOD connected through HB-RF-ETH after a network
interruption. It is disabled by default. Enabling it permits RF daemon restarts
and, when the interface registry needs repair, a ReGaHss restart. Such restarts
interrupt RF communication and may interrupt running automations.

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

This requires a current OpenCCU image containing `S49InitInterfaces`, the RF
services and their Monit checks. It is not a script-only update for older images:
older releases generated the interface list in `S49hs485d`. Current Monit also
has `rfdDevice` and `HMIPServerDevice`, which must be paused during recovery.
No kernel driver patch or gateway firmware change is included. Recovery does
not diagnose or fix the underlying Ethernet interruption.

## Recovery transaction

1. Wait until normal system startup has finished. Check the explicit enable
   marker, gateway configuration and supported hardware identity.
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
   with `S49InitInterfaces`, invalidate `/var/tmp/api_ipc.cache` and recreate the
   multimacd endpoints. Start rfd and HMIPServer. Invalidate the HmIP readiness
   marker before starting HMIPServer, so stale readiness cannot count as success.
7. Restart ReGaHss only when the old interface registry or API cache was
   incomplete. Restore the original Monit checks and verify that previously
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

## Enable, disable and migration

Use only an image built with this change. Remove or disable any previous custom
recovery hook first, while its recovery transaction is idle. This service refuses
to start if `/etc/config/rc.d/hb-rf-eth-recovery` is still executable, preventing
two recovery implementations from controlling the same RF stack.

To enable:

```sh
touch /etc/config/hb_rf_eth_recovery
/etc/init.d/S98HBRFEthRecovery start
```

To stop and disable:

```sh
/etc/init.d/S98HBRFEthRecovery stop
rm -f /etc/config/hb_rf_eth_recovery
```

The enable marker persists across normal restarts. The worker exits if that
marker or the gateway configuration is removed. It refuses to signal a stale
PID unless `/proc/<pid>/cmdline` identifies its own worker. Concurrent starts
are serialized by the kernel lock. A normal start does not alter healthy RF
services while the link remains connected.

## Review of the original field hook

The audited active source had SHA-256
`6a3071b048a45329266be2d5991c772fda0d18f2d011999f82b9e8d88d178c39`.
One active recovery hook and an older backup were found; the hook was launched
by `S98StartAddons`. The running system was inspected without changing its
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
| Interface rebuilding used `S49hs485d` | Current OpenCCU would not rebuild the registry | Use `S49InitInterfaces` |

Field logs showed both successful recoveries and an outage whose recovery was
suppressed by cooldown with no deferred attempt. These logs describe the
original hook; they do not constitute hardware validation of this proposal.
The transport root cause remains undetermined.

## Validation and outstanding work

Run the isolated BusyBox ash regression suite:

```sh
python3 scripts/testcases/runtime/test_hb_rf_eth_recovery.py -v
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

Before proposing a merge, discuss the approach in an upstream issue as required
by `CONTRIBUTING.md`, build an image, and test a controlled link interruption on
a non-critical installation. Include an outage inside cooldown, a failed
recovery, a worker interruption, boot/shutdown, and a disabled configuration.
Verify BidCos and HmIP communication and the restored Monit states. Local validation of this preparation passed: 29 recovery regression tests,
eight existing runtime-path/recovery-service tests, ShellCheck, BusyBox ash
syntax checks, YAML/Markdown/Python lint and whitespace checks. The revised
service has not been deployed or physically fault-tested on the audited hub.
A full image build and `make PRODUCT=rpi3 check` have not been run.
