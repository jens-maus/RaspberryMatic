#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a picod tag/commit id (see https://github.com/ef-gy/rpi-ups-pico)"
  exit 1
fi

sed -i "s/PICOD_COMMIT = .*/PICOD_COMMIT = $1/g" buildroot-external/package/picod/picod.mk
