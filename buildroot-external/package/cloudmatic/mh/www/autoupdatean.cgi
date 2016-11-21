#!/bin/tclsh

package require HomeMatic


set autoupdate unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/autoupdate"]
catch { [regexp -line {(.*)} $content dummy autoupdate] }

if {$autoupdate == 0} {
	if {[catch {exec /bin/sh /etc/config/addons/mh/autoupdatean.sh & } result]} {
		# non-zero exit status, get it:
		set status [lindex $errorCode 2]
	} else {
		# exit status was 0
		# result contains the result of your command
		set status 0
	}
	if {[catch {exec /bin/sh /etc/config/addons/mh/loopupd.sh } result]} {
		# non-zero exit status, get it:
		set status [lindex $errorCode 2]
	} else {
		# exit status was 0
		# result contains the result of your command
		set status 0
	}
  puts "Die automatischen Updates wurden aktiviert und eine Updatepr&uuml;fung durchgef&uuml;hrt."
} else {
  puts "Die automatischen Updates wurden bereits aktiviert."
}