#!/bin/bash
set -e

if [ -z "$1" ]; then
    echo "Need a tag or commit ID!"
    exit 1
fi

sed -i "s|BR2_LINUX_KERNEL_CUSTOM_TARBALL_LOCATION=\"https://github.com/raspberrypi/linux/.*\"|BR2_LINUX_KERNEL_CUSTOM_TARBALL_LOCATION=\"https://github.com/raspberrypi/linux/archive/$1.tar.gz\"|g" buildroot-external/configs/raspmatic_rpi*
#git commit -m "RaspberryPi: Update kernel $2 - $1" buildroot-external/configs/* Documentation/kernel.md
