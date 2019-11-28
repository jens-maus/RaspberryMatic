#!/bin/tclsh
##
# Tcl 'library' implementing functions to read/write/apply security level setting.
# Copyright (C) 2018 eQ-3 Entwicklung GmbH
# Author: Niclaus
##

source "/lib/libfirewall.tcl"

##
# @fn SEC_setsecuritylevel
# Sets security level persistent)
##
proc SEC_setsecuritylevel { lvl } {
	global Firewall_MODE_MOST_OPEN Firewall_MODE_RESTRICTIVE

	if { [string compare $lvl "LOW"] == 0 } {

		Firewall_loadConfiguration	
		Firewall_setMode $Firewall_MODE_MOST_OPEN
		Firewall_set_service_access "XMLRPC" "full"
		Firewall_set_service_access "REGA" "restricted"
		Firewall_set_service_access "NEOSERVER" "full"
		# SNMP shall not be controlled by security wizard / mode
		Firewall_saveConfiguration
		Firewall_configureFirewall
		SEC_setAuthEnabled false
		
	} elseif { [string compare $lvl "MEDIUM"] == 0 } {

		Firewall_loadConfiguration
		Firewall_setMode $Firewall_MODE_RESTRICTIVE
		Firewall_set_service_access "XMLRPC" "restricted"
		Firewall_set_service_access "REGA" "restricted"
		Firewall_set_service_access "NEOSERVER" "restricted"
		Firewall_saveConfiguration
		Firewall_configureFirewall
		SEC_setAuthEnabled true
	
	} elseif { [string compare $lvl "HIGH"] == 0} {

		Firewall_loadConfiguration
		Firewall_setMode $Firewall_MODE_RESTRICTIVE
		Firewall_set_service_access "XMLRPC" "none"
		Firewall_set_service_access "REGA" "none"
		Firewall_set_service_access "NEOSERVER" "none"
		Firewall_saveConfiguration
		Firewall_configureFirewall
		SEC_setAuthEnabled true

	} else {
		return 0;
	}
	
	return 1;
} 



##
# @fn SEC_getsecuritylevel
# Gets security level
# Returns security level as string (LOW/MEDIUM/HIGH/CUSTOM).
##
proc SEC_getsecuritylevel { } {
	global Firewall_MODE Firewall_MODE_MOST_OPEN Firewall_MODE_RESTRICTIVE

	#security level is defined by firewall mode and auth enabled state
	Firewall_loadConfiguration	

	set lvlServiceXMLRPC [Firewall_get_service_access "XMLRPC"]
	set lvlServiceREGA [Firewall_get_service_access "REGA"]
	set lvlServiceNEO [Firewall_get_service_access "NEOSERVER"]
	
	# SNMP shall not be controlled by security wizard / mode
	#set lvlServiceSNMP [Firewall_get_service_access "SNMP"]

	set authEnabled [ file exist "/etc/config/authEnabled" ]
	set initialSetupDone [ file exist "/etc/config/userAckInstallWizard" ]
	if { ($authEnabled || (!$initialSetupDone)) && [string compare $Firewall_MODE $Firewall_MODE_RESTRICTIVE] == 0} {
		#level can be MEDIUM, HIGH or CUSTOM
		if {	[ string compare $lvlServiceXMLRPC "none" ] == 0 && 
				[ string compare $lvlServiceREGA "none" ] == 0 &&
				[ string compare $lvlServiceNEO "none" ] == 0 } {
		return "HIGH"
		} elseif {	[ string compare $lvlServiceXMLRPC "restricted" ] == 0 &&
					[ string compare $lvlServiceREGA "restricted" ] == 0 &&
					[ string compare $lvlServiceNEO "restricted" ] == 0 } {
		return "MEDIUM"
		} else {
			return "CUSTOM"
		}
	} else {
		#level is LOW or CUSTOM
		if { [string compare $Firewall_MODE $Firewall_MODE_MOST_OPEN] == 0 } {
			if {	[ string compare $lvlServiceXMLRPC "full" ] == 0 &&
					[ string compare $lvlServiceREGA "restricted" ] == 0 &&
					[ string compare $lvlServiceNEO "full" ] == 0 } {
				return "LOW"
			} else {
				return "CUSTOM"
			}
		} else {
			return "CUSTOM"
		}
	}
	return ""
}


##
# @fn SEC_setAuthEnabled
# Sets authentication enabled/disabled
# Params: boolean enabled (true/false)
##
proc SEC_setAuthEnabled {enabled} {
	if { $enabled } {
		return [exec_cmd "touch /etc/config/authEnabled"]
	} else {
		return [exec_cmd "rm -f /etc/config/authEnabled"]
	}
}

##
# @fn SEC_getAuthEnabled
# Sets authentication enabled/disabled
# Return: boolean (true/false)
##
proc SEC_getAuthEnabled { } {
	return [file exist "/etc/config/authEnabled"]
}

##
# @fn exec_cmd
# Führt eine Kommandozeile aus
##
proc exec_cmd { theCmd } {
	set fd [open "| $theCmd"]
	set data [read $fd]
	if {[catch {close $fd} err]} {
	    SEC_log $err
		return false
	} else {
		return true
	}
}

##
# @fn SEC_log
# Logs to syslog
##
proc SEC_log { msg } {
	catch { [exec logger -t libsecuritylevel -p user.info $msg] }
}
