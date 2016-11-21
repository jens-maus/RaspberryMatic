#!/bin/sh
#
# **************************************************************************************************************************************************
#
# cloudmatic.de Hintergrund - Prozess Version 2.0, Stand 02.04.2016
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
# Wir laufen in einer Endlosschleife
#
while [ 1 -ge 1 ]
do
  #
  # Teilbereich Provisionierung des initialen Keys
  #
  initialkey=`cat $ADDONDIR/keytransfer`
  if [ $initialkey -ge 1 ] ; then
    doupd=`/bin/tclsh /opt/mh/www/transferinitialkey.cgi`
  fi

  #
  # Teilbereich Update - Prozess
  #
  updcounter=`expr $updcounter + 1`

  #
  #Vergleich mit 744 (31*24) statt mit 720 (30*24) um ein Sliding Window zu bekommen und eine Lastverteilung der Updateanfragen zu garantieren
  #
  if [ $updcounter -ge 744 ] ; 
  then  
     updcounter=0

     #Status einlesen
     autoupdate=`cat $ADDONDIR/autoupdate`
     if [ $autoupdate -ge 1 ] ; then
       doupd=`/bin/sh $ADDONDIR/loopupd.sh`
     fi
  fi

  #
  # Teilbereich Hammering - Schutz
  # 
  dohammer=`/bin/sh $ADDONDIR/loophammer.sh`

  sleep 60
done
  