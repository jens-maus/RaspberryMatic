#!/bin/bash

# Stop on error
set -e

#BOARD_DIR=${1}
PRODUCT=${2}
PRODUCT_VERSION=${3}
BOARD=$(echo "${PRODUCT}" | cut -d'_' -f2-)

# copy prepared docker image to release path
cp -a "build-${PRODUCT}/images/rootfs.tar" "./release/RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.tar"
#(cd "./release/updatepkg/${PRODUCT}" && tar --numeric-owner --owner=root --group=root -rvf "../../RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.tar" update_script EULA.de EULA.en)
xz -z -T 0 "./release/RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.tar"
(cd ./release && sha256sum "RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.tar.xz" >"RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.tar.xz.sha256")

# create manifest file with checksum+sizes
rm -f "./release/RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.mf"

# shellcheck disable=SC2129
echo "$(stat -c %s "./release/RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.tar.xz") $(cat "./release/RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.tar.xz.sha256")" >>"./release/RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.mf"
