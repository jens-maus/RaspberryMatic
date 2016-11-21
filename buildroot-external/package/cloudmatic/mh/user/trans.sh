#!/bin/sh
#
# **************************************************************************************************************************************************
#
# meine-homematic.de Initial - Prozess Version 1.4, Stand 15.04.2010
# 
# Das Skript überträge den ersten Key auf die HomeMatic
#
# **************************************************************************************************************************************************
#
ADDONDIR=/usr/local/etc/config/addons/mh
/bin/busybox logger -t homematic -p user.info "meine-homematic.de Initialer Konfigurations - Transfer gestartet"
v2=`wget -O $ADDONDIR/vpnkey_ccu2.tar.gz 'http://www.meine-homematic.de/getmhkeyccu2.php?snr='$1\&tkey=$2 -q`
v4=`tar -zxvf $ADDONDIR/vpnkey_ccu2.tar.gz -C $ADDONDIR`
v5=`chmod 777 $ADDONDIR/update.sh`
upd=`/bin/sh $ADDONDIR/update.sh >> /dev/null`


