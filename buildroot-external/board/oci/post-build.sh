#!/bin/sh

# create VERSION file
echo "VERSION=${PRODUCT_VERSION}" >${TARGET_DIR}/VERSION
echo "PRODUCT=${PRODUCT}" >>${TARGET_DIR}/VERSION
echo "PLATFORM=oci" >>${TARGET_DIR}/VERSION

# fix some permissions
[ -e ${TARGET_DIR}/etc/monitrc ] && chmod 600 ${TARGET_DIR}/etc/monitrc

# remove unnecessary stuff from TARGET_DIR
rm -f ${TARGET_DIR}/etc/init.d/S01InitZRAMSwap
rm -f ${TARGET_DIR}/etc/init.d/S03InitURandom
rm -f ${TARGET_DIR}/etc/init.d/S21rngd
rm -f ${TARGET_DIR}/etc/init.d/S49chrony
rm -f ${TARGET_DIR}/bin/dhcp.script

# link VERSION in /boot on rootfs
mkdir -p ${TARGET_DIR}/boot
ln -sf ../VERSION ${TARGET_DIR}/boot/VERSION
