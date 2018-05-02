#!/bin/sh
if [[ -c /dev/rtc ]]; then
  if [[ -f /var/status/hasNTP ]]; then
    /sbin/hwclock -wu
  else
    /sbin/hwclock -su
  fi
fi
