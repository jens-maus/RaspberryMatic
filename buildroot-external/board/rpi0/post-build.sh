#!/bin/sh

# Stop on error
set -e

# copy the kernel image to rootfs
cp -a "${BINARIES_DIR}/zImage" "${TARGET_DIR}/"
