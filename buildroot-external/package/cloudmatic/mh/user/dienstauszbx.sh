#!/bin/sh
#
# **************************************************************************************************************************************************
#
# meine-homematic.de Dienst beenden, Version 3.0, Stand 11.04.2013
# 
# Das Skript initiiert den Stop des monitoring Dienstes
#
# **************************************************************************************************************************************************
#
ADDONDIR=/usr/local/etc/config/addons/mh
/bin/busybox logger -t homematic -p user.info "CloudMatic monitoring wird deaktiviert"
v2=`cp $ADDONDIR/dienstaus $ADDONDIR/dienstzbx`

Processname=zabbix_agentd
if [ -n "`pidof $Processname`" ] ; then  
   /bin/busybox logger -t homematic -p user.info "CloudMatic monitoring wurde herunter gefahren"
   dummy=`killall -9 zabbix_agentd`
fi



