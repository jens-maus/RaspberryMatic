#!/bin/sh
#
# simple wrapper script to generate a CCU compatible sbk file
#
# Copyright (c) 2016-2018 Jens Maus <mail@jens-maus.de>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Usage:
# createBackup.sh <directory>
#

BACKUPDIR=/usr/local/tmp

source /VERSION 2>/dev/null

BACKUPFILE="$(hostname)-${VERSION}-$(date +%Y-%m-%d-%H%M).sbk"

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -f|--file)
    BACKUPFILE="$2"
    shift # past argument
    shift # past value
    ;;
    -o|--output)
    BACKUPDIR="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    shift # past argument
    ;;
esac
done

# make sure BACKUPDIR exists
TMPDIR=$(mktemp -d -p ${BACKUPDIR})

# make sure ReGaHSS saves its current settings
echo 'load tclrega.so; rega system.Save()' | tclsh 2>&1 >/dev/null

# create a gzipped tar of /usr/local
tar --owner=root --group=root --exclude=/usr/local/tmp --exclude=/usr/local/lost+found --exclude=${BACKUPDIR} --exclude-tag=.nobackup --one-file-system --ignore-failed-read -czf ${TMPDIR}/usr_local.tar.gz /usr/local 2>/dev/null

# sign the configuration with the current key
crypttool -s -t 1 <${TMPDIR}/usr_local.tar.gz >${TMPDIR}/signature

# store the current key index
crypttool -g -t 1 >${TMPDIR}/key_index

# store the firmware VERSION
cp /VERSION ${TMPDIR}/firmware_version

# create sbk file
tar -C ${TMPDIR} --owner=root --group=root -cf ${BACKUPDIR}/${BACKUPFILE} usr_local.tar.gz signature key_index firmware_version 2>/dev/null

# remove all temp files
rm -rf ${TMPDIR}
