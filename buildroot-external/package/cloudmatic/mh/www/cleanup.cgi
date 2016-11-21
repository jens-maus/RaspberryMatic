#!/bin/tclsh

package require HomeMatic


set dienst unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/dienst"]
catch { [regexp -line {(.*)} $content dummy dienst] }

puts {
  <p>Der VPN Dienst wird beendet</p>
}		

if {[catch {exec /bin/sh /opt/mh/user/cleanup.sh } result]} {
		# non-zero exit status, get it:
		set status [lindex $errorCode 2]
} else {
		# exit status was 0
		# result contains the result of your command
		set status 0
}
puts {
  <p>Dienst wurde beendet, personifizierte Daten entfernt</p>
}		