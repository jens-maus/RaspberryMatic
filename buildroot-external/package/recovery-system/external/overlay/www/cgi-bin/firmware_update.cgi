#!/bin/sh

echo -ne "Content-Type: text/html; charset=iso-8859-1\r\n\r\n"

if [ -f /tmp/.runningFirmwareUpdate ]; then
  echo "ERROR: firmware update is already running"
  exit 1
fi

# cleanup first
rm -f /usr/local/.firmwareUpdate

# process data upload
echo -ne "[1/5] Processing uploaded data.."

# fake read boundary+disposition, etc.
read boundary
read disposition
read ctype
read junk

# get length
a=${#boundary}
b=${#disposition}
c=${#ctype}

# Due to \n\r line breaks we have 2 extra bytes per line read,
# 6 + 2 newlines == 10 junk bytes
a=$((a*2+b+c+d+10))

# start a progress bar outputing dots every few seconds
while :;do echo -n .;sleep 3;done &
PROGRESS_PID=$!
trap "kill ${PROGRESS_PID}" EXIT

# write out the data
SIZE=$((HTTP_CONTENT_LENGTH-a))
filename=$(mktemp -p /usr/local/tmp)
head -c $SIZE >${filename}
if [ $? -ne 0 ]; then
  echo "ERROR (head)"
  exit 1
fi

# stop the progress output
kill ${PROGRESS_PID} && trap " " EXIT

######
# lets start the firmware update now using /bin/fwinstall.sh
# and if it returns 0 everything was fine and we can reboot!
/bin/fwinstall.sh ${filename}
if [ $? -ne 0 ]; then
  exit 1
fi

# cleanup
rm -f /usr/local/.firmwareUpdate

echo "Rebooting..."
/sbin/reboot
