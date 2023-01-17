#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a wiringpi-tinker tag/commit id (see https://github.com/TinkerBoard/gpio_lib_c)"
  exit 1
fi

sed -i "s/WIRINGPI_TINKER_VERSION = .*/WIRINGPI_TINKER_VERSION = $1/g" buildroot-external/package/wiringpi-tinker/wiringpi-tinker.mk
