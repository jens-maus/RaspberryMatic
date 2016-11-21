#!/bin/tclsh

package require HomeMatic

set bidcos serial
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/ids"]
catch { [regexp -line {SerialNumber=(.*)} $content dummy serial] }

puts "$serial"

set bidcos unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/ids"]
catch { [regexp -line {BidCoS-Address=(.*)} $content dummy bidcos] }

set user_has_account unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/mhcfg"]
catch { [regexp -line {user_has_account=(.*)} $content dummy user_has_account] }

if {$user_has_account == 0} {
   puts "Auf der lokalen CCU liegen noch keine Schl&uuml;sseldaten vor.<br>"
   puts "Schl&uuml;ssel f&uuml;r Ihre Zentrale wird &uuml;bertragen...<br>"

if {[catch {exec /bin/sh /etc/config/addons/mh/trans.sh $serial $bidcos } result]} {
  # non-zero exit status, get it:
  set status [lindex $errorCode 2]
} else {
  # exit status was 0
  # result contains the result of your command
  set status 0
}


set user_has_account unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/mhcfg"]
catch { [regexp -line {user_has_account=(.*)} $content dummy user_has_account] }

if {$user_has_account == 1} {
  puts "Schl&uuml;ssel wurde &uuml;betragen, wird jetzt entpackt.<br>"

	if {[catch {exec /bin/sh /etc/config/addons/mh/autoupdatean.sh & } result]} {
		# non-zero exit status, get it:
		set status [lindex $errorCode 2]
	} else {
		# exit status was 0
		# result contains the result of your command
		set status 0
	}

	puts {
		<p>Automatische Updates wurden aktiviert<br><br></p>
	}		


	if {[catch {exec /bin/cp /etc/config/addons/mh/keytransferaus /etc/config/addons/mh/keytransfer & } result]} {
		# non-zero exit status, get it:
		set status [lindex $errorCode 2]
	} else {
		# exit status was 0
		# result contains the result of your command
		set status 0
	}
	puts {
		<p>Initialer Keytransfer wurde deaktiviert<br><br></p>
	}		


  puts "Schl&uuml;ssel wurde installiert, das Browser Fenster kann nun geschlossen werden.<br>"
  set user_has_account 0
}


}

