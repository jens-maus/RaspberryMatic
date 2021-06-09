#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a CloudMatic commit id (see https://github.com/EasySmartHome/CloudMatic-CCUAddon)"
  exit 1
fi

sed -i "s/CLOUDMATIC_VERSION = .*/CLOUDMATIC_VERSION = $1/g" buildroot-external/package/cloudmatic/cloudmatic.mk
