#!/bin/sh
#
# simple wrapper script to restore a standard sbk file backup
#
# Copyright (c) 2016-2017 Jens Maus <mail@jens-maus.de>
#

BACKUPFILE="${1}"
BACKUPDIR=/usr/local/tmp

if [ -z "${1}" ]; then
  echo "ERROR: no .sbk backup file specified"
  exit 1
fi

TMPDIR=$(mktemp -d -p ${BACKUPDIR})

# extract the sbk to /usr/local/tmp
tar -C ${TMPDIR} -xf ${BACKUPFILE}

# make sure all relevant services are stopped
/etc/init.d/S70ReGaHss stop
/etc/init.d/S62HMServer stop
/etc/init.d/S61rfd stop
/etc/init.d/S60hs485d stop
/etc/init.d/S50lighttpd stop
/sbin/start-stop-daemon -K -q -p /var/run/crond.pid

# wait some time to get all daemons time to finish
sleep 5

# now remove the whole /usr/local, but keep /usr/local/tmp
find /usr/local -not -name tmp -not -name "lost+found" -mindepth 1 -maxdepth 1 -exec rm -rf {} \;

# extract usr_local.tar.gz
tar -C / -xf ${TMPDIR}/usr_local.tar.gz

# remove all temp files
rm -rf ${TMPDIR}
