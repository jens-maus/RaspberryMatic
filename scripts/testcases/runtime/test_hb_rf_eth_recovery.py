#!/usr/bin/env python3
"""Execute recovery failure scenarios in an isolated BusyBox ash fixture."""
from pathlib import Path
import shutil
import subprocess
import tempfile
import time
import unittest

ROOT = Path(__file__).resolve().parents[3]
SCRIPT = ROOT / "buildroot-external/overlay/base/bin/hb-rf-eth-recovery"
BUSYBOX = shutil.which("busybox")
FLOCK = shutil.which("flock")


@unittest.skipUnless(BUSYBOX, "BusyBox is required for target-shell tests")
class RecoveryTests(unittest.TestCase):
    """Validate recovery policy, service ordering and worker lifecycle."""

    def setUp(self):
        """Build isolated fixtures and load the target shell functions."""
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.work = Path(self.tmp.name)
        self.init = self.work / "init"
        self.init.mkdir()
        for name in ("S47InitRFHardware", "S49InitInterfaces", "S60multimacd",
                     "S61rfd", "S62HMServer", "S70ReGaHss"):
            item = self.init / name
            item.write_text("#!/bin/sh\nexit 0\n")
            item.chmod(0o755)
        # Replace filesystem roots in the test copy only. Production exposes
        # no environment switch that could redirect root service operations.
        source = SCRIPT.read_text().rsplit('\ncase "${1:-}" in', 1)[0]
        source = source.replace("/etc/init.d/", str(self.init) + "/")
        source = source.replace("/var/run/", str(self.work) + "/")
        source = source.replace("/etc/config/safemode",
                                str(self.work / "safemode"))
        source = source.replace("/var/status/startupFinished",
                                str(self.work / "startup"))
        source = source.replace("/dev/mmd_bidcos", "/dev/null")
        source = source.replace("/dev/mmd_hmip", "/dev/null")
        self.lib = self.work / "lib.sh"
        self.lib.write_text(source)
        self.setup = """
. ./lib.sh
exec 9>./lock
GATEWAY=./gateway LEGACY=./legacy
MODE=./mode LINK=./link INTERFACES=./interfaces CACHE=./cache READY=./ready
WAIT=1
log() { printf '%s\\n' "$*" >>./events; }
sleep() { :; }
printf gateway >"$GATEWAY"
printf 1 >"$LINK"
"""
        self.write_mode()
        (self.work / "interfaces").write_text(
            "<name>BidCos-RF</name>\n<name>HmIP-RF</name>\n")

    def write_mode(self, radio="RPI-RF-MOD", transport="HB-RF-ETH@gateway"):
        """Write a supported or deliberately excluded RF hardware identity."""
        (self.work / "mode").write_text(
            "HM_MODE=NORMAL\n"
            f"HM_HMRF_DEV={radio}\nHM_HMIP_DEV={radio}\n"
            "HM_HMRF_DEVNODE=/dev/raw-uart\nHM_HMIP_DEVNODE=/dev/raw-uart\n"
            f"HM_HMRF_DEVTYPE={transport}\nHM_HMIP_DEVTYPE={transport}\n")

    def shell(self, body):
        """Run an isolated scenario in BusyBox ash and require success."""
        result = subprocess.run([BUSYBOX, "ash", "-c", self.setup + body],
                                cwd=self.work, capture_output=True, text=True,
                                timeout=10)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        return result.stdout

    def test_uses_existing_gateway_config_without_opt_in(self):
        """Uses existing gateway config without opt in."""
        self.shell('enabled || exit 1; : >"$GATEWAY"; enabled && exit 2; '
                   'rm "$GATEWAY"; ! enabled')

    def test_no_gateway_sleeps_without_touching_rf_or_monit(self):
        """No gateway sleeps without touching rf or monit."""
        self.shell("""
rm "$GATEWAY"
ACTIVE=0
supported() { touch ./unexpected; }
monitor_step() { touch ./unexpected; }
monit_command() { touch ./unexpected; }
sleep() { echo "$1" >./delay; }
monitor_cycle
[ "$ACTIVE" = 0 ] && [ "$(cat ./delay)" = "$IDLE_POLL" ] &&
  [ ! -e ./unexpected ]
""")

    def test_gateway_added_after_start_activates_without_restart(self):
        """Gateway added after start activates without restart."""
        self.shell("""
rm "$GATEWAY"
ACTIVE=0
stack_ready() { return 0; }
monitor_step() { touch ./active; }
monitor_cycle
[ ! -e ./active ] || exit 1
printf gateway >"$GATEWAY"
monitor_cycle
[ "$ACTIVE" = 1 ] && [ -e ./active ]
""")

    def test_gateway_removal_returns_active_worker_to_standby(self):
        """Gateway removal returns active worker to standby."""
        self.shell("""
ACTIVE=1 WAS_UP=1 PENDING=1
rm "$GATEWAY"
monitor_step() { touch ./unexpected; }
monitor_cycle
[ "$ACTIVE" = 0 ] && [ "$PENDING" = 0 ] && [ "$WAS_UP" = 0 ] &&
  [ ! -e ./unexpected ]
""")

    def test_unsupported_hardware_stays_idle_until_detected(self):
        """Unsupported hardware stays idle until detected."""
        self.shell("""
ACTIVE=0
cp "$MODE" ./saved_mode
: >"$MODE"
stack_ready() { return 0; }
monitor_step() { touch ./active; }
monitor_cycle
[ "$ACTIVE" = 0 ] && [ ! -e ./active ] || exit 1
mv ./saved_mode "$MODE"
monitor_cycle
[ "$ACTIVE" = 1 ] && [ -e ./active ]
""")

    def test_unhealthy_stack_is_pending_on_automatic_activation(self):
        """Unhealthy stack is pending on automatic activation."""
        self.shell("""
ACTIVE=0
stack_ready() { return 1; }
monitor_step() { [ "$PENDING" = 1 ] || exit 1; }
monitor_cycle
[ "$ACTIVE" = 1 ] && [ "$PENDING" = 1 ]
""")

    def test_safe_boot_stays_idle_after_boot_removes_marker(self):
        """Safe boot stays idle after boot removes marker."""
        self.shell("""
touch ./safemode
sleep() { rm -f ./safemode; touch ./startup; }
monitor_cycle() { touch ./unexpected; exit 1; }
idle_wait() { touch ./idle; exit 0; }
run
""")
        self.assertTrue((self.work / "idle").exists())
        self.assertFalse((self.work / "unexpected").exists())

    def test_refuses_parallel_legacy_addon(self):
        """Refuses parallel legacy addon."""
        self.shell('touch "$LEGACY"; chmod +x "$LEGACY"; ! enabled')

    def test_supported_radio(self):
        """Supported radio."""
        self.shell("supported && hardware_ready")

    def test_other_radio_is_excluded(self):
        """Other radio is excluded."""
        self.write_mode("HM-MOD-RPI-PCB")
        self.shell("! supported")

    def test_local_radio_is_excluded(self):
        """Local radio is excluded."""
        self.write_mode(transport="GPIO")
        self.shell("! supported")

    def test_removed_mode_does_not_reuse_previous_values(self):
        """Removed mode does not reuse previous values."""
        self.shell('supported || exit 1; : >"$MODE"; ! supported')

    def test_missing_interface_or_stale_cache_is_detected(self):
        """Missing interface or stale cache is detected."""
        self.shell('hardware_ready || exit 1; '
                   'printf VirtualDevices >"$CACHE"; '
                   'hardware_ready && exit 2; rm "$CACHE"; '
                   'printf "<name>HmIP-RF</name>" >"$INTERFACES"; '
                   '! hardware_ready')

    def test_link_requires_exact_connected_value(self):
        """Link requires exact connected value."""
        self.shell('link_up || exit 1; printf 10 >"$LINK"; ! link_up')

    def test_cooldown_retains_pending_recovery(self):
        """Cooldown retains pending recovery."""
        self.shell("""
NOW=100 WAS_UP=1 PENDING=1 UP_SINCE=0 LAST_ATTEMPT=0
uptime_seconds() { echo "$NOW"; }
recover() {
  [ $((NOW-LAST_ATTEMPT)) -ge "$COOLDOWN" ] || return 1
  echo recovered >>./calls
}
monitor_step
[ "$PENDING" = 1 ] && [ ! -e ./calls ] || exit 1
NOW=301
monitor_step
[ "$PENDING" = 0 ] && [ "$(cat ./calls)" = recovered ]
""")

    def test_failed_recovery_is_retried_without_new_transition(self):
        """Failed recovery is retried without new transition."""
        self.shell("""
NOW=100 WAS_UP=1 PENDING=1 UP_SINCE=0 COUNT=0
uptime_seconds() { echo "$NOW"; }
recover() { COUNT=$((COUNT+1)); [ "$COUNT" -gt 1 ]; }
monitor_step
[ "$PENDING" = 1 ] || exit 1
monitor_step
[ "$PENDING" = 0 ] && [ "$COUNT" = 2 ]
""")

    def test_flapping_link_restarts_stability_window(self):
        """Flapping link restarts stability window."""
        self.shell("""
NOW=100 WAS_UP=1 PENDING=0 UP_SINCE=0
uptime_seconds() { echo "$NOW"; }
recover() { touch ./recovered; }
printf 0 >"$LINK"; monitor_step
NOW=110; printf 1 >"$LINK"; monitor_step
NOW=139; monitor_step
[ ! -e ./recovered ] || exit 1
NOW=140; monitor_step
[ -e ./recovered ]
""")

    def test_snapshot_precedes_dependency_changes(self):
        """Snapshot precedes dependency changes."""
        self.shell("""
SERVICES="parent child disabled"
monit_state() {
  if [ "$1" = disabled ] || [ -e ./paused ]; then
    echo 'monitoring status Not monitored'
  else echo 'monitoring status Monitored'; fi
}
monit_command() { [ "$1" != unmonitor ] || touch ./paused; }
pause_monit || exit 1
[ "$(cat "$JOURNAL")" = "$(printf 'parent\\nchild')" ]
""")

    def test_unavailable_monit_aborts_before_services_change(self):
        """Unavailable monit aborts before services change."""
        self.shell("""
monit_state() { return 1; }
service_action() { touch ./unsafe; }
if recover; then exit 1; fi
[ ! -e ./unsafe ]
""")

    def test_failed_restore_retains_journal_and_preserves_disabled(self):
        """Failed restore retains journal and preserves disabled."""
        self.shell("""
printf 'parent\\nchild\\n' >"$JOURNAL"
monit_command() { echo "$*" >>./actions; [ "$2" != child ]; }
wait_monitor() { return 0; }
restore_monit && exit 1
[ "$(cat "$JOURNAL")" = child ] || exit 2
! grep -q disabled ./actions || exit 3
monit_command() { return 0; }
restore_monit && [ ! -e "$JOURNAL" ]
""")

    def transaction(self, failure="", tail=""):
        """Run a recovery transaction with controllable service failures."""
        self.shell("""
SERVICES="multimacdEnabled rfdEnabled multimacd rfd HMIPServer ReGaHss"
SERVICES="$SERVICES rfdDevice HMIPServerDevice"
monit_state() { echo 'monitoring status Monitored'; }
monit_command() { return 0; }
wait_monitor() { return 0; }
stop_process() { echo "$1 stop" >>./actions; return 0; }
service_action() { echo "$*" >>./actions; touch "$READY"; return 0; }
process_running() { return 0; }
clear_link_alarm() { touch ./cleared; }
uptime_seconds() { echo 1000; }
""" + failure + "\n" + tail)

    def test_success_clears_alarm_after_stack_verification(self):
        """Success clears alarm after stack verification."""
        self.transaction(
            tail='recover && [ -e ./cleared ] && [ ! -e "$JOURNAL" ]')

    def test_lost_link_during_recovery_does_not_clear_alarm(self):
        """Lost link during recovery does not clear alarm."""
        self.transaction('service_action() { touch "$READY"; '
                         'printf 0 >"$LINK"; }',
                         'if recover; then exit 1; fi; [ ! -e ./cleared ]')

    def test_stale_hmip_ready_marker_is_not_success(self):
        """Stale hmip ready marker is not success."""
        self.transaction('touch "$READY"; service_action() { return 0; }',
                         'if recover; then exit 1; fi; [ ! -e ./cleared ]')

    def test_unhealthy_hmip_monit_keeps_alarm(self):
        """Unhealthy hmip monit keeps alarm."""
        self.transaction('wait_monitor() { [ "$2" != healthy ] || '
                         '[ "$1" != HMIPServer ]; }',
                         'if recover; then exit 1; fi; [ ! -e ./cleared ]')

    def test_hardware_failure_restores_monit_without_reboot(self):
        """Hardware failure restores monit without reboot."""
        self.transaction('service_action() { echo "$*" >>./actions; '
                         'touch "$READY"; [ "$1" != S47InitRFHardware ]; }',
                         'if recover; then exit 1; fi; '
                         '[ ! -e "$JOURNAL" ] && [ ! -e ./cleared ]')

    def test_cannot_stop_daemon_does_not_start_duplicate(self):
        """Cannot stop daemon does not start duplicate."""
        self.transaction('stop_process() { return 1; }',
                         'if recover; then exit 1; fi; '
                         '[ ! -e ./actions ] && [ ! -e ./cleared ]')

    def test_interface_repair_reloads_rega_and_invalidates_cache(self):
        """Interface repair reloads rega and invalidates cache."""
        self.transaction('printf VirtualDevices >"$CACHE"',
                         'recover && [ ! -e "$CACHE" ] && '
                         'grep -q "S70ReGaHss restart" ./actions')

    def test_healthy_registry_avoids_rega_restart(self):
        """Healthy registry avoids rega restart."""
        self.transaction(tail='recover && ! grep -q S70ReGaHss ./actions')

    def test_deleted_pid_file_does_not_prove_termination(self):
        """Deleted pid file does not prove termination."""
        self.shell("""
printf '%s\\n' "$$" >./rfd.pid
process_running() { return 0; }
service_action() { rm -f ./rfd.pid; }
if stop_process S61rfd rfd; then exit 1; fi
[ ! -e ./rfd.pid ]
""")

    def test_stop_rejects_pid_owned_by_another_process(self):
        """Stop rejects pid owned by another process."""
        self.shell("""
printf '%s\\n' "$$" >./rfd.pid
service_action() { touch ./unsafe; }
if stop_process S61rfd rfd; then exit 1; fi
[ ! -e ./unsafe ]
""")

    def test_monit_status_failure_is_not_unmonitored_success(self):
        """Monit status failure is not unmonitored success."""
        self.shell("""
monit_state() { return 1; }
! wait_monitor HMIPServer paused
""")

    def test_stop_failure_attempts_to_restore_previously_stopped_daemon(self):
        """Stop failure attempts to restore previously stopped daemon."""
        self.transaction("""
stop_process() { [ "$2" != rfd ]; }
""", 'if recover; then exit 1; fi; '
                         'grep -q "S62HMServer start" ./actions && '
                         '[ ! -e "$JOURNAL" ]')

    def test_old_image_uses_original_interface_initializer(self):
        """Old image uses original interface initializer."""
        (self.init / "S49InitInterfaces").unlink()
        old = self.init / "S49hs485d"
        old.write_text("#!/bin/sh\n# Writes InterfacesList.xml\n")
        old.chmod(0o755)
        self.shell('[ "$(interface_init_script)" = S49hs485d ]')
        old.write_text("#!/bin/sh\n# Unrelated wired initialization\n")
        self.shell('! interface_init_script')

    def test_missing_optional_monit_checks_on_old_images(self):
        """Missing optional monit checks on old images."""
        self.shell("""
SERVICES="HMIPServer rfdDevice HMIPServerDevice"
monit_state() {
  [ "$1" = HMIPServer ] || return 1
  echo 'monitoring status Monitored'
}
monit_command() {
  if [ "$1" = status ]; then
    echo "Service '$2' not found"; return 1
  fi
}
wait_monitor() { return 0; }
pause_monit && [ "$(cat "$JOURNAL")" = HMIPServer ]
""")

    def test_optional_monit_connection_failure_still_aborts(self):
        """Optional monit connection failure still aborts."""
        self.shell("""
SERVICES="rfdDevice"
monit_state() { return 1; }
monit_command() { echo 'Cannot connect to Monit'; return 1; }
! pause_monit
""")

    def test_wait_hardware_accepts_delayed_device_nodes(self):
        """Wait hardware accepts delayed device nodes."""
        self.shell("""
WAIT=3 ATTEMPT=0
hardware_ready() { [ "$ATTEMPT" -ge 2 ]; }
sleep() { ATTEMPT=$((ATTEMPT+1)); }
wait_hardware && [ "$ATTEMPT" = 2 ]
""")

    def test_wait_hardware_times_out_without_unbounded_polling(self):
        """Wait hardware times out without unbounded polling."""
        self.shell("""
WAIT=3 ATTEMPT=0
hardware_ready() { return 1; }
sleep() { ATTEMPT=$((ATTEMPT+1)); }
if wait_hardware; then exit 1; fi
[ "$ATTEMPT" = 3 ]
""")

    def test_wait_hardware_aborts_on_another_link_loss(self):
        """Wait hardware aborts on another link loss."""
        self.shell("""
hardware_ready() { return 1; }
sleep() { touch ./unexpected_sleep; }
printf 0 >"$LINK"
if wait_hardware; then exit 1; fi
[ ! -e ./unexpected_sleep ]
""")

    def test_missing_nodes_do_not_start_rfd_or_clear_alarm(self):
        """Missing nodes do not start rfd or clear alarm."""
        self.lib.write_text(self.lib.read_text().replace(
            '[ -c /dev/null ]', '[ -c ./missing_device ]'))
        self.transaction(tail='if recover; then exit 1; fi; '
                         '! grep -q "^S61rfd start$" ./actions && '
                         '[ ! -e ./cleared ] && [ ! -e "$JOURNAL" ]')

    def test_hardware_timeout_does_not_start_rfd_with_existing_node(self):
        """Hardware timeout does not start rfd with existing node."""
        self.transaction('hardware_ready() { return 1; }',
                         'if recover; then exit 1; fi; '
                         '! grep -q "^S61rfd start$" ./actions && '
                         '[ ! -e ./cleared ] && [ ! -e "$JOURNAL" ]')

    def test_partial_stop_rollback_guards_missing_rfd_device(self):
        """Partial stop rollback guards missing rfd device."""
        self.lib.write_text(self.lib.read_text().replace(
            '[ -c /dev/null ]', '[ -c ./missing_device ]'))
        self.transaction('stop_process() { [ "$2" != multimacd ]; }',
                         'if recover; then exit 1; fi; '
                         '! grep -q "^S61rfd start$" ./actions && '
                         '[ ! -e ./cleared ]')

    def test_real_lock_rejects_concurrent_worker(self):
        """Real lock rejects concurrent worker."""
        lock = self.work / "real.lock"
        with lock.open("w") as handle:
            # Verify the installed flock command independently of mocks.
            import fcntl
            fcntl.flock(handle, fcntl.LOCK_EX | fcntl.LOCK_NB)
            result = subprocess.run([FLOCK, "-n", str(lock),
                                     BUSYBOX, "true"], capture_output=True)
            self.assertNotEqual(result.returncode, 0)
        result = subprocess.run(
            [FLOCK, "-n", str(lock), BUSYBOX, "true"])
        self.assertEqual(result.returncode, 0)

    def test_idle_worker_lifecycle_and_monitoring_cleanup(self):
        """Idle worker lifecycle and monitoring cleanup."""
        worker = self.work / "worker.sh"
        pidfile = self.work / "hb-rf-eth-recovery-service.pid"
        legacy_pidfile = self.work / "hb-rf-eth-recovery.pid"
        legacy_pidfile.write_text("legacy worker\n")
        journal = self.work / "hb-rf-eth-recovery.monit"
        # Exercise the production run/start/stop functions and real signals.
        # Replace only hardware/Monit operations, never lifecycle or locking.
        worker.write_text(self.lib.read_text() + f"""
SCRIPT={worker}
enabled() {{ return 1; }}
supported() {{ return 0; }}
stack_ready() {{ return 0; }}
monitor_step() {{ :; }}
log() {{ :; }}
monit_command() {{ echo "$*" >>./restored; }}
wait_monitor() {{ return 0; }}
case "$1" in
  run) run ;;
  start) start ;;
  stop) stop ;;
esac
""")
        worker.write_text(worker.read_text().replace(
            "/var/status/startupFinished", str(self.work / "startup")))
        (self.work / "startup").touch()
        process = subprocess.Popen(["/bin/sh", str(worker), "run"],
                                   cwd=self.work, stdout=subprocess.DEVNULL,
                                   stderr=subprocess.DEVNULL)
        try:
            for _ in range(100):
                if pidfile.exists():
                    break
                time.sleep(0.01)
            self.assertEqual(pidfile.read_text().strip(), str(process.pid))
            result = subprocess.run(["/bin/sh", str(worker), "start"],
                                    cwd=self.work, timeout=5)
            self.assertEqual(result.returncode, 0)
            self.assertEqual(pidfile.read_text().strip(), str(process.pid))
            journal.write_text("HMIPServer\n")
            result = subprocess.run(["/bin/sh", str(worker), "stop"],
                                    cwd=self.work, timeout=8)
            self.assertEqual(result.returncode, 0)
            process.wait(timeout=3)
            self.assertFalse(pidfile.exists())
            self.assertEqual(legacy_pidfile.read_text(), "legacy worker\n")
            self.assertFalse(journal.exists())
            self.assertEqual((self.work / "restored").read_text().strip(),
                             "monitor HMIPServer")
        finally:
            if process.poll() is None:
                process.kill()
                process.wait(timeout=3)

    def test_stale_pid_cannot_signal_unrelated_process(self):
        """Stale pid cannot signal unrelated process."""
        self.shell('printf "%s\\n" "$$" >"$PIDFILE"; ! worker_pid')


if __name__ == "__main__":
    unittest.main()
