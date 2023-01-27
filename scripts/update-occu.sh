#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a OCCU tag name (see https://github.com/jens-maus/occu)"
  exit 1
fi

OCCU_VERSION=$1
DOWNLOAD_URL="https://github.com/jens-maus/occu/archive/${OCCU_VERSION}/occu-${OCCU_VERSION}.tar.gz"

# download archive for hash update
HASH=$(wget --passive-ftp -nd -t 3 -O - ${DOWNLOAD_URL} | sha256sum | awk '{ print $1 }')
if [ -n "${HASH}" ]; then
  # update package info
  sed -i "s/OCCU_VERSION = .*/OCCU_VERSION = $1/g" buildroot-external/package/occu/occu.mk
  # update package hash
  sed -i "$ d" buildroot-external/package/occu/occu.hash
  echo "sha256  ${HASH}  occu-${OCCU_VERSION}.tar.gz" >> buildroot-external/package/occu/occu.hash
fi
