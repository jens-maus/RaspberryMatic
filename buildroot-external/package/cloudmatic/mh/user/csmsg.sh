#!/bin/sh
ADDONDIR=/usr/local/etc/config/addons/mh
v3=`rm $ADDONDIR/smsguthaben`
v2=`wget -O $ADDONDIR/smsguthaben 'http://www.meine-homematic.de/checksmsguthaben.php?id='$1\&key=$2 -q`
