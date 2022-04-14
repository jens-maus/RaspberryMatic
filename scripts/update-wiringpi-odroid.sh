#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a wiringpi-odroid tag/commit id (see https://github.com/hardkernel/wiringPi)"
  exit 1
fi

sed -i "s/WIRINGPI_ODROID_VERSION = .*/WIRINGPI_ODROID_VERSION = $1/g" buildroot-external/package/wiringpi-odroid/wiringpi-odroid.mk
