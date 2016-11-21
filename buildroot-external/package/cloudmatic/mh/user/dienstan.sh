#!/bin/sh
#
# **************************************************************************************************************************************************
#
# meine-homematic.de Dienst starten, Version 2.0, Stand 02.04.2016
# 
# Das Skript initiiert das Starten des VPN Dienstes durch kopieren der dienst Datei und Starten der loop.sh
#
# **************************************************************************************************************************************************
#
ADDONDIR=/usr/local/etc/config/addons/mh
/bin/busybox logger -t homematic -p user.info "VPN Dienst wird aktiviert"
v2=`cp $ADDONDIR/dienstan $ADDONDIR/dienst`
###/opt/mh/user/loop.sh &

if [ -s /usr/local/crontabs/root ]; then
	cat /usr/local/crontabs/root | grep -v "/usr/local/etc/config/addons/mh/cloudmaticcheck.sh" | sort | uniq >/tmp/crontab.$$
	if [ -s /tmp/crontab.$$ ]; then
		mv /tmp/crontab.$$ /usr/local/crontabs/root
	fi
fi
(crontab -l 2>/dev/null; echo "* * * * * /bin/sh /usr/local/etc/config/addons/mh/cloudmaticcheck.sh >> /dev/null") | crontab -
