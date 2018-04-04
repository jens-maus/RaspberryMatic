#!/bin/sh

# make sure VERSION exists in root of recoveryfs
echo "VERSION=${BR2_RECOVERY_SYSTEM_VERSION}-rpi0" >${TARGET_DIR}/VERSION
