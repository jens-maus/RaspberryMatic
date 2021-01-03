#!/bin/sh

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"

#Create docker image
docker build -f "${BOARD_DIR}/Dockerfile" -t raspbian:${PRODUCT_VERSION} ${BINARIES_DIR}
docker tag raspbian:${PRODUCT_VERSION} raspbian:latest

exit $?
