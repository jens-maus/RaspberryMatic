#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a detect_radio_module commitID (see https://github.com/alexreinert/piVCCU/tree/master/detect_radio_module)"
  exit 1
fi

sed -i "s/DETECT_RADIO_MODULE_VERSION = .*/DETECT_RADIO_MODULE_VERSION = $1/g" buildroot-external/package/detect_radio_module/detect_radio_module.mk
