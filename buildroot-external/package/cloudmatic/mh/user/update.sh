#!/bin/sh
#
# **************************************************************************************************************************************************
#
# meine-homematic.de Update Script Stand 15.04.2010
# 
# **************************************************************************************************************************************************
# 
ADDONDIR=/usr/local/etc/config/addons/mh
/bin/busybox logger -t homematic -p user.info "meine-homematic.de Update Prozess aktualisiert Dateirechte"
chmod 777 $ADDONDIR/oldver
chmod 777 $ADDONDIR/loophammer.sh
chmod 777 $ADDONDIR/loopupd.sh
chmod 777 $ADDONDIR/email.sh
chmod 777 $ADDONDIR/sms.sh
chmod 777 $ADDONDIR/client.conf
chmod 777 $ADDONDIR/client.crt
chmod 777 $ADDONDIR/client.key
chmod 777 $ADDONDIR/mhmkey
chmod 777 $ADDONDIR/premiumsms.sh
chmod 777 $ADDONDIR/loop.sh
chmod 777 $ADDONDIR/newver
cp $ADDONDIR/newver $ADDONDIR/oldver
