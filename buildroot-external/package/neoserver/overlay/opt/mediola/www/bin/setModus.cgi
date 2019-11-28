#!/bin/sh
package require HomeMatic
cd /www
source session.tcl

if {[session_requestisvalid 0] < 0 } {
 exit
}
