#!/bin/sh

BOARD_DIR="$(dirname "$0")"
BOARD_NAME="$(basename "${BOARD_DIR}")"

# Use our own cmdline.txt+config.txt
cp "${BR2_EXTERNAL_EQ3_PATH}/board/${BOARD_NAME}/cmdline.txt" "${BINARIES_DIR}/"
cp "${BR2_EXTERNAL_EQ3_PATH}/board/${BOARD_NAME}/config.txt" "${BINARIES_DIR}/"

# get zero 2 w dtb files from raspberrypi firmware repo
test -f "${BINARIES_DIR}/bcm2710-rpi-zero-2-w.dtb" || wget -O "${BINARIES_DIR}/bcm2710-rpi-zero-2-w.dtb" https://github.com/raspberrypi/firmware/raw/27f12ea332fa4d94b963f8e0f6e48502684a5343/boot/bcm2710-rpi-zero-2-w.dtb
test -f "${BINARIES_DIR}/bcm2710-rpi-zero-2.dtb" || wget -O "${BINARIES_DIR}/bcm2710-rpi-zero-2.dtb" https://github.com/raspberrypi/firmware/raw/27f12ea332fa4d94b963f8e0f6e48502684a5343/boot/bcm2710-rpi-zero-2.dtb

#
# Create user filesystem
#
echo "Create user filesystem"
mkdir -p "${BUILD_DIR}/userfs"
touch "${BUILD_DIR}/userfs/.doFactoryReset"
rm -f "${BINARIES_DIR}/userfs.ext4"
mkfs.ext4 -d "${BUILD_DIR}/userfs" -F -L userfs -I 256 -E lazy_itable_init=0,lazy_journal_init=0 "${BINARIES_DIR}/userfs.ext4" 3000

#
# VERSION File
#
cp "${TARGET_DIR}/boot/VERSION" "${BINARIES_DIR}"

# create *.img file using genimage
support/scripts/genimage.sh -c "${BR2_EXTERNAL_EQ3_PATH}/board/${BOARD_NAME}/genimage.cfg"

exit $?
