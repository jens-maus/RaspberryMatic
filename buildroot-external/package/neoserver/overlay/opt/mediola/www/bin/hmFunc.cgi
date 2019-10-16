#!/bin/tclsh
package require HomeMatic
cd /www
source session.tcl

if {[session_requestisvalid 0] < 0 } {
 exit
}
puts "Content-Type: application/json\r"
puts "\r"
puts "{\"session\":\"valid\"}"
