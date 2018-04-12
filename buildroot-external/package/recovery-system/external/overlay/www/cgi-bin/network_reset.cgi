#!/bin/sh

echo -ne "Content-Type: text/html; charset=iso-8859-1\r\n\r\n"

if [ -f /tmp/.runningFirmwareUpdate ]; then
  echo "ERROR: firmware update is currently running"
  exit 1
fi

echo -ne "[1/2] Setting network configuration to factory defaults... "

mount -o rw,remount /userfs
if [ $? -ne 0 ]; then
	echo "ERROR (rw remount)"
	exit 1
fi

rm -rf /usr/local/etc/config/netconfig
if [ $? -ne 0 ]; then
	echo "ERROR (rm)"
	exit 1
fi

mount -o ro,remount /userfs
if [ $? -ne 0 ]; then
	echo "ERROR (ro remount)"
	exit 1
fi

echo "done.<br>"

echo "[2/2] Rebooting..."
/sbin/reboot
