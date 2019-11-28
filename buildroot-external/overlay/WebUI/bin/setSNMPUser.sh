#!/bin/sh

#vars
CFGFILE="/etc/config/snmp/snmpd-ccu3.conf"
DAEMON=/etc/init.d/S59snmpd

# functions
wait_for_stopped ()
{
    for i in 1 2 3 4 5 6 7 8 9 10;
    do
        wfs_X=$(pidof snmpd)
        if [ "$wfs_X" = "" ]; then
            return
        fi
        if [ $i -ge 10 ]; then
            return
        fi
        sleep 1
    done
}


#check for params
if test $# -ne 2; then
    echo "Usage: setSNMPUser.sh <username> <password>"
    exit 1
fi

U=$1
P=$2

# Stop snmpd (documentation says the daemon shall be stopped before changing config)
$DAEMON stop >/dev/null 2>&1 || true
wait_for_stopped

# recreate cfg file
rm -f $CFGFILE
touch $CFGFILE
rm -rf /var/lib/snmp

# Add command to create user and start snmpd
echo "createUser $U SHA \"$P\" AES \"$P\"" >> $CFGFILE
$DAEMON start >/dev/null 2>&1 || exit 10
for i in 1 2 3 4 5 6 7 8 9 10; 
do
    wfs_X=$(cat /var/lib/snmp/snmpd.conf | grep usmUser)
    if [ "$wfs_X" != "" ]; then
        break
    fi
    if [ $i -ge 10 ]; then
        exit 11
    fi
    sleep 1
done

# copy file from /var/lib/snmp to non-tmps path
$DAEMON stop >/dev/null 2>&1 || exit 12
wait_for_stopped

cp -f /var/lib/snmp/snmpd.conf $CFGFILE
# Add user access right directive
echo "rouser $U" >> $CFGFILE

# Cleanup and finally start snmpd again
rm -rf /var/lib/snmp
$DAEMON start >/dev/null 2>&1  || exit 20

exit 0
