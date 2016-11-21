#!/bin/sh
ADDONDIR=/usr/local/etc/config/addons/mh
v1=`cp $ADDONDIR/badip $ADDONDIR/checkip`
v2=`cp $ADDONDIR/baddns $ADDONDIR/checkdns`
v3=`/bin/busybox wget -O $ADDONDIR/checkip 'http://83.169.3.181/statusip.php' -q`
v4=`/bin/busybox wget -O $ADDONDIR/checkdns 'http://www.meine-homematic.de/statusdns.php' -q`
