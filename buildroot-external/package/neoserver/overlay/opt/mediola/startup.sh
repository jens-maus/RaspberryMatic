#!/bin/sh

BASE_DIR=/opt/mediola
PLUGIN_DIR=/usr/local/addons/mediola
USER_DIR=/etc/config/addons/mediola
WWW_DIR=/etc/config/addons/www/mediola


if ! grep -q "ID mediola CONFIG_NAME NEOServer" /etc/config/hm_addons.cfg 2>/dev/null; then
  $BASE_DIR/install.tcl
fi


if [ ! -e $PLUGIN_DIR ] ; then

  rm -rf $USER_DIR
  mkdir -p $USER_DIR
  cp -rp $BASE_DIR/user/* $USER_DIR

  chmod -R 777 $USER_DIR
   
  rm -rf $WWW_DIR
  ln -s $BASE_DIR/www $WWW_DIR

  mkdir /usr/local/addons/
  tar -xvzf /opt/mediola/pkg/mediola.tar.gz -C /usr/local/addons/
  cp /usr/local/addons/mediola/rc.d/97NeoServer /etc/config/rc.d/97NeoServer 
  echo "*/5 * * * * /usr/local/addons/mediola/bin/watchdog" >> /usr/local/crontabs/root
fi

