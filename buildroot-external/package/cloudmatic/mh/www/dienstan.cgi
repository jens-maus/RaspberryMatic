#!/bin/tclsh

package require HomeMatic


set dienst unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/dienst"]
catch { [regexp -line {(.*)} $content dummy dienst] }

if {$dienst == 0} {
	if {[catch {exec /bin/sh /etc/config/addons/mh/dienstan.sh & } result]} {
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
  puts "Der CloudMatic VPN Dienst wurde aktiviert und initialisiert."
} else {
  puts "Der CloudMatic VPN Dienst ist bereits aktiviert."
}