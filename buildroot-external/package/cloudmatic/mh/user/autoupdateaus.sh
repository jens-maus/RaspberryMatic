#!/bin/sh
#
# **************************************************************************************************************************************************
#
# meine-homematic.de Dienst starten, Version 1.8, Stand 25.08.2010
# 
# Das Skript deaktiviert automatische Updates von meine-homematic.de
#
# **************************************************************************************************************************************************
#
ADDONDIR=/usr/local/etc/config/addons/mh
/bin/busybox logger -t homematic -p user.info "Automatische Updates von meine-homematic.de werden deaktiviert"
v2=`cp $ADDONDIR/autoupdateaus $ADDONDIR/autoupdate`

