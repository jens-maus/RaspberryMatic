#!/bin/sh

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BR2_EXTERNAL_EQ3_PATH}/board/${BOARD_NAME}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

# Use our own cmdline.txt+config.txt
cp "${BR2_EXTERNAL_EQ3_PATH}/board/${BOARD_NAME}/cmdline.txt" "${BINARIES_DIR}/rpi-firmware/"
cp "${BR2_EXTERNAL_EQ3_PATH}/board/${BOARD_NAME}/config.txt" "${BINARIES_DIR}/rpi-firmware/"

# select device tree overlay files to be installed in the image
DTOVERLAYS="rpi-rf-mod.dtbo pivccu-raspberrypi.dtbo bcm2835-raw-uart.dtbo"
mkdir -p "${BINARIES_DIR}/overlays"
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

rm -rf "${GENIMAGE_TMP}"

genimage                         \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"

exit $?
