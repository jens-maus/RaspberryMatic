#!/bin/sh
#
# **************************************************************************************************************************************************
#
# meine-homematic.de Versions - Upgrade Script Stand 29.08.2010
# 
# **************************************************************************************************************************************************
# 
BASE_DIR=/opt/mh
USER_DIR=/etc/config/addons/mh
WWW_DIR=/etc/config/addons/www/mh

/bin/busybox logger -t homematic -p user.info "meine-homematic.de Versions - Upgrade auf 1.503"
touch $USER_DIR/upd1503


#
# Neue User - Dateien der meine-homematic.de Unterstützung in Version 1.503 kopieren
# 
cp -p $BASE_DIR/user/autoupdate $USER_DIR
cp -p $BASE_DIR/user/autoupdatean $USER_DIR
cp -p $BASE_DIR/user/autoupdatean.sh $USER_DIR
cp -p $BASE_DIR/user/autoupdateaus $USER_DIR
cp -p $BASE_DIR/user/autoupdateaus.sh $USER_DIR
cp -p $BASE_DIR/user/dienstan.sh $USER_DIR
cp -p $BASE_DIR/user/dienstaus.sh $USER_DIR

echo "Neue Dateien kopiert"


cd $USER_DIR

while read V1;
do
  if [ "$V1" = "user_has_account=1" ] 
  then
#   Upgrade auf Version 1.503 und Benutzer hat bereits gueltiges meine-homematic.de Konto
#   VPN und Auto Update einschalten
    echo "1" > $USER_DIR/autoupdate
    echo "1" > $USER_DIR/dienst
    /bin/busybox logger -t homematic -p user.info "meine-homematic.de VPN Dienst und Autoupdate aktiviert"
    echo "meine-homematic.de VPN Dienst und Autoupdate aktiviert"
    #
    # Aktuellen Key auf die CCU laden und normales Update Script ausfuehren
    # 
    echo "12345" > $USER_DIR/oldver
    upd=`/bin/sh $USER_DIR/loopupd.sh >> /dev/null`
  fi
  if [ "$V1" = "user_has_account=0" ] 
  then
#   Upgrade auf Version 1.503 und Benutzer hat KEIN gueltiges meine-homematic.de Konto
#   VPN und Auto Update AUSschalten
    echo "0" > $USER_DIR/autoupdate
    echo "0" > $USER_DIR/dienst
    /bin/busybox logger -t homematic -p user.info "meine-homematic.de VPN Dienst und Autoupdate DEAKTIVIERT"
    echo "meine-homematic.de VPN Dienst und Autoupdate DEAKTIVIERT"
  fi
done <$USER_DIR/mhcfg

