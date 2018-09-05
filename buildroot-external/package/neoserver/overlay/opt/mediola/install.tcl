#!/bin/tclsh

package require HomeMatic

set ID          mediola
set URL         /addons/mediola/index.html
set NAME        NEOServer

array set DESCRIPTION {
  de {<li>NEO Server</li>} 
  en {<li>NEO Server</li>}
}

::HomeMatic::Addon::AddConfigPage $ID $URL $NAME [array get DESCRIPTION]
