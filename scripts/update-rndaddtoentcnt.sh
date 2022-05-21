#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a rndaddtoentcnt tag/commit id (see https://github.com/jumpnow/rndaddtoentcnt)"
  exit 1
fi

sed -i "s/RNDADDTOENTCNT_VERSION = .*/RNDADDTOENTCNT_VERSION = $1/g" buildroot-external/package/rndaddtoentcnt/rndaddtoentcnt.mk
