#!/bin/tclsh

package require HomeMatic

if {[catch {exec /bin/sh -c "/etc/init.d/S??NeoServer restart" } result]} {
	# non-zero exit status, get it:
	set status [lindex $errorCode 2]
} else {
	# exit status was 0
	# result contains the result of your command
	set status 0
}
