#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a Tailscale version (see https://github.com/tailscale/tailscale)"
  exit 1
fi

sed -i "s/TAILSCALE_VERSION = .*/TAILSCALE_VERSION = $1/g" buildroot-external/package/tailscale/tailscale.mk
