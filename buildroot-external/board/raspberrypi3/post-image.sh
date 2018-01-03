#!/bin/sh

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BR2_EXTERNAL_RASPBERRYMATIC_PATH}/board/${BOARD_NAME}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

# Use our own cmdline.txt+config.txt
cp "${BR2_EXTERNAL_RASPBERRYMATIC_PATH}/board/${BOARD_NAME}/cmdline.txt" "${BINARIES_DIR}/rpi-firmware/"
cp "${BR2_EXTERNAL_RASPBERRYMATIC_PATH}/board/${BOARD_NAME}/config.txt" "${BINARIES_DIR}/rpi-firmware/"

# Create bcm2835-raw-uart.dtbo device tree overlay
dtc -@ -I dts -O dtb -o ${BINARIES_DIR}/bcm2835-raw-uart.dtbo ${BR2_EXTERNAL_RASPBERRYMATIC_PATH}/package/occu/kernel-modules/bcm2835_raw_uart/bcm2835-raw-uart.dts

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
