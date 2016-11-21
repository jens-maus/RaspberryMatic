#!/bin/tclsh

load tclrega.so

  set res [rega "dom.GetObject([lindex $argv 0]).Value();"]
puts $res

