#!/bin/tclsh
#
# Simple tclsh script for triggering an alarm message at the first
# ALARMDP system variable with name "Alarmzone 1".
#
# Copyright (c) 2017 Jens Maus <mail@jens-maus.de>
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
# triggerAlarm.tcl <msg>
#

load tclrpc.so
load tclrega.so

if { $argc != 1 } {
  puts "ERROR: script requires exactly one argument"
  return
}

# function to return a list of alarm variables
proc getAlarmZoneVariableID { } {
  set script "
    string sSysVarId;
    foreach (sSysVarId, dom.GetObject(ID_SYSTEM_VARIABLES).EnumUsedIDs()) {
      object oSysVar = dom.GetObject(sSysVarId);
      string sValueType = oSysVar.ValueType();

      if(oSysVar.TypeName() == 'ALARMDP') {
        WriteLine(sSysVarId # ';' # oSysVar.Name());
      }
    }
  "

  if { ![catch {array set result [rega_script $script]}] } then {
    set variables [split $result(STDOUT) "\n"]
    foreach subsection $variables {
      set b [split $subsection ";"]
      set sysVarId [lindex $b 0]
      set sysVarName [string tolower [lindex $b 1]]
      if {[regexp ".*alarmzone.*1" $sysVarName]} {
        return $sysVarId
      }
    }
  }
  return ""
}

proc triggerAlarm { msg } {
  set sysVarAlarmZone1 [getAlarmZoneVariableID]
  if { [string length $sysVarAlarmZone1] > 0 } then {
    set script "
      dom.GetObject('$sysVarAlarmZone1').State(true);
      dom.GetObject('$sysVarAlarmZone1').DPInfo('$msg');
    "

    if { ![catch {array set result [rega_script $script]}] } then {
      return true
    }
  }

  return false
}

set res [triggerAlarm [lindex $argv 0]]
