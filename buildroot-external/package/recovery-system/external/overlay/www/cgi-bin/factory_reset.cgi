#!/bin/sh

echo -ne "Content-Type: text/html; charset=iso-8859-1\r\n\r\n"

if [ -f /tmp/.runningFirmwareUpdate ]; then
  echo "ERROR: firmware update is currently running"
  exit 1
fi

echo -ne "[1/3] Do Factory Reset. Check requirements ... "

umount /userfs
if [ $? -ne 0 ]; then
	echo "INFO user filesystem not mounted"
fi

if [ -e /dev/mmcblk0p3 ]
then
	echo "INFO user partition exists"
else
	echo "Info user partition does not exists. Please contact support hotline"
	exit 1
fi

echo -ne "[2/3] Do Factory Reset. Create new user filesystem ... "

mkfs.ext4 -F -L userfs /dev/mmcblk0p3

if [ $? -ne 0 ]; then
        echo "INFO user filesystem not created properly.Please contact support hotline"
fi

echo "done.<br>"

echo "[3/3] Rebooting..."
/sbin/reboot
