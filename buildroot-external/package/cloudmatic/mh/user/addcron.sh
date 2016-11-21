#!/bin/sh
# Script inspired by J.Maus
if [ -s /usr/local/crontabs/root ]; then
  cat /usr/local/crontabs/root | grep -v "/usr/local/etc/config/addons/mh/loopupd.sh" | sort | uniq >/tmp/crontab.$$
  # we make sure we don't overwrite with an empty file
  # because on the CCU2+RaspberryMatic it should never be empty!
  if [ -s /tmp/crontab.$$ ]; then
    mv /tmp/crontab.$$ /usr/local/crontabs/root
  fi
fi
(crontab -l 2>/dev/null; echo "07 */6 * * * /bin/sh /usr/local/etc/config/addons/mh/loopupd.sh >> /dev/null") | crontab -
