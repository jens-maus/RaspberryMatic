#!/bin/tclsh

package require HomeMatic


set dienstzbx unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/dienstzbx"]
catch { [regexp -line {(.*)} $content dummy dienstzbx] }

if {$dienstzbx == 0} {
	if {[catch {exec /bin/sh /etc/config/addons/mh/dienstanzbx.sh & } result]} {
		# non-zero exit status, get it:
		set status [lindex $errorCode 2]
	} else {
		# exit status was 0
		# result contains the result of your command
		set status 0
	}
	if {[catch {exec /bin/sh /etc/config/addons/mh/loophammer.sh } result]} {
		# non-zero exit status, get it:
		set status [lindex $errorCode 2]
	} else {
		# exit status was 0
		# result contains the result of your command
		set status 0
	}
	puts "Der CloudMatic monitoring Dienst wurde aktiviert und das Monitoring initialisiert."
} else {
	puts "Der CloudMatic monitoring Dienst ist bereits aktiviert."
	}		
}
