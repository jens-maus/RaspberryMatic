#!/bin/sh
#
# **************************************************************************************************************************************************
#
# meine-homematic.de Dienst starten, Version 1.8, Stand 25.08.2010
# 
# Das Skript aktiviert das automatische Update 2x täglich
#
# **************************************************************************************************************************************************
#
ADDONDIR=/usr/local/etc/config/addons/mh
/bin/busybox logger -t homematic -p user.info "meine-homematic.de Auto - Update wird aktiviert"
v2=`cp $ADDONDIR/autoupdatean $ADDONDIR/autoupdate`
/opt/mh/user/loopupd.sh
