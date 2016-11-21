#!/bin/sh
echo SerialNumber=`grep Serial /proc/cpuinfo | sed 's|Serial||' | sed 's|:||' | sed 's/^[ \t]*//'` > /etc/config/addons/mh/ids
echo BidCoS-Address=`ifconfig | grep 'eth0' | tr -s ' ' | cut -d ' ' -f5 | tr ':' '-'` >> /etc/config/addons/mh/ids
