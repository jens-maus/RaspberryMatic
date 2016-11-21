#!/bin/sh
#
# **************************************************************************************************************************************************
#
# cloudmatic.de Service -  Version 2.0, Stand 02.04.2016
#
# Dies ist ein universelles Skript, welches zwei Benutzer-Skripte startet
#
# Hammering-Schutz:
# ==================
# Das Skript kontrolliert, ob das aktuelle Datum nach dem Datum liegt, bis zu dem der Premium Zugang gültig ist.
# Ist der Zugang abgelaufen, wird ein evtl. laufender openvpn Prozess beendet.
# Dies ist notwendig, da die HomeMatic sonst permantent versucht eine Verbindung mit dem VPN Server aufzubauen.
#
# Update-Dienst:
# ===============
# Das Skript überträgt rund alle 30 Minuten den aktuellen cloudmatic.de Schlüssel auf die lokale HomeMatic.
#
# Changelog:
# ===========
# Version 2.0
# Automatische Provisionierung des initialen Keys
# Migration auf Cron Job
# Auslagerung Update Checks
#
# Version 1.8
# Autupdates abschaltbar
#
# Version 1.7
# Anpassung des Updateintervalls auf 2x täglich
#
# **************************************************************************************************************************************************
#
ADDONDIR=/usr/local/etc/config/addons/mh
updcounter=0

#
# Teilbereich Provisionierung des initialen Keys
#
initialkey=`cat $ADDONDIR/keytransfer`
if [ $initialkey -ge 1 ] ; then
	doupd=`/bin/tclsh /opt/mh/www/transferinitialkey.cgi`
fi

#
# Teilbereich Hammering - Schutz
# 
dohammer=`/bin/sh $ADDONDIR/loophammer.sh`

  