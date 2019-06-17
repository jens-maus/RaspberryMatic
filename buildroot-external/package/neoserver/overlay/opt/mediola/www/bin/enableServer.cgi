#!/bin/tclsh

package require HomeMatic
cd /www
source session.tcl

if {[session_requestisvalid 0] < 0 } {
 exit
}

if {[catch {exec rm /etc/config/neoDisabled } result]} {
	# non-zero exit status, get it:
	set status [lindex $errorCode 2]
}

if {[catch {exec rm /usr/local/addons/mediola/Disabled } result]} {
	# non-zero exit status, get it:
	set status [lindex $errorCode 2]
}   

	if {[catch {exec /usr/local/etc/config/rc.d/97NeoServer restart } result]} {
		# non-zero exit status, get it:
		set status [lindex $errorCode 2]
	} else {
		# exit status was 0
		# result contains the result of your command
		set status 0
	}

