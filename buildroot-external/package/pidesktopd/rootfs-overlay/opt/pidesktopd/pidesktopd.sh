#!/bin/sh
# shellcheck shell=dash disable=SC2169
#
# monitor GPIO to detect power key press from Power MCU (PCU)
#

# setup gpio6 and gpio13 correctly
/usr/bin/gpio mode 22 out # Pi to PCU - start/stop shutdown timer
/usr/bin/gpio mode 22 tri
/usr/bin/gpio mode 23 in  # PCU to Pi - detect power key pressed

/usr/bin/gpio write 22 0  # tell PCU we are alive
/usr/bin/gpio write 22 1  # cause blink by starting shutdown timer
sleep 0.5
/usr/bin/gpio write 22 0  # clear timer we really are alive

# wait for power key press
# pidesktop: power button press detected, initiating shutdown
if /usr/bin/gpio wfi 23 rising; then
  /sbin/poweroff
fi
