#!/bin/sh

echo -ne "Content-Type: text/html; charset=iso-8859-1\r\n\r\n"

echo -ne "[1/2] Setting Factory Reset Mode... "

mount -o rw,remount /userfs
if [ $? -ne 0 ]; then
	echo "ERROR (rw umount)"
	exit 1
fi

touch /usr/local/.doFactoryReset
if [ $? -ne 0 ]; then
	echo "ERROR (touch)"
	exit 1
fi

mount -o ro,remount /userfs
if [ $? -ne 0 ]; then
	echo "ERROR (ro umount)"
	exit 1
fi

echo "done."

echo "[2/2] Rebooting..."
/sbin/reboot
