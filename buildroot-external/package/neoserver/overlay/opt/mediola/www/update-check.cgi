#!/bin/tclsh

set checkURL    "https://s3-eu-west-1.amazonaws.com/mediola-download/ccu3/VERSION"
set downloadURL "https://s3-eu-west-1.amazonaws.com/mediola-download/ccu3/neo_server.tar.gz"

catch {
  set input $env(QUERY_STRING)
  set pairs [split $input &]
  foreach pair $pairs {
    if {0 != [regexp "^(\[^=]*)=(.*)$" $pair dummy varname val]} {
      set $varname $val
    }
  }
}

if { [info exists cmd ] && $cmd == "download"} {
  puts "<html><meta http-equiv='refresh' content='0; url=$downloadURL' /><body></body></html>"
} else {
  catch {
    set newversion [ exec /usr/bin/wget -qO- --no-check-certificate $checkURL ]
  }
  if { [info exists newversion] } {
    puts $newversion
  } else {
    puts "n/a"
  }
}
