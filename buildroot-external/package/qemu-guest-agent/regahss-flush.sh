#!/bin/sh
# shellcheck shell=dash disable=SC3010
#
# qemu-guest-agent fsfreeze hook script to make sure ReGaHss will flush its
# database before letting qemu freeze the filesystem for backup/migration
#
# Copyright (c) 2023 Jens Maus <mail@jens-maus.de>
# Apache 2.0 applies
#

# exit on error
set -e

# if ReGaHss is not running, exit
[[ -e /var/run/ReGaHss.pid ]] || exit 1

# on fsfreeze make sure ReGaHss will flush its current state to the storage first
if [[ "${1}" = "freeze" ]]; then
  echo "load tclrega.so; rega system.Save()" | /bin/tclsh 2>/dev/null
  sync
fi
