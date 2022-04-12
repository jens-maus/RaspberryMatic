#!/bin/sh
# shellcheck shell=dash disable=SC2169,SC3010,SC1091,SC3036
#
# HomeMatic/homematicIP Co-Processor connectivity check
# Copyright (c) 2022 Jens Maus <mail@jens-maus.de>
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
# This script can be executed and will try to check if a connected
# HomeMatic/homematicIP Co-Processor (RPI-RF-MOD, HM-MOD-RPI-PCB, HmIP-RFUSB)
# is still connected and returns a proper exit code accordingly.
#
# This script returns the following result codes:
#
# 0 = All found Co-Processors available correctly
# 1 = No Co-Processor found
# 2 = One or more Co-Processors are found to be not connected anymore
#

# source all data from /var/hm_mode
[[ -r /var/hm_mode ]] && . /var/hm_mode

# check for all unique HM_ device nodes
DEVNODES=$(echo -e "${HM_HMRF_DEVNODE}\\n${HM_HMIP_DEVNODE}" | uniq)

# walk through all DEVNODES and check if the
# sysfs raw-uart entry still exists and if not we trigger an
# alarm message
rc=1
for dev in ${DEVNODES}; do
  DEVNODE=$(basename "${dev}")
  rc=0
  if [[ "${DEVNODE}" == "raw-uart*" ]]; then
    if [[ ! -e "/sys/class/raw-uart/${DEVNODE}" ]]; then
      echo "ERROR: /sys/class/raw-uart/${DEVNODE} missing"
      rc=2
      break
    fi
  fi
done

exit ${rc}
