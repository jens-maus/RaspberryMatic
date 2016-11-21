#!/bin/sh
ADDONDIR=/usr/local/etc/config/addons/mh
v1=`cp $ADDONDIR/badip $ADDONDIR/checkip`
v2=`cp $ADDONDIR/baddns $ADDONDIR/checkdns`
v4=`wget -O $ADDONDIR/checkdns 'http://www.meine-homematic.de/statusdns.php' -q`

v5=`rm -f /etc/config/addons/mh/result.txt'`

v5=`echo '<h2><u><b>Testergebnisse:</u></b></h2>' >> /etc/config/addons/mh/result.txt`

v5=`echo '<h3><u><b>Schritt 1 - IP Konnektivit&auml;t:</u></b></h3>' >> /etc/config/addons/mh/result.txt`

v5=`echo '<u><b>PING auf die IP des VPN-Clusters</u></b>' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Erwartetes Ergebnis: 3 packets transmitted, 3 packets received, 0% packet loss' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Ergebnis:' >> /etc/config/addons/mh/result.txt`
v5=`ping -q -c 3 37.187.191.205 >> /etc/config/addons/mh/result.txt`


v5=`echo ' ' >> /etc/config/addons/mh/result.txt`
v5=`echo '<b><u>Bewertung:</u></b>' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Waren diese Tests nicht erfolgreich, haben Sie ein Problem mit der Netzwerk Konfiguration Ihrer CCU.' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Das Default Gateway wurde vermutlich falsch gesetzt. Es muss sich im selben Subnetz befinden wie Ihre CCU. ' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Oft wird als lokales Netzwerk 192.168.178.0 oder 192.168.0.0 verwendet. ' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Die CCU hat dann z.B. eine IP 192.168.178.101 oder 192.168.0.20' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Die IP Addresse Ihres Routers sollte dann meist 192.168.178.1 oder 192.168.0.1 haben. Wichtig ist, dass der erste Teil der CCU IP der IP des Routers entspricht. ' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Bitte schauen Sie in das Handbuch Ihres DSL/UMTS/LTE Routers f&uuml;r weitere Informationen.' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Tragen Sie unter Systemsteuerung - Netzwerkeinstellungen auf Ihrer CCU Zentrale die IP Adresse Ihres Routers im Feld "Gateway" ein.' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Starten Sie anschliessend Ihre CCU via Systemsteuerung - Zentralen-Wartung neu. (NICHT den Reset-Knopf dr&uuml;cken!) ' >> /etc/config/addons/mh/result.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result.txt`

v5=`echo '<h3><u><b>Schritt 2 - Grosse Pakete:</u></b></h3>' >> /etc/config/addons/mh/result.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result.txt`
v5=`echo '<u><b>PING auf die IP des VPN-Clusters mit grossen Paketen</u></b>' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Erwartetes Ergebnis: 3 packets transmitted, 3 packets received, 0% packet loss' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Ergebnis:' >> /etc/config/addons/mh/result.txt`
v5=`ping -q -s 1400 -c 3 37.187.191.205 >> /etc/config/addons/mh/result.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result.txt`
v5=`echo 'War dieser Test nicht erfolgreich, haben Sie eine geringe Paketgr&ouml;sse zur Verf&uuml;gung. Der Zugriff sollte funktionieren, kann aber langsamer sein.' >> /etc/config/addons/mh/result.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result.txt`

v5=`echo '<h3><u><b>Schritt 3 - DNS Namensaufl&ouml;sung:</u></b></h3>' >> /etc/config/addons/mh/result.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result.txt`
v5=`echo '<u><b>PING auf den DNS Eintrag des WEB-Clusters</u></b>' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Erwartetes Ergebnis bei funktionierendem DNS: 3 packets transmitted, 3 packets received, 0% packet loss' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Ergebnis:' >> /etc/config/addons/mh/result.txt`
v5=`ping -q -c 3 www.meine-homematic.de >> /etc/config/addons/mh/result.txt`

v5=`echo ' ' >> /etc/config/addons/mh/result.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result.txt`
v5=`echo '<u><b>PING auf den DNS Eintrag des VPN-Clusters</u></b>' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Erwartetes Ergebnis bei funktionierendem DNS: 3 packets transmitted, 3 packets received, 0% packet loss' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Ergebnis:' >> /etc/config/addons/mh/result.txt`
v5=`ping -q -c 3 cluster1.meine-homematic.de >> /etc/config/addons/mh/result.txt`

v5=`echo ' ' >> /etc/config/addons/mh/result.txt`
v5=`echo '<b><u>Bewertung:</u></b>' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Waren diese Tests nicht erfolgreich, haben Sie ein Problem mit der DNS Konfiguration Ihrer CCU.' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Ihre CCU kann keine Namensaufl&ouml;sung machen. Diese wird zum Erreichen unserer Server ben&ouml;tigt. Sie k&ouml;nnen so keine Mails oder SMS verschicken. ' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Tragen Sie unter Systemsteuerung - Netzwerkeinstellungen auf Ihrer CCU Zentrale die IP Adresse Ihres Routers im Feld "Bevorzugter DNS-Server" ein. Sie k&ouml;nnen alternativ die IP Addresse 8.8.8.8 eintragen. ' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Starten Sie anschliessend Ihre CCU via Systemsteuerung - Zentralen-Wartung neu. (NICHT den Reset-Knopf dr&uuml;cken!) ' >> /etc/config/addons/mh/result.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result.txt`

v5=`echo '<h3><u><b>Schritt 4 - VPN Dienst:</u></b></h3>' >> /etc/config/addons/mh/result.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result.txt`
v5=`echo '<u><b>Test ob der VPN Dienst in der Prozessliste der CCU steht</u></b>' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Erwartetes Ergebnis bei gestartetem Dienst: Ein Eintrag der Form "/opt/mh/openvpn --daemon [...]"' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Ergebnis:' >> /etc/config/addons/mh/result.txt`
v5=`ps aux | grep openvpn >> /etc/config/addons/mh/result.txt`

v5=`echo ' ' >> /etc/config/addons/mh/result.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result.txt`
v5=`echo '<b><u>Test der IP Konfiguration des Tunnel Interfaces</u></b>' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Erwartetes Ergebnis bei gestartetem Dienst: KEINE Meldung Device not found sondern Details zum Interface "tun0"' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Ergebnis:' >> /etc/config/addons/mh/result.txt`
v5=`ifconfig tun0 >> /etc/config/addons/mh/result.txt`

v5=`echo ' ' >> /etc/config/addons/mh/result.txt`
v5=`echo '<b><u>Bewertung:</u></b>' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Wenn Sie keinen Premium Zugang gebucht haben, ist es OK, wenn der VPN Tunnel nicht aktiv ist und Sie kein Interface tun0 sehen.' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Pr&uuml;fen Sie sonst, ob die Laufzeit Ihres VPN Zugangs noch g&uuml;ltig ist und ob der VPN Dienst gestartet ist. ' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Wenn es hier Probleme gibt, sollten Sie den pers&ouml;nlichen VPN Schl&uuml;ssel von der meine-homematic.de Homepage herunter laden und via Zusatzsoftware einspielen. ' >> /etc/config/addons/mh/result.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result.txt`
v5=`echo 'Bitte pr&uuml;fen Sie nun die G&uuml;ltigkeit Ihres VPN Schl&uuml;ssels:' >> /etc/config/addons/mh/result.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result.txt`

