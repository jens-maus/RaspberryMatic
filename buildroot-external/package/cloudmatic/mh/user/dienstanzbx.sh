#!/bin/sh
#
# **************************************************************************************************************************************************
#
# meine-homematic.de Dienst starten, Version 3.0, Stand 11.04.2013
# 
# Das Skript initiiert das Starten des Monitoring Dienstes
#
# **************************************************************************************************************************************************
#
ADDONDIR=/usr/local/etc/config/addons/mh

if [ -e $ADDONDIR/zabbix.conf ] ; then
	/bin/busybox logger -t homematic -p user.info "CloudMatic monitoring wird aktiviert"
	v2=`cp $ADDONDIR/dienstan $ADDONDIR/dienstzbx`

	Processname=zabbix_agentd
	if [ ! -n "`pidof $Processname`" ] ; then  
		/bin/busybox logger -t homematic -p user.info "CloudMatic monitoring Dienst wird gestartet"
		ovstart=`/etc/config/addons/mh/zabbix_agentd -c /etc/config/addons/mh/zabbix.conf >/dev/null 2>&1`
	fi
fi
