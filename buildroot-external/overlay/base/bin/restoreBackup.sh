#!/bin/sh
#
# simple wrapper script to restore a standard sbk file backup
#
# Copyight (c) 2016 Jens Maus <mail@jens-maus.de>
#

BACKUPFILE="${1}"
BACKUPDIR=/usr/local/backup

if [ -z "${1}" ]; then
  echo "ERROR: no .sbk backup file specified"
  exit 1
fi

# extract the sbk to /usr/local/backup
mkdir -p ${BACKUPDIR}
tar -C ${BACKUPDIR} -xf ${BACKUPFILE}

# make sure all relevant services are stopped
/etc/init.d/S70ReGaHss stop
/etc/init.d/S62HMServer stop
/etc/init.d/S61rfd stop
/etc/init.d/S60hs485d stop
/etc/init.d/S50lighttpd stop

# now remove the whole /usr/local, but keep /usr/local/backup
find /usr/local -not -name backup -not -name "lost+found" -mindepth 1 -maxdepth 1 -exec rm -rf {} \;

# extract usr_local.tar.gz
tar -C / -xf ${BACKUPDIR}/usr_local.tar.gz

# remove all temp files
rm -f ${BACKUPDIR}/usr_local.tar.gz ${BACKUPDIR}/signature ${BACKUPDIR}/key_index ${BACKUPDIR}/firmware_version
