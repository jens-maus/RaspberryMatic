#!/bin/sh

echo -ne "Content-Type: text/plain\r\n\r\n"
echo -ne "Reset network settings..."

umount /usr/local
if [ $? -ne 0 ]
then
	echo "Error (umount)\r\n"
	exit 1
fi

mount -t ubifs ubi1:user /usr/local
if [ $? -ne 0 ]
then
	echo "Error (mount)\r\n"
	exit 1
fi

rm -rf /usr/local/etc/config/netconfig

echo -ne "done.\r\n"
