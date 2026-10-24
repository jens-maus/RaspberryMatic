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


@unittest.skipUnless(BUSYBOX, "BusyBox is required for target-shell tests")
class RecoveryTests(unittest.TestCase):
    def setUp(self):
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
        source = source.replace("/dev/mmd_bidcos", "/dev/null")
        source = source.replace("/dev/mmd_hmip", "/dev/null")
        self.lib = self.work / "lib.sh"
        self.lib.write_text(source)
        self.setup = """
. ./lib.sh
exec 9>./lock
ENABLE=./enabled GATEWAY=./gateway LEGACY=./legacy
MODE=./mode LINK=./link INTERFACES=./interfaces CACHE=./cache READY=./ready
WAIT=1
log() { printf '%s\\n' "$*" >>./events; }
sleep() { :; }
touch "$ENABLE"
printf gateway >"$GATEWAY"
printf 1 >"$LINK"
"""
        self.write_mode()
        (self.work / "interfaces").write_text(
            "<name>BidCos-RF</name>\n<name>HmIP-RF</name>\n")

    def write_mode(self, radio="RPI-RF-MOD", transport="HB-RF-ETH@gateway"):
        (self.work / "mode").write_text(
            "HM_MODE=NORMAL\n"
            f"HM_HMRF_DEV={radio}\nHM_HMIP_DEV={radio}\n"
            "HM_HMRF_DEVNODE=/dev/raw-uart\nHM_HMIP_DEVNODE=/dev/raw-uart\n"
            f"HM_HMRF_DEVTYPE={transport}\nHM_HMIP_DEVTYPE={transport}\n")

    def shell(self, body):
        result = subprocess.run([BUSYBOX, "ash", "-c", self.setup + body],
                                cwd=self.work, capture_output=True, text=True,
                                timeout=10)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        return result.stdout

    def test_requires_explicit_opt_in_and_gateway(self):
        self.shell('enabled || exit 1; rm "$ENABLE"; enabled && exit 2; '
                   'touch "$ENABLE"; : >"$GATEWAY"; ! enabled')

    def test_refuses_parallel_legacy_addon(self):
        self.shell('touch "$LEGACY"; chmod +x "$LEGACY"; ! enabled')

    def test_supported_radio(self):
        self.shell("supported && hardware_ready")

    def test_other_radio_is_excluded(self):
        self.write_mode("HM-MOD-RPI-PCB")
        self.shell("! supported")

    def test_local_radio_is_excluded(self):
        self.write_mode(transport="GPIO")
        self.shell("! supported")

    def test_removed_mode_does_not_reuse_previous_values(self):
        self.shell('supported || exit 1; : >"$MODE"; ! supported')

    def test_missing_interface_or_stale_cache_is_detected(self):
        self.shell('hardware_ready || exit 1; '
                   'printf VirtualDevices >"$CACHE"; '
                   'hardware_ready && exit 2; rm "$CACHE"; '
                   'printf "<name>HmIP-RF</name>" >"$INTERFACES"; '
                   '! hardware_ready')

    def test_link_requires_exact_connected_value(self):
        self.shell('link_up || exit 1; printf 10 >"$LINK"; ! link_up')

    def test_cooldown_retains_pending_recovery(self):
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
        self.shell("""
monit_state() { return 1; }
service_action() { touch ./unsafe; }
if recover; then exit 1; fi
[ ! -e ./unsafe ]
""")

    def test_failed_restore_retains_journal_and_preserves_disabled(self):
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
        self.transaction(
            tail='recover && [ -e ./cleared ] && [ ! -e "$JOURNAL" ]')

    def test_lost_link_during_recovery_does_not_clear_alarm(self):
        self.transaction('service_action() { touch "$READY"; '
                         'printf 0 >"$LINK"; }',
                         'if recover; then exit 1; fi; [ ! -e ./cleared ]')

    def test_stale_hmip_ready_marker_is_not_success(self):
        self.transaction('touch "$READY"; service_action() { return 0; }',
                         'if recover; then exit 1; fi; [ ! -e ./cleared ]')

    def test_unhealthy_hmip_monit_keeps_alarm(self):
        self.transaction('wait_monitor() { [ "$2" != healthy ] || '
                         '[ "$1" != HMIPServer ]; }',
                         'if recover; then exit 1; fi; [ ! -e ./cleared ]')

    def test_hardware_failure_restores_monit_without_reboot(self):
        self.transaction('service_action() { echo "$*" >>./actions; '
                         'touch "$READY"; [ "$1" != S47InitRFHardware ]; }',
                         'if recover; then exit 1; fi; '
                         '[ ! -e "$JOURNAL" ] && [ ! -e ./cleared ]')

    def test_cannot_stop_daemon_does_not_start_duplicate(self):
        self.transaction('stop_process() { return 1; }',
                         'if recover; then exit 1; fi; '
                         '[ ! -e ./actions ] && [ ! -e ./cleared ]')

    def test_interface_repair_reloads_rega_and_invalidates_cache(self):
        self.transaction('printf VirtualDevices >"$CACHE"',
                         'recover && [ ! -e "$CACHE" ] && '
                         'grep -q "S70ReGaHss restart" ./actions')

    def test_healthy_registry_avoids_rega_restart(self):
        self.transaction(tail='recover && ! grep -q S70ReGaHss ./actions')

    def test_deleted_pid_file_does_not_prove_termination(self):
        self.shell("""
printf '%s\\n' "$$" >./rfd.pid
process_running() { return 0; }
service_action() { rm -f ./rfd.pid; }
if stop_process S61rfd rfd; then exit 1; fi
[ ! -e ./rfd.pid ]
""")

    def test_stop_rejects_pid_owned_by_another_process(self):
        self.shell("""
printf '%s\\n' "$$" >./rfd.pid
service_action() { touch ./unsafe; }
if stop_process S61rfd rfd; then exit 1; fi
[ ! -e ./unsafe ]
""")

    def test_monit_status_failure_is_not_unmonitored_success(self):
        self.shell("""
monit_state() { return 1; }
! wait_monitor HMIPServer paused
""")

    def test_stop_failure_attempts_to_restore_previously_stopped_daemon(self):
        self.transaction("""
stop_process() { [ "$2" != rfd ]; }
""", 'if recover; then exit 1; fi; '
                         'grep -q "S62HMServer start" ./actions && '
                         '[ ! -e "$JOURNAL" ]')

    def test_real_lock_rejects_concurrent_worker(self):
        lock = self.work / "real.lock"
        with lock.open("w") as handle:
            # Verify actual BusyBox flock semantics independently of mocks.
            import fcntl
            fcntl.flock(handle, fcntl.LOCK_EX | fcntl.LOCK_NB)
            result = subprocess.run([BUSYBOX, "flock", "-n", str(lock),
                                     BUSYBOX, "true"], capture_output=True)
            self.assertNotEqual(result.returncode, 0)
        result = subprocess.run(
            [BUSYBOX, "flock", "-n", str(lock), BUSYBOX, "true"])
        self.assertEqual(result.returncode, 0)

    def test_worker_lifecycle_restores_journal_and_excludes_duplicates(self):
        worker = self.work / "worker.sh"
        pidfile = self.work / "hb-rf-eth-recovery.pid"
        journal = self.work / "hb-rf-eth-recovery.monit"
        # Exercise the production run/start/stop functions and real signals.
        # Replace only hardware/Monit operations, never lifecycle or locking.
        worker.write_text(self.lib.read_text() + f"""
SCRIPT={worker}
enabled() {{ return 0; }}
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
            self.assertFalse(journal.exists())
            self.assertEqual((self.work / "restored").read_text().strip(),
                             "monitor HMIPServer")
        finally:
            if process.poll() is None:
                process.kill()
                process.wait(timeout=3)

    def test_stale_pid_cannot_signal_unrelated_process(self):
        self.shell('printf "%s\\n" "$$" >"$PIDFILE"; ! worker_pid')


if __name__ == "__main__":
    unittest.main()
