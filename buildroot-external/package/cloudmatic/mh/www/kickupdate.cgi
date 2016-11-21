#!/bin/tclsh

package require HomeMatic

puts "Update "

set dienst unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/dienst"]
catch { [regexp -line {(.*)} $content dummy dienst] }

	if {[catch {exec /bin/sh /etc/config/addons/mh/kickupd.sh } result]} {
		# non-zero exit status, get it:
		set status [lindex $errorCode 2]
	} else {
		# exit status was 0
		# result contains the result of your command
		set status 0
	}

	puts "Status "
	puts $status		
