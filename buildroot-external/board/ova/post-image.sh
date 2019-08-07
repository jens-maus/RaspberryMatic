#!/bin/sh

MKIMAGE=${HOST_DIR}/usr/bin/mkimage
BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"

# prepare the uboot image to be flashed
${MKIMAGE} -n rk3288 -T rksd -d ${BINARIES_DIR}/u-boot-spl-dtb.bin ${BINARIES_DIR}/u-boot.bin
cat ${BINARIES_DIR}/u-boot-dtb.bin >>${BINARIES_DIR}/u-boot.bin

# rename all "rockchip-XXXX.dtb" files to "rockchip-XXXX.dtbo" so that they have
# the correction file extension for dt overlays.
mkdir -p "${BINARIES_DIR}/overlays"
rm -f ${BINARIES_DIR}/overlays/*
for file in ${BINARIES_DIR}/rockchip-*.dtb; do
  cp -a "${file}" "${BINARIES_DIR}/overlays/$(basename ${file} .dtb).dtbo"
done

# select device tree overlay files to be installed in the image
DTOVERLAYS="rpi-rf-mod-tinker.dtbo pivccu-tinkerboard.dtbo"
for overlay in ${DTOVERLAYS}; do
  if [ -f "${BINARIES_DIR}/${overlay}" ]; then
    cp -a "${BINARIES_DIR}/${overlay}" "${BINARIES_DIR}/overlays/"
  fi
done

#
# Create user filesystem
#
echo "Create user filesystem"
mkdir -p ${BUILD_DIR}/userfs
touch "${BUILD_DIR}/userfs/.doFactoryReset"
rm -f ${BINARIES_DIR}/userfs.ext4
mkfs.ext4 -d ${BUILD_DIR}/userfs -F -L userfs ${BINARIES_DIR}/userfs.ext4 3000

#
# VERSION File
#
cp ${TARGET_DIR}/boot/VERSION ${BINARIES_DIR}

# create *.img file using genimage
support/scripts/genimage.sh -c "${BR2_EXTERNAL_EQ3_PATH}/board/${BOARD_NAME}/genimage.cfg"

exit $?
