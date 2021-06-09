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

# prepare the CCU3 release tgz archive
rm -rf "/tmp/${PRODUCT}-${PRODUCT_VERSION}" 2>/dev/null
mkdir -p "/tmp/${PRODUCT}-${PRODUCT_VERSION}"

while IFS= read -r f; do
  ln -s "$(pwd)/updatepkg/${PRODUCT}/${f}" "/tmp/${PRODUCT}-${PRODUCT_VERSION}/"
done < "updatepkg/${PRODUCT}/files-package.txt"

while IFS= read -r f; do
  gzip -c "$(pwd)/../build-${PRODUCT}/images/${f}" >"/tmp/${PRODUCT}-${PRODUCT_VERSION}/${f}.gz"
done < "updatepkg/${PRODUCT}/files-images.txt"

(cd "/tmp/${PRODUCT}-${PRODUCT_VERSION}" && sha256sum ./* >"${PRODUCT}-${PRODUCT_VERSION}.sha256")
# shellcheck disable=SC2046
tar -C "/tmp/${PRODUCT}-${PRODUCT_VERSION}" --owner=root --group=root -cvzhf "./RaspberryMatic-${PRODUCT_VERSION}-ccu3.tgz" $(ls "/tmp/${PRODUCT}-${PRODUCT_VERSION}")
sha256sum "RaspberryMatic-${PRODUCT_VERSION}-ccu3.tgz" >"RaspberryMatic-${PRODUCT_VERSION}-ccu3.tgz.sha256"
rm -rf "/tmp/${PRODUCT}-${PRODUCT_VERSION}" 2>/dev/null

exit $?
