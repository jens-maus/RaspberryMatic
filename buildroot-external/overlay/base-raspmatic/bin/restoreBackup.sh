#!/bin/sh
#
# simple wrapper script to restore a standard sbk file backup
#
# Copyright (c) 2016-2019 Jens Maus <mail@jens-maus.de>
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
if [[ -d "${TMPDIR}" ]]; then

  # extract the sbk to /usr/local/tmp
  tar -C "${TMPDIR}" -xf "${BACKUPFILE}"

  # check archive consistency using sha256
  if [[ "${TMPDIR}/signature.sha256" ]]; then
    (cd "${TMPDIR}"; sha256sum -s -c signature.sha256)
    if [[ $? -ne 0 ]]; then
      echo "ERROR: inconsistent backup archive identified (sha256)."
      rm -rf "${TMPDIR}"
      exit 1
    fi
  fi

  # check archive consistency using crypttool
  CUR_SIGNATURE=$(crypttool -s -t 0 <"${TMPDIR}/usr_local.tar.gz")
  OLD_SIGNATURE=$(cat "${TMPDIR}/signature")
  if [[ -z "${CUR_SIGNATURE}" || "${CUR_SIGNATURE}" != "${OLD_SIGNATURE}" ]]; then
    echo "ERROR: inconsistent backup archive identified (crypttool)."
    rm -rf "${TMPDIR}"
    exit 1
  fi

  # make sure all relevant services are stopped
  /etc/init.d/S98crond stop
  /etc/init.d/S70ReGaHss stop
  /etc/init.d/S62HMServer stop
  /etc/init.d/S61rfd stop
  /etc/init.d/S60hs485d stop
  /etc/init.d/S50lighttpd stop

  # wait some time to get all daemons time to finish
  sleep 5

  # now remove the whole /usr/local, but keep /usr/local/tmp
  find /usr/local -xdev -not -name tmp -not -name "lost+found" -mindepth 1 -maxdepth 1 -exec rm -rf {} \;

  # extract usr_local.tar.gz but make sure NOT to unarchive anything outside
  # /usr/local or this might overwrite unwanted things if present in the archive
  tar -C /usr/local --strip-components=2 --warning=no-timestamp --no-same-owner -xf "${TMPDIR}/usr_local.tar.gz" usr/local

  # remove all temp files
  rm -rf "${TMPDIR}"

  # sync filesystem
  sync

  # make sure all relevant services are started again
  /etc/init.d/S50lighttpd start
  /etc/init.d/S60hs485d start
  /etc/init.d/S61rfd start
  /etc/init.d/S62HMServer start
  /etc/init.d/S70ReGaHss start
  /etc/init.d/S98crond start

  exit 0
else
  exit 1
fi
