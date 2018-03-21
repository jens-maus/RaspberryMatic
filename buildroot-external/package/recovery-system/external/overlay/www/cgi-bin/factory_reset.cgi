#!/bin/sh

USERFS_MTDCHAR=/dev/mtd6

echo -ne "Content-Type: text/plain\r\n\r\n"
echo -ne "Factory reset..."

umount /usr/local
if [ $? -ne 0 ] 
then
	echo "Error (umount)\r\n"
	exit 1
fi

#mount -t ubifs ubi1:user /usr/local
if [ $? -ne 0 ]
then
	echo "Error (mount)\r\n"
	exit 1
fi

#rm -rf /usr/local/*
ubidetach -p $USERFS_MTDCHAR
ubiformat $USERFS_MTDCHAR -y
ubiattach -p $USERFS_MTDCHAR
ubimkvol /dev/ubi1 -N user -m
sleep 5

echo -ne "done.\r\n"
