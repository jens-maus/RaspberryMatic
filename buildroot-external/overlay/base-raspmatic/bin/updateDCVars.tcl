#!/bin/tclsh
#
# DutyCycle Script v2.4 developed by Andreas Bünting
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
# Dieses Script liest den DutyCycle Status der HomeMatic CCU und Gateways
# aus und erstellt automatisch eine Systemvariable vom Typ Zahl mit dem
# Gateway Namen bzw. alternativ mit der Geräte-Seriennummer. Wird der
# Gateway Name nachträglich gesetzt, wird die zuvor erstellte Systemvariable
# automatisch umbenannt. Zudem wird eine DutyCycle System-Log Meldung erzeugt,
# sofern der DutyCycle über 80% steigt. Für den HM-CFG-LAN wird der DutyCycle
# Status bei einer Verbindungsunterbrechung auf -1 gesetzt. Sofern
# Wired-Gateway eingebunden, wird eine Systemvariabel mit dem Namen
# "Wired-Status" und den Zuständen "online/offline" angelegt.

load tclrpc.so
load tclrega.so

set CONFIG_FILE {/usr/local/etc/config/rfd.conf}
set gateways [xmlrpc http://127.0.0.1:2001/ listBidcosInterfaces]

# Gateway Konfiguration aus rfd.conf einlesen
array set config {}
array set section {}
set sectionName {}

catch {
  set fd [open $CONFIG_FILE r]
  catch {
    while { ![eof $fd] } {
      set line [string trimleft [gets $fd]]
      if { "\#" != [string index $line 0] } then {
        if { [regexp {\[([^\]]+)\]} $line dummy newSectionName] } then {
          set config($sectionName) [array get section]
          set sectionName $newSectionName
        }
        if { [regexp {([^=]+)=(.+)} $line dummy name value] } then {
          set section([string trim $name]) [string trim $value]
        }
      }
    }
    set config($sectionName) [array get section]
  }
  close $fd
}

# Zentralen und Gateway DutyCycle und weitere Infos abfragen
set lines [split [string map [list "{AD" "\x00"] $gateways] "\x00"]

regsub -all "]" $lines "" lines
regsub -all "{" $lines "" lines
regsub -all "}" $lines "" lines

set ccuoben ""
set gwoben ""
set interfaces {}
set gwname {}

foreach line $lines {

  set snoben ""
  set dutycycle ""
  set type ""

  regexp "DRESS (.+?) " $line dummy snoben
  regexp "CONNECTED (.+?) " $line dummy connection
  regexp "DUTY_CYCLE (.+?) " $line dummy dutycycle
  regexp "FIRMWARE_VERSION (.+?) " $line dummy fw
  regexp "TYPE (.+)" $line dummy type
  regsub -all {\\} $type "" type
  regsub -all " " $type "" type

  if {$type == "CCU2"} {
    set ccuoben $snoben
    set ccutype "DutyCycle"
    puts "--------------------"
    puts "$dutycycle %"
    puts "$ccuoben / $fw"
    puts "$ccutype-CCU"
    # Prüfen ob DC Systemvariable für CCU2 existiert und ggf. anlegen
    append rega_cmd_create_sv "string svName ='$ccutype';object svObj = dom.GetObject(ID_SYSTEM_VARIABLES).Get(svName);if (!svObj){object svObjects = dom.GetObject(ID_SYSTEM_VARIABLES);svObj = dom.CreateObject(OT_VARDP);svObjects.Add(svObj.ID());svObj.Name(svName);svObj.ValueType(ivtFloat);svObj.ValueSubType(istGeneric);svObj.DPInfo('DutyCycle CCU');svObj.ValueUnit('%');svObj.ValueMin(-100);svObj.ValueMax(100);svObj.State(0);svObj.Internal(false);svObj.Visible(true);dom.RTUpdate(true);}"
    rega_script $rega_cmd_create_sv
    # CCU DutyCycle Variable aktualisieren
    append rega_cmd "dom.GetObject(ID_SYSTEM_VARIABLES).Get('$ccutype').State('$dutycycle');"
    rega_script $rega_cmd
    # CCU DutyCycle System-Log Meldung erzeugen sofern DC größer 80%
    if {$dutycycle >= "80"} {
      exec logger -t dutycycle -p info "$ccutype-CCU / FW: $fw / DC: $dutycycle %"
    }
  }

  # Sektion für Gateways
  set gwoben $snoben
  foreach sectionName [array names config] {
    if { {} != $sectionName } then {
      array set section $config($sectionName)
      set type2 [array get section {Type}]
        if { ($type2 != "Type CCU2") } then {
          set sn1 $section(Serial Number)
          if { $sn1 == $gwoben } then {
            if { $connection == 1 } then {
              set con "Online"
            } else {
              set con "Offline"
            }
            puts "--------------------"
            puts "$con / $dutycycle %"
            puts "$gwoben / $fw"

            set gwname $section(Name)
            set gwname1 "DutyCycle-$gwname"
            set gwnoname "DutyCycle-$sn1"
            # Wenn kein Gateway Name eingetragen wurde, wird als Variablenname "DutyCycle-Seriennummer" gesetzt
            if { $gwname == "" } then {
              puts $gwnoname
              # Wenn HM-CFG-LAN disconnected dann DC -1 setzen
              if {($type == "LanInterface") && ($connection == "0" )} then {
                set dutycycle -1
                puts "Set DC to $dutycycle"
              }
              # Prüfen ob DC Systemvariable für Gateways existieren und ggf. anlegen
              append rega_cmd_create_sv "string svName = '$gwnoname';object svObj = dom.GetObject(ID_SYSTEM_VARIABLES).Get(svName);if (!svObj){object svObjects = dom.GetObject(ID_SYSTEM_VARIABLES);svObj = dom.CreateObject(OT_VARDP);svObjects.Add(svObj.ID());svObj.Name(svName);svObj.ValueType(ivtFloat);svObj.ValueSubType(istGeneric);svObj.DPInfo('DutyCycle Gateway');svObj.ValueUnit('%');svObj.ValueMin(-100);svObj.ValueMax(100);svObj.State(0);svObj.Internal(false);svObj.Visible(true);dom.RTUpdate(true);}"
              rega_script $rega_cmd_create_sv
              # DutyCycle Variable aktualisieren
              append rega_cmd "dom.GetObject(ID_SYSTEM_VARIABLES).Get('$gwnoname').State('$dutycycle');"
              rega_script $rega_cmd
              # DutyCycle System-Log Meldung erzeugen sofern DC größer 80%
              if {$dutycycle >= "80"} {
                exec logger -t dutycycle -p info "$gwnoname / FW: $fw / DC: $dutycycle %"
              }
              } else {
                puts $gwname1
                if {($type == "LanInterface") && ($connection == "0" )} then {
                  set dutycycle -1
                  puts "Set DC to $dutycycle"
                }
                # Wird der Gateway Name nachträglich gesetzt, Systemvariable mit Seriennummer umbenennen
                append rega_cmd_rename_sv "string svName = '$gwnoname';string svNewName = '$gwname1';object svObj = dom.GetObject(ID_SYSTEM_VARIABLES).Get(svName);if (svObj){dom.GetObject(ID_SYSTEM_VARIABLES).Get(svName).Name(svNewName);dom.RTUpdate(true)};"
                rega_script $rega_cmd_rename_sv
                # Wenn ein Gateway Name eingetragen wurde, wird dieser angehangen z.B. "DutyCycle-OG1"
                append rega_cmd_create_sv "string svName = '$gwname1';object svObj  = dom.GetObject(ID_SYSTEM_VARIABLES).Get(svName);if (!svObj){object svObjects = dom.GetObject(ID_SYSTEM_VARIABLES);svObj = dom.CreateObject(OT_VARDP);svObjects.Add(svObj.ID());svObj.Name(svName);svObj.ValueType(ivtFloat);svObj.ValueSubType(istGeneric);svObj.DPInfo('DutyCycle Gateway');svObj.ValueUnit('%');svObj.ValueMin(-100);svObj.ValueMax(100);svObj.State(0);svObj.Internal(false);svObj.Visible(true);dom.RTUpdate(true);}"
                rega_script $rega_cmd_create_sv
                # DutyCycle Variable aktualisieren
                append rega_cmd "dom.GetObject(ID_SYSTEM_VARIABLES).Get('$gwname1').State('$dutycycle');"
                rega_script $rega_cmd
                # DutyCycle System-Log Meldung erzeugen sofern DC größer 80%
                if {$dutycycle >= "80"} {
                  exec logger -t dutycycle -p info "$gwname1 / FW: $fw / DC: $dutycycle %"
                }
              }
            }
          }
        }
      }
    }

# Section Wired-Gateway
puts "--------------------"
set fp [open "/usr/local/etc/config/hs485d.conf" r]
set filecontent [read $fp]
set input_list [split $filecontent "\n"]
set wiredList [lsearch -exact $input_list "\[Interface 0\]"]
close $fp
set wiredgateway ""
set wiredvarName "Wired-Status"

# Sofern kein Wired-Gateway eingebunden, wird nichts gemacht
if { $wiredList == -1 } then {
  puts "Wired: no"
  }

if { $wiredList > -1 } then {
    puts "Wired: yes"
    # Prüfen ob Wired Gateway verbunden ist und ggf. Connection Status auf 0 setzen
    if { [catch {set wiredgateway [xmlrpc http://127.0.0.1:2000/ getLGWStatus]} fid] } {
      set connection "diconnected"
      puts "Gateway $connection"
      #puts "Fehlermeldung: $fid"
      # Prüfen ob Wired-Status Systemvariable existiert und ggf. anlegen
      append rega_cmd_create_sv "string svName='Wired-Status';object svObj=dom.GetObject(ID_SYSTEM_VARIABLES).Get(svName);if (!svObj){object svObjects=dom.GetObject(ID_SYSTEM_VARIABLES);svObj=dom.CreateObject(OT_VARDP);svObjects.Add(svObj.ID());svObj.Name(svName);svObj.ValueType(ivtBinary);svObj.ValueSubType(istBool);svObj.ValueName0('offline');svObj.ValueName1('online');svObj.State(true);svObj.DPInfo('Wired-Status');svObj.ValueUnit('');dom.RTUpdate(true);}"
      rega_script $rega_cmd_create_sv
      # Wired-Status Variable aktualisieren
      append rega_cmd "dom.GetObject(ID_SYSTEM_VARIABLES).Get('$wiredvarName').State(false);"
      rega_script $rega_cmd
      } else {
        set connection "1"
        set wiredgateway [xmlrpc http://127.0.0.1:2000/ getLGWStatus]
      }
    }

# Sofern getLGWStatus verfügbar, Connetion Status direkt über getLGWStatus abfragen
set lines [split [string map [list "{CO" "\x00"] $wiredgateway] "\x00"]
if { $connection == "1" } {
  foreach line $lines {
    regexp "CONNECTED (.?) " $line dummy connection1
    # Prüfen ob Wired-Status Systemvariable existiert und ggf. anlegen
    append rega_cmd_create_sv "string svName='Wired-Status';object svObj=dom.GetObject(ID_SYSTEM_VARIABLES).Get(svName);if (!svObj){object svObjects=dom.GetObject(ID_SYSTEM_VARIABLES);svObj=dom.CreateObject(OT_VARDP);svObjects.Add(svObj.ID());svObj.Name(svName);svObj.ValueType(ivtBinary);svObj.ValueSubType(istBool);svObj.ValueName0('offline');svObj.ValueName1('online');svObj.State(true);svObj.DPInfo('Wired-Status');svObj.ValueUnit('');dom.RTUpdate(true);}"
    rega_script $rega_cmd_create_sv
    # Wired-Status Variable aktualisieren
    append rega_cmd "dom.GetObject(ID_SYSTEM_VARIABLES).Get('$wiredvarName').State(true);"
    rega_script $rega_cmd
    puts "Gateway connected"
  }
}
