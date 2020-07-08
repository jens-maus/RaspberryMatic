#!/bin/tclsh

set status [catch {exec /usr/local/etc/config/rc.d/97NeoServer status} output]
puts -nonewline "Content-Type: application/json; charset=utf-8\r\n\r\n"
if {$status == 0} {
  puts "{\"running\":true}"
} else {
  puts "{\"running\":false}"
}

