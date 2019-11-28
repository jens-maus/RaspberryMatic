#!/bin/sh

# copy the kernel image to rootfs
cp -a ${BINARIES_DIR}/bzImage ${TARGET_DIR}/zImage

# create VERSION file
VERSION=$(cat ${BR2_EXTERNAL_EQ3_PATH}/../VERSION)
echo "VERSION=${VERSION}" >${TARGET_DIR}/VERSION
echo "PRODUCT=${PRODUCT}" >>${TARGET_DIR}/VERSION
echo "PLATFORM=ova" >>${TARGET_DIR}/VERSION

# fix some permissions
[ -e ${TARGET_DIR}/etc/monitrc ] && chmod 600 ${TARGET_DIR}/etc/monitrc

# link VERSION in /boot on rootfs
mkdir -p ${TARGET_DIR}/boot
ln -sf ../VERSION ${TARGET_DIR}/boot/VERSION
