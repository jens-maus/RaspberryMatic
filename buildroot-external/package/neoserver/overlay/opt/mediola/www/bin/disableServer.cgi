#!/bin/tclsh

package require HomeMatic

if {[catch {exec touch /usr/local/addons/mediola/Disabled } result]} {
	# non-zero exit status, get it:
	set status [lindex $errorCode 2]
}   

if {[catch {exec /bin/sh -c "/etc/init.d/S??NeoServer stop" } result]} {
	# non-zero exit status, get it:
	set status [lindex $errorCode 2]
}

if {[catch {exec /bin/sh -c "/etc/init.d/S??crond restart" } result]} {
	# non-zero exit status, get it:
	set status [lindex $errorCode 2]
} else {
	# exit status was 0
	# result contains the result of your command
	set status 0
}
