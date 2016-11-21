#!/bin/sh
ADDONDIR=/usr/local/etc/config/addons/mh

v5=`rm -f /etc/config/addons/mh/result2.txt'`

v5=`echo '<h2><u><b>Erweiterte Systeminformationen f&uuml;r den meine-homematic.de Support:</u></b></h2>' >> /etc/config/addons/mh/result2.txt`

v5=`echo '<u><b>Interfaces via ifconfig</u></b>' >> /etc/config/addons/mh/result2.txt`
v5=`ifconfig >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`

v5=`echo '<u><b>Routing</u></b>' >> /etc/config/addons/mh/result2.txt`
v5=`route -n >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`

v5=`echo '<u><b>Resolve Config</u></b>' >> /etc/config/addons/mh/result2.txt`
v5=`more /etc/resolv.conf >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`

v5=`echo '<u><b>Inhalt mhcfg</u></b>' >> /etc/config/addons/mh/result2.txt`
v5=`more /etc/config/addons/mh/mhcfg >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`

v5=`echo '<u><b>Inhalt client.conf</u></b>' >> /etc/config/addons/mh/result2.txt`
v5=`more /etc/config/addons/mh/client.conf >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`

v5=`echo '<u><b>Inhalt client.crt</u></b>' >> /etc/config/addons/mh/result2.txt`
v5=`more /etc/config/addons/mh/client.crt >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`

v5=`echo '<u><b>Verzeichnisinformationen</u></b>' >> /etc/config/addons/mh/result2.txt`
v5=`ls -al /etc/config/addons/mh/* >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`

v5=`echo '<u><b>Laufende Prozesse</u></b>' >> /etc/config/addons/mh/result2.txt`
v5=`ps aux >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`

v5=`echo '<u><b>IDs</u></b>' >> /etc/config/addons/mh/result2.txt`
v5=`more /etc/config/ids >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`
v5=`echo ' ' >> /etc/config/addons/mh/result2.txt`
