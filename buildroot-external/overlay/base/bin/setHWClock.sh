#!/bin/sh
if [ -e /var/status/hasNTP ] ; then
	hwclock -wu 
else 
	hwclock -su
fi
