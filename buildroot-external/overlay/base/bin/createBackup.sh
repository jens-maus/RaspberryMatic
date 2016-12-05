#!/bin/sh
#
# simple wrapper script to generate a CCU compatible sbk file
#
# Copyight (c) 2016 Jens Maus <mail@jens-maus.de>
#

BACKUPDIR=/usr/local/backup

if [ -n "${1}" ]; then
  BACKUPDIR=$1
fi

# make sure BACKUPDIR exists
mkdir -p ${BACKUPDIR}

# make sure ReGaHSS saves its current settings
echo 'load tclrega.so; rega system.Save()' | tclsh 2>&1 >/dev/null

# create a gzipped tar of /usr/local
tar --exclude=/usr/local/backup --exclude=/usr/local/lost+found -czf ${BACKUPDIR}/usr_local.tar.gz /usr/local 2>/dev/null

# sign the configuration with the current key
crypttool -s -t 1 <${BACKUPDIR}/usr_local.tar.gz >${BACKUPDIR}/signature

# store the current key index
crypttool -g -t 1 >${BACKUPDIR}/key_index

# store the firmware VERSION
cp /boot/VERSION ${BACKUPDIR}/firmware_version

# create sbk file
tar -C ${BACKUPDIR} -cf ${BACKUPDIR}/"$(hostname)-$(date +%Y-%m-%d-%H%M).sbk" usr_local.tar.gz signature key_index firmware_version 2>/dev/null

# remove all temp files
rm -f ${BACKUPDIR}/usr_local.tar.gz ${BACKUPDIR}/signature ${BACKUPDIR}/key_index ${BACKUPDIR}/firmware_version
