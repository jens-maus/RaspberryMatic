##
# RecoveryMode.enter
# Startet die HomeMatic Zentrale im Recovery Modus
#
# Parameter: kein
#
# Rückgabewert: [bool]
#   true
##

set FLAG_FILE "/usr/local/.recoveryMode"

# Plattform ermitteln: oci und lxc haben kein Recovery-System
set platform ""
catch {
  set fd [open /VERSION r]
  while { [gets $fd line] >= 0 } {
    if { [regexp {^ *PLATFORM *= *(.*)$} $line dummy platform] } { break }
  }
  close $fd
}
if { $platform == "" } {
  jsonrpc_error 500 "could not determine the platform from /VERSION"
}
if { $platform == "oci" || $platform == "lxc" } {
  jsonrpc_error 501 "recovery mode is not supported on platform $platform"
}

# Einstellungen speichern, bevor die Flag-Datei erzeugt wird
if { [catch {rega system.Save()} err] } {
  jsonrpc_error 500 "could not save the settings: $err"
}

# Flag-Datei erzeugen
if { [catch {
  set fd [open $FLAG_FILE w]
  puts $fd 1
  close $fd
} err] } {
  file delete -force $FLAG_FILE
  jsonrpc_error 500 "could not create the recovery mode flag: $err"
}

# Neustart, bei einem Fehler die Flag-Datei wieder entfernen
if { [catch {exec /sbin/reboot -d 2 2>/dev/null >/dev/null &} err] } {
  file delete -force $FLAG_FILE
  jsonrpc_error 500 "could not restart: $err"
}

jsonrpc_response true
