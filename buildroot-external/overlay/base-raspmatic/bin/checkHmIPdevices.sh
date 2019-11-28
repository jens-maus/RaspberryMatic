#!/bin/sh
#
# crRFD device check script v1.3
# Copyright (c) 2019 Jens Maus <mail@jens-maus.de>
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
# This script checks all *.dev,*.ap,*.apkx files in /etc/config/crRFD/data
# and moves files to a backup directory for which the SGTIN cannot be found
# in the homematic.regadom file of ReGaHss
#

# do not continue if homematic.regadom is not there or empty
[[ -s /etc/config/homematic.regadom ]] || exit 1

# do not continue if /etc/config/crRFD/data does not exist
[[ -d /etc/config/crRFD/data ]] || exit 1

# check for "-f" option to start fixing operation
[[ "${1}" == "-f" ]] && FIX=1 || FIX=0

# check if regadom contains HmIP-RCV already and if not we don't
# move away any ap + apkx files
if grep -q -m1 "<devlabel>HmIP-RCV-" /etc/config/homematic.regadom; then
  FILE_PATTERN="[0-9A-F]{24}\.(dev|ap|apkx)$"
else
  FILE_PATTERN="[0-9A-F]{24}\.dev$"
fi

FILES=$(ls /etc/config/crRFD/data | egrep ${FILE_PATTERN} | cut -d. -f1 | uniq)
for sgtin in ${FILES}; do

  # check if this SGTIN belongs to a HmIPW-DRAP by checking if it is
  # listed in metaData.conf and if so skip it
  if grep -q "${sgtin}:type\":\"HmIPW-DRAP\"" /etc/config/crRFD/data/metaData.conf &>/dev/null; then
    continue
  fi

  DEVADR=${sgtin:(-14)}
  if [[ -n "${DEVADR}" ]]; then
    grep -iq -m1 "<devadr>${DEVADR}" /etc/config/homematic.regadom
    if [[ $? -ne 0 ]]; then
      echo -n "WARNING: SGTIN ${DEVADR} not found in regadom"
      if [[ ${FIX} -eq 1 ]]; then
        [[ -d /etc/config/crRFD/data/old ]] || mkdir -p /etc/config/crRFD/data/old
        mv /etc/config/crRFD/data/${sgtin}.* /etc/config/crRFD/data/old/
        echo "... moved ${sgtin}.* to /etc/config/crRFD/data/old/"
      else
        echo "."
      fi
    fi
  fi
done

exit 0
