#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a wiringpi-rpi commit id (see https://github.com/WiringPi/WiringPi/)"
  exit 1
fi

sed -i "s/WIRINGPI_RPI_VERSION = .*/WIRINGPI_RPI_VERSION = $1/g" buildroot-external/package/wiringpi-rpi/wiringpi-rpi.mk
