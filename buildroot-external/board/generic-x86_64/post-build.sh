#!/bin/sh

# Stop on error
set -e

# copy the kernel image to rootfs
cp -a "${BINARIES_DIR}/bzImage" "${TARGET_DIR}/zImage"

# create VERSION file
echo "VERSION=${PRODUCT_VERSION}" >"${TARGET_DIR}/VERSION"
echo "PRODUCT=${PRODUCT}" >>"${TARGET_DIR}/VERSION"
echo "PLATFORM=generic-x86_64" >>"${TARGET_DIR}/VERSION"

# fix some permissions
[ -e "${TARGET_DIR}/etc/monitrc" ] && chmod 600 "${TARGET_DIR}/etc/monitrc"

# remove unnecessary stuff from TARGET_DIR
rm -f "${TARGET_DIR}/etc/init.d/S50crond"

# link VERSION in /boot on rootfs
mkdir -p "${TARGET_DIR}/boot"
ln -sf ../VERSION "${TARGET_DIR}/boot/VERSION"