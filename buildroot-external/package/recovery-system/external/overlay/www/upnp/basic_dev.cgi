#!/bin/sh

serial=$(ip addr show eth0 | grep ether | awk '{ print $2 }')
ip=$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)
hostname=$(hostname)

echo -ne "Content-type: text/html; charset=iso-8559-1\r\n"
echo -ne "Pragma-directive: no-cache\r\n"
echo -ne "Cache-directive: no-cache\r\n"
echo -ne "Cache-control: no-cache\r\n"
echo -ne "Pragma: no-cache\r\n"
echo -ne "Expires: 0\r\n"
echo -ne "\r\n"

/bin/cat << EOM
<?xml version="1.0"?>
<root xmlns="urn:schemas-upnp-org:device-1-0">
<specVersion>
<major>1</major>
<minor>0</minor>
</specVersion>
<URLBase>http://$ip/upnp/</URLBase>
<device>
<deviceType>urn:schemas-upnp-org:device:Basic:1</deviceType>
<presentationURL></presentationURL>
<friendlyName>$hostname</friendlyName>
<manufacturer>EQ3</manufacturer>
<manufacturerURL>http://www.homematic.com</manufacturerURL>
<modelDescription>HomeMatic Central $serial</modelDescription>
<modelName>HomeMatic Central</modelName>
<UDN>uuid:upnp-BasicDevice-1_0-$serial</UDN>
<UPC>123456789002</UPC>
<serviceList>
<service>
<serviceType>urn:schemas-upnp-org:service:dummy:1</serviceType>
<serviceId>urn:upnp-org:serviceId:dummy1</serviceId>
<controlURL></controlURL>
<eventSubURL></eventSubURL>
<SCPDURL></SCPDURL>
</service>
</serviceList>
</device>
</root>
EOM
