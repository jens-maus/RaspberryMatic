#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a daemonize tag/commit id (see https://github.com/bmc/daemonize)"
  exit 1
fi

sed -i "s/DAEMONIZE_VERSION = .*/DAEMONIZE_VERSION = $1/g" buildroot-external/package/daemonize/daemonize.mk
