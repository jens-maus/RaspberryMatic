##
# CCU.downloadFirmware
# Laedt die neuste verfuegbare CCU Firmware herunter.
#
# Parameter:
#  
#
# Rueckgabewert: True wenn eine Firmware erfolgreich herunterladen wurde, ansonsten False.
##

set result [catch {exec curl -s https://raspberrymatic.de/LATEST-VERSION.js} verstring]
set result [regexp {homematic\.com\.setLatestVersion\('(.+)', 'HM-RASPBERRYMATIC'\);} $verstring match latest ]
set result [catch {exec grep PLATFORM /VERSION | cut -d= -f2} platform]
set url "https://github.com/jens-maus/RaspberryMatic/releases/download/$latest/RaspberryMatic-$latest-$platform.zip"

set result [catch {exec wget -q --https-only -O /usr/local/tmp/firmwareUpdateFile $url} error]
if { $result != 0 } {
  exec echo $error > /tmp/dwnld.error
}

if { $result == 0 } {
  jsonrpc_response true
} else {
  jsonrpc_response false
}
