#!/bin/sh
#
# **************************************************************************************************************************************************
#
# meine-homematic.de Hintergrund - Prozess Version 1.7, Stand 12.08.2010
# 
# Das Skript wird alle 12 Stunden vom loop Prozess aufgerufen
#
# Dies ist ein Benutzer - individualisiertes Skript
#
# Update-Dienst:
# ===============
# Das Skript uebertraegt rund alle 12 Stunden den aktuellen meine-homematic.de Schluessel auf die lokale HomeMatic.
#
#
# Changelog:
# ===========
# Version 1.7
# Anpassung des Updateintervalls auf 2x täglich
#
# **************************************************************************************************************************************************
#
ADDONDIR=/usr/local/etc/config/addons/mh

#altes Schluessel-Paket loeschen
v1=`rm $ADDONDIR/vpnkey_ccu.tar.gz`
#
#das Paket des Benutzers herunter laden
v2=`wget -O $ADDONDIR/vpnkey_ccu.tar.gz 'http://www.meine-homematic.de/getkeyv2.php?id=11&key=dummykey' -q`
#
#Versionskontrolle entpacken
v3=`tar -zxvf vpnkey_ccu.tar.gz newver`
#
#prüfen, ob wir die aktuellste Version haben oder updaten müssen
oldvar=`cat $ADDONDIR/oldver`
newver=`cat $ADDONDIR/newver`
if [ $oldvar -lt $newver ] 
then 
     # Heruntergeladene Version ist neuer, Update Prozess durchfuehren 
     /bin/busybox logger -t homematic -p user.info "meine-homematic.de Update Prozess, heruntergeladene Version ist neuer, führe Update durch."
     v4=`tar -zxvf vpnkey_ccu.tar.gz`
     v5=`chmod 777 $ADDONDIR/update.sh`
     upd=`/bin/sh $ADDONDIR/update.sh >> /dev/null`
     /bin/busybox logger -t homematic -p user.info "meine-homematic.de Update Prozess beendet"
fi

