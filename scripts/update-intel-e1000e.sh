#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a e1000 version number (see https://sourceforge.net/projects/e1000/files/e1000e%20stable/)"
  exit 1
fi

sed -i "s/INTEL_E1000E_VERSION = .*/INTEL_E1000E_VERSION = $1/g" buildroot-external/package/intel-e1000e/intel-e1000e.mk
