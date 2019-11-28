#!/bin/sh

BP=/etc/config

if [ -n "$1" ] ; then
	BP=${1%/}
fi



# rfd.conf: listen port 2001 -> 32001
F=$BP/rfd.conf
if [[ -e $F ]] ; then
	sed -i -e 's/\s*Listen\s*Port\s*=\s*2001/Listen Port = 32001/' $F
fi

# hs485d.conf: listen port 2000 -> 32000
F=$BP/hs485d.conf
if [[ -e $F ]] ; then
	sed -i -e 's/\s*Listen\s*Port\s*=\s*2000/Listen Port = 32000/' $F
fi



# InterfacesList.xml
F=$BP/InterfacesList.xml
if [[ -e $F ]] ; then
	sed -i -e 's/:2001/:32001/' $F
	sed -i -e 's/:9292/:39292/' $F
	sed -i -e 's/:2010/:32010/' $F
fi

