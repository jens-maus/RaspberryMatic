#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need tag/commitID (v2021.04.29-138a1) - see https://github.com/raspberrypi/rpi-eeprom/tree/master/firmware/stable"
  exit 1
fi
if [ -z "$2" ]; then
  echo "Need rpi-eeprom version (pieeprom-2021-04-29.bin) - see https://github.com/raspberrypi/rpi-eeprom/tree/master/firmware/stable"
  exit 1
fi

sed -i "s|RPI_EEPROM_VERSION = .*|RPI_EEPROM_VERSION = $1|g" buildroot-external/package/rpi-eeprom/rpi-eeprom.mk
sed -i "s|RPI_EEPROM_FIRMWARE_PATH = firmware/stable/.*bin|RPI_EEPROM_FIRMWARE_PATH = firmware/stable/$2|g" buildroot-external/package/rpi-eeprom/rpi-eeprom.mk

#git commit -m "RaspberryPi: Update firmware $1" "$2" buildroot/package/rpi-firmware
