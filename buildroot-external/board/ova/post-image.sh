#!/bin/sh

MKIMAGE=${HOST_DIR}/usr/bin/mkimage
BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"

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

# prepare grub config and bootloader
mkdir -p ${BINARIES_DIR}/boot/grub
cat <<EOT >${BINARIES_DIR}/boot/grub/grub.cfg
set default="0"
set timeout="5"
menuentry "RaspberryMatic" {
  linux /bzImage console=tty1 root=/dev/sda2 ro noswap rootfstype=ext4 elevator=deadline fsck.repair=yes lapic rootwait
}
EOT

# create *.img file using genimage
support/scripts/genimage.sh -c "${BR2_EXTERNAL_EQ3_PATH}/board/${BOARD_NAME}/genimage.cfg"

# lets create vmdk/vhdx/vdi files
${HOST_DIR}/bin/qemu-img convert -O vmdk ${BINARIES_DIR}/sdcard.img ${BINARIES_DIR}/sdcard.vmdk
${HOST_DIR}/bin/qemu-img convert -O vhdx ${BINARIES_DIR}/sdcard.img ${BINARIES_DIR}/sdcard.vhdx
${HOST_DIR}/bin/qemu-img convert -O vdi ${BINARIES_DIR}/sdcard.img ${BINARIES_DIR}/sdcard.vdi

exit $?
