#!/usr/bin/env python3
"""Test patched Base version-header rules without compiling any services.

Usage: python3 test_version_headers.py OPENCCU_BASE_SOURCE
The source tree must have the Buildroot package patches applied already.
"""

import argparse
from concurrent.futures import ThreadPoolExecutor
import os
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import time
import unittest


COMPONENTS = ("rfd", "hs485d", "multimacd")


class VersionHeaderTest(unittest.TestCase):
    """Exercise the actual custom commands in independent build trees."""

    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix="openccu-version-test-")
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.sources = {}
        self.builds = {}
        for variant in ("A", "B"):
            source = self.root / f"source {variant}"
            build = self.root / f"build {variant}"
            self.sources[variant] = source
            self.builds[variant] = build
            (source / "cmake").mkdir(parents=True)
            shutil.copy2(BASE_SOURCE / "cmake/WriteVersionHeader.cmake",
                         source / "cmake/WriteVersionHeader.cmake")
            driver = ["cmake_minimum_required(VERSION 3.20)",
                      "project(VersionHeaderTest NONE)"]
            for component in COMPONENTS:
                relative = Path("src") / component
                directory = source / relative
                directory.mkdir(parents=True)
                code = (BASE_SOURCE / relative / "CMakeLists.txt").read_text()
                # Keep the actual version rules, omitting all C++ targets.
                match = re.search(
                    rf"add_custom_target\({component}"
                    r"-version-header[^\n]*\)\n",
                    code)
                self.assertIsNotNone(match, component)
                (directory / "CMakeLists.txt").write_text(code[:match.end()])
                (directory / "version.sh").write_text(
                    f"printf '%s\\n' '{variant}-{component}'\n")
                driver.append(f"add_subdirectory({relative.as_posix()})")
            (source / "CMakeLists.txt").write_text("\n".join(driver) + "\n")
            self.run_cmake("-S", str(source), "-B", str(build))

    def run_cmake(self, *args):
        result = subprocess.run(
            [CMAKE, *args], text=True, stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT, check=False)
        self.assertEqual(result.returncode, 0, result.stdout)
        return result

    def build(self, variant):
        return self.run_cmake(
            "--build", str(self.builds[variant]),
            "--parallel", "3", "--target",
            *(f"{name}-version-header" for name in COMPONENTS))

    def header(self, variant, component):
        return (self.builds[variant] / "src" / component /
                f"generated-{component}-version.h")

    def test_parallel_builds_keep_versions_separate(self):
        with ThreadPoolExecutor(max_workers=2) as pool:
            list(pool.map(self.build, ("A", "B")))
        for variant in ("A", "B"):
            for component in COMPONENTS:
                expected = (f'#define {component.upper()}_VERSION '
                            f'"{variant}-{component}"\n')
                header = self.header(variant, component)
                self.assertEqual(header.read_text(), expected)
                temporary = header.parent / f"{component}-version.txt"
                self.assertEqual(temporary.read_text(),
                                 f"{variant}-{component}\n")

    def test_unchanged_inputs_do_not_regenerate(self):
        self.build("A")
        before = [self.header("A", c).stat().st_mtime_ns for c in COMPONENTS]
        self.build("A")
        after = [self.header("A", c).stat().st_mtime_ns for c in COMPONENTS]
        self.assertEqual(before, after)

    def test_version_script_change_regenerates_header(self):
        self.build("A")
        time.sleep(1.1)
        for component in COMPONENTS:
            script = self.sources["A"] / "src" / component / "version.sh"
            script.write_text(f"printf '%s\\n' 'new-{component}'\n")
        self.build("A")
        for component in COMPONENTS:
            self.assertIn(f'"new-{component}"',
                          self.header("A", component).read_text())

    def test_generator_change_regenerates_headers(self):
        self.build("A")
        before = [self.header("A", c).stat().st_mtime_ns for c in COMPONENTS]
        time.sleep(1.1)
        generator = self.sources["A"] / "cmake/WriteVersionHeader.cmake"
        generator.write_text(generator.read_text() + "\n# dependency test\n")
        self.build("A")
        after = [self.header("A", c).stat().st_mtime_ns for c in COMPONENTS]
        self.assertTrue(all(new > old for old, new in zip(before, after)))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path)
    args = parser.parse_args()
    BASE_SOURCE = args.source.resolve()
    CMAKE = os.environ.get("CMAKE", "cmake")
    unittest.main(argv=[__file__], verbosity=2)
