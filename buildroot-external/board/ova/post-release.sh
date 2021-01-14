#!/bin/bash

# Stop on error
set -e

BOARD_DIR=${1}
PRODUCT=${2}
PRODUCT_VERSION=${3}
BOARD=$(echo ${PRODUCT} | cut -d'_' -f2-)

# change into release dir
cd ./release

# copy the *.img and create checksum
cp -a "../build-${PRODUCT}/images/sdcard.imag" "./RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.img"
sha256sum "RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.img" >"RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.img.sha256"

# prepare the release *.zip
rm -f "./RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.zip"
zip --junk-paths "./RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.zip" "./RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.img" "./RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.img.sha256" ../LICENSE "./updatepkg/${PRODUCT}/EULA.de" "./updatepkg/${PRODUCT}/EULA.en"
sha256sum "RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.zip" >"RaspberryMatic-${PRODUCT_VERSION}-${BOARD}.zip.sha256"

# prepare the release *.ova
cp -a "../build-${PRODUCT}/images/RaspberryMatic.ova" "./RaspberryMatic-${PRODUCT_VERSION}.ova"
sha256sum "RaspberryMatic-${PRODUCT_VERSION}.ova" >"RaspberryMatic-${PRODUCT_VERSION}.ova.sha256"

exit $?
