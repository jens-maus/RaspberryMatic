#!/bin/sh

CFGFILE="/etc/config/snmp/snmpd-ccu3.conf"
DAEMON=/etc/init.d/S59snmpd

#stop daemon
$DAEMON stop >/dev/null 2>&1 || exit 1
for i in 1 2 3 4 5 6 7 8 9 10;
do
    wfs_X=$(pidof snmpd)
    if [ "$wfs_X" = "" ]; then
        break
    fi
    if [ $i -ge 10 ]; then
        break
    fi
    sleep 1
done
rm -rf /var/lib/snmp
rm -f $CFGFILE

exit 0
