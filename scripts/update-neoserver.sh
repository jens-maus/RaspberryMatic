#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a NEOSERVER version number (see https://mediola.de)"
  exit 1
fi

sed -i "s/NEOSERVER_VERSION = .*/NEOSERVER_VERSION = $1/g" buildroot-external/package/neoserver/neoserver.mk
