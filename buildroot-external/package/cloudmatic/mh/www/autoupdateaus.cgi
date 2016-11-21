#!/bin/tclsh

package require HomeMatic


set autoupdate unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/autoupdate"]
catch { [regexp -line {(.*)} $content dummy autoupdate] }

if {$autoupdate == 1} {
	if {[catch {exec /bin/sh /etc/config/addons/mh/autoupdateaus.sh } result]} {
		# non-zero exit status, get it:
		set status [lindex $errorCode 2]
	} else {
		# exit status was 0
		# result contains the result of your command
		set status 0
	}
  puts "Die automatischen Updates wurden deaktiviert."
} else {
  puts "Die automatischen Updates wurden bereits deaktiviert."
}