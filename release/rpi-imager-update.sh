#!/usr/bin/env bash
#
# helper script to update the rpi-imager.json with the
# supplied version.
#

# Setup script environment
set -o errexit  #Exit immediately if a pipeline returns a non-zero status
set -o errtrace #Trap ERR from shell functions, command substitutions, and commands from subshell
set -o nounset  #Treat unset variables as an error
set -o pipefail #Pipe will exit with last non-zero status if applicable
shopt -s expand_aliases
alias die='EXIT=$? LINE=${LINENO} error_exit'
trap die ERR
trap cleanup EXIT

function error_exit() {
  trap - ERR
  local DEFAULT='Unknown failure occured.'
  local REASON="\e[97m${1:-$DEFAULT}\e[39m"
  local FLAG="\e[91m[ERROR] \e[93m${EXIT}@${LINE}"
  msg "${FLAG} ${REASON}"
  exit "${EXIT}"
}

function warn() {
  local REASON="\e[97m$1\e[39m"
  local FLAG="\e[93m[WARNING]\e[39m"
  msg "${FLAG} ${REASON}"
}

function info() {
  local REASON="$1"
  local FLAG="\e[36m[INFO]\e[39m"
  msg "${FLAG} ${REASON}"
}

function msg() {
  local TEXT="$1"
  echo -e "${TEXT}"
}

function cleanup() {
  popd >/dev/null
  rm -rf "${TEMP_DIR}"
}

NEW_VERSION=${1}
DOWNLOAD_URL="https://github.com/jens-maus/RaspberryMatic/releases/download/VERSION/RaspberryMatic-VERSION"
DESCRIPTION="Lightweight Linux OS for running a HomeMatic/homematicIP IoT central."

# extract release date in YYYY-MM-DD
RELEASE_DATE=$(date --date=$(echo ${NEW_VERSION} | cut -d'.' -f4) +%Y-%m-%d)

RPI_IMAGER_PATH="$(readlink -f rpi-imager.json)"

# create temp dir and copy rpi-imager.json to it
TEMP_DIR=$(mktemp -d)
cp -a "${RPI_IMAGER_PATH}" "${TEMP_DIR}/"
pushd "${TEMP_DIR}" >/dev/null

function updateJSON() {
  local id=$1
  local platform=$2
  local descr=$3

  info "Processing ${platform}:"
  ARCHIVE_URL="${DOWNLOAD_URL//VERSION/${NEW_VERSION}}-${platform}.zip"
  ARCHIVE_FILE=$(basename "${ARCHIVE_URL}")
  
  info "Downloading..."
  wget -q --show-progress "${ARCHIVE_URL}" "${ARCHIVE_URL}.sha256"
  
  info "Unarchiving..."
  unzip -q -o "${ARCHIVE_FILE}"
  
  info "Patching rpi-imager.json..."
  IMAGE_DOWNLOAD_SIZE=$(stat -c %s "${ARCHIVE_FILE}")
  IMAGE_DOWNLOAD_SHA256=$(cat ${ARCHIVE_FILE}.sha256 | cut -d' ' -f1)
  EXTRACT_SIZE=$(stat -c %s ${ARCHIVE_FILE%.*}.img)
  EXTRACT_SHA256=$(cat ${ARCHIVE_FILE%.*}.img.sha256 | cut -d' ' -f1)
  jq ".os_list[${id}].name = \"RaspberryMatic ${NEW_VERSION} (${descr})\" | \
      .os_list[${id}].description = \"${DESCRIPTION}\" | \
      .os_list[${id}].url = \"${ARCHIVE_URL}\" | \
      .os_list[${id}].release_date = \"${RELEASE_DATE}\" | \
      .os_list[${id}].extract_size = ${EXTRACT_SIZE} | \
      .os_list[${id}].extract_sha256 = \"${EXTRACT_SHA256}\" | \
      .os_list[${id}].image_download_size = ${IMAGE_DOWNLOAD_SIZE} | \
      .os_list[${id}].image_download_sha256 = \"${IMAGE_DOWNLOAD_SHA256}\"" rpi-imager.json >rpi-imager-new.json
  mv rpi-imager-new.json rpi-imager.json
  rm -f "${ARCHIVE_FILE%.*}.img"
}

# update rpi-imager.json
updateJSON 0 rpi4 "RPi4, RPi400"
updateJSON 1 rpi3 "RPi3, RPiZero2, ELV-Charly, CCU3"
updateJSON 2 rpi2 "RPi2"
updateJSON 3 rpi0 "RPiZero, RPi1"

cp -a rpi-imager.json "${RPI_IMAGER_PATH}"
