#!/bin/sh
# shellcheck shell=dash disable=SC2169
#
# A shell script variant of a control daemon to
# control the fan and power buttons of a ArgonONE case
# or Argon FAN HAT
#
# Copyright (c) 2020-2021 Jens Maus <mail@jens-maus.de>
#

fancontrol()
{
  curspeed=-1
  dstspeed=0

  while true; do
    curtemp=$( (cat /sys/class/thermal/thermal_zone0/temp 2>/dev/null || echo 0) | awk '{printf "%.0f\n", $1/1000}' )
    if [[ ${curtemp} -ge 80 ]]; then
      dstspeed=100
    elif [[ ${curtemp} -ge 75 ]]; then
      dstspeed=50
    elif [[ ${curtemp} -ge 70 ]]; then
      dstspeed=10
    elif [[ ${curtemp} -ge 65 ]]; then
      dstspeed=5
    elif [[ ${curtemp} -ge 55 ]]; then
      dstspeed=3
    else
      dstspeed=0
    fi

    if [[ ${dstspeed} -ne ${curspeed} ]]; then
      /usr/sbin/i2cset -y 1 0x1a ${dstspeed}
      curspeed=${dstspeed}
    fi

    sleep 30
  done
}

powercontrol()
{
  while true; do
    # wait for rising+falling edge on GPIO line 4
    # and catch the timestamp output to check if we
    # need to reboot or shutdown
    output=$(/usr/bin/gpiomon -r -f -n 2 -F %s.%n gpiochip0 4)
    pulsetime=$(echo "${output}" | awk '{ print int(($2-$1)/0.01) }')

    # depending on the pulsetime length we either reboot
    # or shutdown
    if [[ ${pulsetime} -ge 2 ]] && [[ ${pulsetime} -le 3 ]]; then
      /sbin/reboot
    elif [[ ${pulsetime} -ge 4 ]] && [[ ${pulsetime} -le 5 ]]; then
      /sbin/poweroff
    fi
  done
}

cleanup()
{
  kill -9 "${fancontrolPID}" 2>/dev/null
  kill -9 "${powercontrolPID}" 2>/dev/null
  pkill -f gpiomon.*gpiochip0.4
}

# install exit traps
trap cleanup EXIT INT TERM

# switch ArgonONE case to "always on"
# see https://github.com/Argon40Tech/Argon-ONE-i2c-Codes
# NOTE: This seems to require newer ArgonONE firmwares/hardware revisions
/usr/sbin/i2cset -y 1 0x1a 0xfe

# start fancontrol sub-process
fancontrol &
fancontrolPID=$!

# start powercontrol sub-process
powercontrol &
powercontrolPID=$!

# wait until powercontrol sub-process finishes
wait ${powercontrolPID}
