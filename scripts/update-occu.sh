#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a OCCU tag name (see https://github.com/jens-maus/occu)"
  exit 1
fi

sed -i "s/OCCU_VERSION = .*/OCCU_VERSION = $1/g" buildroot-external/package/occu/occu.mk
