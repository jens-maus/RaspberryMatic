#!/bin/sh

MKIMAGE=${HOST_DIR}/usr/bin/mkimage
BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BR2_EXTERNAL_RASPBERRYMATIC_PATH}/board/${BOARD_NAME}/genimage.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

# Use our extlinux.conf and hw_intf.conf
cp "${BR2_EXTERNAL_RASPBERRYMATIC_PATH}/board/${BOARD_NAME}/extlinux.conf" "${BINARIES_DIR}/"
cp "${BR2_EXTERNAL_RASPBERRYMATIC_PATH}/board/${BOARD_NAME}/hw_intf.conf" "${BINARIES_DIR}/"

# prepare the uboot image to be flashed
${MKIMAGE} -n rk3288 -T rksd -d ${BINARIES_DIR}/u-boot-spl-dtb.bin ${BINARIES_DIR}/u-boot.bin
cat ${BINARIES_DIR}/u-boot-dtb.bin >>${BINARIES_DIR}/u-boot.bin

#
# Create user filesystem
#
echo "Create user filesystem"
mkdir -p ${BUILD_DIR}/userfs
touch "${BUILD_DIR}/userfs/.doFactoryReset"
mke2img -d ${BUILD_DIR}/userfs -G 4 -R 1 -b 3000 -l userfs -o ${BINARIES_DIR}/userfs.ext4

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
