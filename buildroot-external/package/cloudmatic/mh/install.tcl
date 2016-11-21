#!/bin/tclsh

package require HomeMatic

set ID          mh
set URL         /addons/mh/index.cgi
set NAME        "CloudMatic<br>(meine-homematic.de)"

array set DESCRIPTION {
  de {<li>Sicherer VPN Fernzugriff</li><li>Cloud Dienste</li><li>Fernbedienung</li><li>SMS,E-Mail,Push</li>} 
  en {<li>Secure VPN remote access</li><li>Cloud Services</li><li>Remote Control</li><li>SMS,E-Mail,Push</li>}
}

::HomeMatic::Addon::AddConfigPage $ID $URL $NAME [array get DESCRIPTION]
