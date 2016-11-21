#!/bin/sh
#
# **************************************************************************************************************************************************
#
# meine-homematic.de Versions - Upgrade Script Stand 05.04.2016
# 
# **************************************************************************************************************************************************
# 
BASE_DIR=/opt/mh
USER_DIR=/etc/config/addons/mh
WWW_DIR=/etc/config/addons/www/mh

/bin/busybox logger -t homematic -p user.info "meine-homematic.de Versions - Upgrade auf Release 2016-04"

#
# Neue User - Dateien der meine-homematic.de Unterstützung in Version Release 2016-04 kopieren
# 
cp -p $BASE_DIR/user/keytransfer $USER_DIR
cp -p $BASE_DIR/user/keytransferan $USER_DIR
cp -p $BASE_DIR/user/keytransferaus $USER_DIR
cp -p $BASE_DIR/user/mhca.crt $USER_DIR
cp -p $BASE_DIR/user/dotest.sh $USER_DIR
cp -p $BASE_DIR/user/dienstan.sh $USER_DIR
cp -p $BASE_DIR/user/dienstaus.sh $USER_DIR
cp -p $BASE_DIR/user/cloudmaticcheck.sh $USER_DIR
cp -p $BASE_DIR/user/addcron.sh $USER_DIR
cp -p $BASE_DIR/user/loop.sh $USER_DIR

echo "Neue Dateien kopiert"

