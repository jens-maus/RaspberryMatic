#!/bin/tclsh

catch {
  set input $env(QUERY_STRING)
  set pairs [split $input &]

  foreach pair $pairs {
    if {$pair == "cmd=download"} {
      set cmd "download"
      break
    }
  }
}

set checkURL    "https://s3-eu-west-1.amazonaws.com/mediola-download/ccu3/VERSION"
set downloadURL "https://s3-eu-west-1.amazonaws.com/mediola-download/ccu3/neo_server.tar.gz"

if { [info exists cmd ] && $cmd == "download"} {
  puts -nonewline "Content-Type: text/html; charset=utf-8\r\n\r\n"
  puts -nonewline "<html><head><meta http-equiv='refresh' content='0; url=$downloadURL' /></head><body></body></html>"
} else {
  puts -nonewline "Content-Type: text/plain; charset=utf-8\r\n\r\n"
  catch {
    set newversion [ exec /usr/bin/wget -qO- --no-check-certificate $checkURL ]
  }
  if { [info exists newversion] } {
    puts $newversion
  } else {
    puts "n/a"
  }
}
