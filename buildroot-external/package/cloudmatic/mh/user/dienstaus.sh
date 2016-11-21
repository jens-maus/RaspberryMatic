#!/bin/sh
#
# **************************************************************************************************************************************************
#
# meine-homematic.de Dienst starten, Version 2.0, Stand 02.04.2016
# 
# Das Skript initiiert den Stop des VPN Dienstes durch kopieren der dienst Datei und beenden aller loop.sh
#
# **************************************************************************************************************************************************
#
ADDONDIR=/usr/local/etc/config/addons/mh
/bin/busybox logger -t homematic -p user.info "VPN Dienst wird deaktiviert"
v2=`cp $ADDONDIR/dienstaus $ADDONDIR/dienst`

Processname=openvpn
if [ -n "`pidof $Processname`" ] ; then  
   /bin/busybox logger -t homematic -p user.info "VPN Verbindung wurde herunter gefahren"
   dummy=`/bin/busybox killall openvpn`
fi

Processname=loop.sh
if [ -n "`pidof $Processname`" ] ; then  
   /bin/busybox logger -t homematic -p user.info "VPN Kontrollschleife wurde herunter gefahren"
   dummy=`/bin/busybox killall loop.sh`
fi


if [ -s /usr/local/crontabs/root ]; then
	cat /usr/local/crontabs/root | grep -v "/usr/local/etc/config/addons/mh/cloudmaticcheck.sh" | sort | uniq >/tmp/crontab.$$
	if [ -s /tmp/crontab.$$ ]; then
		mv /tmp/crontab.$$ /usr/local/crontabs/root
	fi
fi
