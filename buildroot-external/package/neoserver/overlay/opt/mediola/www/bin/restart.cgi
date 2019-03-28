#!/bin/tclsh

package require HomeMatic

	if {[catch {exec /usr/local/etc/config/rc.d/97NeoServer restart } result]} {
		# non-zero exit status, get it:
		set status [lindex $errorCode 2]
	} else {
		# exit status was 0
		# result contains the result of your command
		set status 0
	}
	
