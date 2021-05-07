#!/bin/bash
set -e

if [ -z "$1" ]; then
    echo "Need a tag/commit ID! e.g.: 1.20210303"
    exit 1
fi

sed -i "s|BR2_PACKAGE_RPI_FIRMWARE_VERSION=\".*\"|BR2_PACKAGE_RPI_FIRMWARE_VERSION=\"$1\"|g" buildroot-external/configs/raspmatic_rpi*

#git commit -m "RaspberryPi: Update firmware $1" "$2" buildroot/package/rpi-firmware
