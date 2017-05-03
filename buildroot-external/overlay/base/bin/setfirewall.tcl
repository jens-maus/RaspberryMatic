#!/bin/tclsh

if { [catch {
  source /lib/libfirewall.tcl

  Firewall_loadConfiguration
  Firewall_configureFirewall

  exec -- logger -t firewall -p user.info configuration set

} errMsg] } then {
	
  exec -- logger -t firewall -p user.info '$errMsg'
}