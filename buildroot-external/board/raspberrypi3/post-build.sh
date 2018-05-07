#!/bin/sh

# copy the kernel image to rootfs
cp -a ${BINARIES_DIR}/zImage ${TARGET_DIR}/

# create VERSION file
VERSION=$(cat ${BR2_EXTERNAL_EQ3_PATH}/../VERSION)
echo "VERSION=${VERSION}" >${TARGET_DIR}/VERSION
echo "PRODUCT=${PRODUCT}" >>${TARGET_DIR}/VERSION
echo "PLATFORM=rpi3" >>${TARGET_DIR}/VERSION

# link VERSION in /boot on rootfs
mkdir -p ${TARGET_DIR}/boot
ln -sf ../VERSION ${TARGET_DIR}/boot/VERSION
