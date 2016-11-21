#!/bin/sh
#
# **************************************************************************************************************************************************
#
# meine-homematic.de Hintergrund - Prozess Version 1.7, Stand 12.08.2010
#
# Dies ist ein Benutzer - individualisiertes Skript
#
# Hammering-Schutz:
# ==================
# Das Skript kontrolliert, ob das aktuelle Datum nach dem Datum liegt, bis zu dem der Premium Zugang gültig ist.
# Ist der Zugang abgelaufen, wird ein evtl. laufender openvpn Prozess beendet.
# Dies ist notwendig, da die HomeMatic sonst permantent versucht eine Verbindung mit dem VPN Server aufzubauen.
#
# Changelog:
# ===========
# Version 1.7: 
# Fehler in der Datumsauswertung behoben
#
# **************************************************************************************************************************************************
#
ADDONDIR=/usr/local/etc/config/addons/mh

  #Dienst Status einlesen
  dienst=`/bin/busybox cat $ADDONDIR/dienst`
  dienstngx=`/bin/busybox cat $ADDONDIR/dienstngx`
  dienstzbx=`/bin/busybox cat $ADDONDIR/dienstzbx`

  #
  # Teilbereich Hammering - Schutz
  # 
  nowdate=$(date +%s)
  # Enddatum wird individuell gesetzt, in Abhängigkeit der Schlüssel - Laufzeit
  enddate=$(date -d "010123592010" +%s)
  if [ $enddate -ge $nowdate ] 
  then  
     #
     # Aktuelles Datum ist vor dem Enddatum. VPN starten, falls es nicht läuft
     #
     Processname=openvpn
     if [ ! -n "`pidof $Processname`" ] ; then  
        if [ $dienst -ge 1 ] ; then
			/bin/busybox logger -t homematic -p user.info "meine-homematic.de loophammer startet openvpn."
			ovstart=`/opt/mh/openvpn --daemon --config $ADDONDIR/client.conf --cd $ADDONDIR`
		fi 
     fi

	if [ ! -e $ADDONDIR/zabbix.conf ] ; then
		Processname=zabbix_agentd
		if [ ! -n "`pidof $Processname`" ] ; then  
			/bin/busybox logger -t homematic -p user.info "CloudMatic monitoring Dienst wird gestartet"
			ovstart=`/etc/config/addons/mh/zabbix_agentd -c /etc/config/addons/mh/zabbix.conf >/dev/null 2>&1`
		fi
	fi

	Processname=nginx
	if [ ! -n "`pidof $Processname`" ] ; then  
		/bin/busybox logger -t homematic -p user.info "Reverse Proxy Dienst wird gestartet"
		ovstart=`/usr/local/etc/config/addons/mh/nginx`
	fi
 else
    #
    # Aktuelles Datum ist nach dem Enddatum. VPN beenden, um Hammering zu unterbinden
    #
    Processname=openvpn
    if [ -n "`pidof $Processname`" ] ; then  
      /bin/busybox logger -t homematic -p user.info "Keine meine-homematic.de VPN Lizenz aktiv, openvpn wird beendet."
      /bin/busybox logger -t homematic -p user.info "Diest dient zum Schutz Ihrer HomeMatic, um permanente, ungültige Verbindungsversuche alle 10 Sekunden zu unterbinden."
      dummy=`killall -9 openvpn`
    fi
	Processname=nginx
	if [ -n "`pidof $Processname`" ] ; then  
		/bin/busybox logger -t homematic -p user.info "Reverse Proxy wurde herunter gefahren"
		dummy=`killall -9 nginx`
	fi
 fi

  
  #Wenn Dienst läuft beenden, falls Dienst = 0
    if [ $dienst -lt 1 ] ; then
		Processname=openvpn
		if [ -n "`pidof $Processname`" ] ; then  
			/bin/busybox logger -t homematic -p user.info "VPN Dienst wurde ueber Systemsteuerung beendet"
			dummy=`/bin/busybox killall openvpn`
		fi
	fi

    if [ $dienstngx -lt 1 ] ; then
		Processname=nginx
		if [ -n "`pidof $Processname`" ] ; then  
			/bin/busybox logger -t homematic -p user.info "Reverse Proxy wurde herunter gefahren"
			dummy=`killall -9 nginx`
		fi
	fi
	
	

	