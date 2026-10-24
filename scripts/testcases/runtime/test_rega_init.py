#!/usr/bin/env python3
"""Test real ReGa init wait, stop/start and dispatch code in BusyBox ash."""
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[3]
INIT = ROOT / "buildroot-external/package/openccu-base/S70ReGaHss"
BUSYBOX = shutil.which("busybox")


@unittest.skipUnless(BUSYBOX, "BusyBox is required for target-shell tests")
class ReGaInitTests(unittest.TestCase):
    """Execute the shipped init control flow against simulated processes."""

    def run_init(self, action, mode, running=False, debug=False):
        """Execute actual init logic with isolated external effects."""
        with tempfile.TemporaryDirectory() as directory:
            work = Path(directory)
            if running:
                (work / "alive").write_text("1234\n")
                (work / "ReGaHss.pid").write_text("1234\n")
            tcl = work / "tclsh"
            tcl.write_text("#!/bin/sh\nexit 0\n")
            tcl.chmod(0o755)
            source = INIT.read_text()
            source = source[source.index("waitStartupComplete() {"):]
            source = source.replace("/proc/$$/oom_score_adj", "./oom_score")
            source = source.replace("/bin/tclsh", str(tcl))
            fixture = """
DAEMON=ReGaHss
PIDFILE=./ReGaHss.pid
LOGLEVEL_REGA=2
REGA_BIN_VERSION=DEBUG_VALUE
TEST_MODE=MODE_VALUE
init() { :; }
sleep() { echo poll >>./polls; }
sync() { :; }
pidof() { [ -f ./alive ] && cat ./alive; }
start-stop-daemon() {
  echo "$*" >>./actions
  case " $* " in
    *' -K '*)
      if [ "$TEST_MODE" != stop_timeout ]; then rm -f ./alive; fi
      ;;
    *' -S '*)
      [ "$TEST_MODE" != start_error ] || return 1
      echo 9876 >"$PIDFILE"
      if [ "$TEST_MODE" != start_timeout ]; then echo 9876 >./alive; fi
      ;;
  esac
  return 0
}
""".replace("MODE_VALUE", mode).replace(
                "DEBUG_VALUE", "DEBUG" if debug else "")
            result = subprocess.run(
                [BUSYBOX, "ash", "-c", fixture + source, "rega-init", action],
                cwd=work, capture_output=True, text=True, timeout=5)
            return {
                "code": result.returncode,
                "output": result.stdout + result.stderr,
                "pid": (work / "ReGaHss.pid").read_text()
                if (work / "ReGaHss.pid").exists() else None,
                "actions": (work / "actions").read_text()
                if (work / "actions").exists() else "",
                "polls": len((work / "polls").read_text().splitlines())
                if (work / "polls").exists() else 0,
            }

    def test_startup_timeout_reaches_dispatcher(self):
        """A missing process after all startup polls returns a failure."""
        result = self.run_init("start", "start_timeout")
        self.assertNotEqual(result["code"], 0, result["output"])
        self.assertEqual(result["polls"], 20)
        self.assertIn("ERROR", result["output"])

    def test_stop_timeout_preserves_pidfile(self):
        """Keep the original PID file when the process will not terminate."""
        result = self.run_init("stop", "stop_timeout", running=True)
        self.assertNotEqual(result["code"], 0, result["output"])
        self.assertEqual(result["pid"], "1234\n")
        self.assertEqual(result["polls"], 20)

    def test_restart_does_not_start_after_stop_timeout(self):
        """A failed stop cannot proceed to a replacement process."""
        result = self.run_init("restart", "stop_timeout", running=True)
        self.assertNotEqual(result["code"], 0, result["output"])
        self.assertNotIn(" -S ", result["actions"])
        self.assertEqual(result["pid"], "1234\n")

    def test_successful_restart_stops_then_starts(self):
        """A terminated old process allows a verified new process to start."""
        result = self.run_init("restart", "normal", running=True)
        self.assertEqual(result["code"], 0, result["output"])
        self.assertEqual(result["pid"], "9876\n")
        self.assertLess(result["actions"].index("-K "),
                        result["actions"].index(" -S "))

    def test_successful_stop_removes_pidfile(self):
        """Remove the PID file only once termination is verified."""
        result = self.run_init("stop", "normal", running=True)
        self.assertEqual(result["code"], 0, result["output"])
        self.assertIsNone(result["pid"])

    def test_launcher_error_reaches_dispatcher(self):
        """Propagate a failed process launch without running later commands."""
        result = self.run_init("start", "start_error")
        self.assertNotEqual(result["code"], 0, result["output"])
        self.assertEqual(result["polls"], 0)

    def test_debug_launcher_error_reaches_dispatcher(self):
        """The debug wrapper must also propagate a failed launch."""
        result = self.run_init("start", "start_error", debug=True)
        self.assertNotEqual(result["code"], 0, result["output"])
        self.assertEqual(result["polls"], 0)


if __name__ == "__main__":
    unittest.main()
