#!/bin/sh
# shellcheck source=/dev/null

# make sure VERSION exists in root of recoveryfs
VERSION="${BR2_RECOVERY_SYSTEM_VERSION}"
echo "VERSION=${VERSION}" >"${TARGET_DIR}/VERSION"
echo "PRODUCT=${PRODUCT}" >>"${TARGET_DIR}/VERSION"
echo "PLATFORM=tinkerboard2" >>"${TARGET_DIR}/VERSION"

# Define parameters with default values
DHCP_VENDOR_ID=eQ3-CCU3
 
# Load product specific parameters
if [ -r "${TARGET_DIR}/etc/product" ]; then
  . "${TARGET_DIR}/etc/product"

  # Replace vendor ID in interfaces
  sed -i "s/eQ3-CCU3/${DHCP_VENDOR_ID}/g" "${TARGET_DIR}/etc/network/interfaces"
fi

