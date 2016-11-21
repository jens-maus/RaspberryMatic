#!/bin/sh
#
# **************************************************************************************************************************************************
#
# meine-homematic.de Dienst beenden, Version 3.0, Stand 11.04.2013
# 
# Das Skript initiiert den Stop des Reverse proxy Dienstes
#
# **************************************************************************************************************************************************
#
ADDONDIR=/usr/local/etc/config/addons/mh
/bin/busybox logger -t homematic -p user.info "Reverse proxy wird deaktiviert"
v2=`cp $ADDONDIR/dienstaus $ADDONDIR/dienstngx`

Processname=nginx
if [ -n "`pidof $Processname`" ] ; then  
   /bin/busybox logger -t homematic -p user.info "Reverse Proxy wurde herunter gefahren"
   dummy=`killall -9 nginx`
fi



