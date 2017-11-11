#!/bin/sh

# Command run on power loss
: ${POWER_LOSS_CMD:='/bin/triggerAlarm.tcl "StromPi2: Power Loss"'}
: ${POWER_RETURN_CMD:='/bin/triggerAlarm.tcl "StromPi2: Power Restored"'}

# File descriptors
: ${GPIO_POWER:=21}

# Debounce time in while loop
: ${DEBOUNCE_TIME:='0.3s'}

## Initialize GPIO file descriptor
# $1: File descriptor Value: decimal
# $2: Direction       Value: in|out
function initFD() {
    eval "[ -e /sys/class/gpio/gpio\$$1/direction ]" || {
        eval "echo \$$1 > /sys/class/gpio/export || exit 1"
        sleep 0.1s
    }
    eval "echo $2 > /sys/class/gpio/gpio\$$1/direction || exit 1"
}

## Set GPIO Value
# $1: File descriptor Value: decimal
# $2: Value           Value: 0|1
function setFDvalue() {
    eval "echo $2 > /sys/class/gpio/gpio\$$1/value || exit 1"
}

## get GPIO Value
# $1: File descriptor       Value: decimal
# $2: Target variable name  Value: 0|1
function getFDvalue() {
    eval "read $2 < /sys/class/gpio/gpio\$$1/value || exit 1"
}

# Initialize GPIO_POWER file descriptor
initFD GPIO_POWER in

POWER_STATE=0
while getFDvalue GPIO_POWER POWER_STATE_NEW; do
    if [ ! "${POWER_STATE_NEW}" -eq "${POWER_STATE}" ]; then

      # execute POWER_LOSS_CMD in case power state is lost
      [ 1 -eq ${POWER_STATE_NEW} ] && eval ${POWER_LOSS_CMD} || eval ${POWER_RETURN_CMD} &

      # save POWER_STATE for next iteration
      POWER_STATE=${POWER_STATE_NEW}

    fi

    # Debouncing in software
    sleep ${DEBOUNCE_TIME}
done

# Remove GPIO file descriptors
echo ${GPIO_POWER} >/sys/class/gpio/unexport
