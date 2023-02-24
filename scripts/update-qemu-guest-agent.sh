#!/bin/bash
set -e

if [ -z "$1" ]; then
  echo "Need a qemu-guest-agent tag/commit id (see http://download.qemu.org/)"
  exit 1
fi

sed -i "s/QEMU_GUEST_AGENT_VERSION = .*/QEMU_GUEST_AGENT_VERSION = $1/g" buildroot-external/package/qemu-guest-agent/qemu-guest-agent.mk
