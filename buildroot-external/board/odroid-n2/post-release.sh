#!/bin/bash

# Stop on error
set -e

#BOARD_DIR=${1}
PRODUCT=${2}
PRODUCT_VERSION=${3}
BOARD=$(echo "${PRODUCT}" | cut -d'_' -f2-)

# change into release dir
cd ./release

# copy the *.img and create checksum
cp -a "../build-${PRODUCT}/images/sdcard.img" "./RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.img"
sha256sum "RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.img" >"RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.img.sha256"

# prepare the release *.zip
rm -f "./RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.zip"
zip --junk-paths "./RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.zip" "./RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.img" "./RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.img.sha256" ../LICENSE "./updatepkg/${PRODUCT}/EULA.de" "./updatepkg/${PRODUCT}/EULA.en"
sha256sum "RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.zip" >"RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.zip.sha256"

# create manifest file with checksum+sizes
rm -f "RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.mf"

# shellcheck disable=SC2129
echo "$(stat -c %s "./RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.img") $(cat "RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.img.sha256")" >>"RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.mf"
echo "$(stat -c %s "./RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.zip") $(cat "RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.zip.sha256")" >>"RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.mf"
