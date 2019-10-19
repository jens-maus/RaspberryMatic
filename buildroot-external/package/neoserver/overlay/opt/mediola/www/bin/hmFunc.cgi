#!/bin/tclsh
package require HomeMatic
cd /www
source session.tcl

if {[session_requestisvalid 0] < 0 } {
 exit
}

puts -nonewline "Content-Type: application/json\r\n\r\n"
puts "{\"session\":\"valid\"}"
