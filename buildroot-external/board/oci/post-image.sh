#!/bin/bash

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"

# define DOCKER_ARCH on the BR2_CONFIG setup
if grep -Eq "^BR2_x86_64=y$" ${BR2_CONFIG}; then
  DOCKER_ARCH=amd64
elif grep -Eq "^BR2_i386=y$" ${BR2_CONFIG}; then
  DOCKER_ARCH=i386
elif grep -Eq "^BR2_aarch64=y$" ${BR2_CONFIG}; then
  DOCKER_ARCH=arm64
elif grep -Eq "^BR2_arm=y$" ${BR2_CONFIG}; then
  DOCKER_ARCH=arm
else
  echo "Unknown architecture"
  exit 1
fi

# make sure a factory reset is performed upon fresh start
touch "${TARGET_DIR}/usr/local/.doFactoryReset"

#Create docker image
docker build -f "${BOARD_DIR}/Dockerfile" --build-args tar_prefix=rootfs -t raspberrymatic:${DOCKER_ARCH}-latest ${BINARIES_DIR}

exit $?
