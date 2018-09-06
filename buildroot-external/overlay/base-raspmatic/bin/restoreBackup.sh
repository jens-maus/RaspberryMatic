#!/bin/sh
#
# simple wrapper script to restore a standard sbk file backup
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
# restoreBackup.sh <sbk-file>
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
tar -C / --warning=no-timestamp --no-same-owner -xf ${TMPDIR}/usr_local.tar.gz

# remove all temp files
rm -rf ${TMPDIR}
