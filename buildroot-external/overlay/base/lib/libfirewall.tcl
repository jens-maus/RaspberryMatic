#!/bin/tclsh

##
# @file  setfirewall.tcl
# @brief Firewall-Konfiguration
##

##
# @const Firewall_CONFIG_FILE
# Konfigurationsdatei für die Firewall
##
set Firewall_CONFIG_FILE /etc/config/firewall.conf

##
# @const Firewall_SERVICES
# Enthält die verfügbaren Services und deren TCP-Ports
#
# Jeder Service kann als assoziatives Array mit den folgenden
# Elementen aufgefasst werden:
#   PORTS : Liste der TCP-Portnummern des Services
#   ACCESS: Zugriffsrechte für den Service:
#           full      : Vollzugriff; keine Einschränkungen
#           restricted: Eingeschränkter Zugriff
#           none      : Kein Zugriff möglich
##
array set Firewall_SERVICES {}
set Firewall_SERVICES(XMLRPC) [list PORTS [list 2000 2001 2002] ACCESS full]
set Firewall_SERVICES(REGA)   [list PORTS [list 8181] ACCESS restricted]

##
# @var Firewall_IPS
# IP-Adressen für den eingeschränkten Zugriff
#
# Beinhaltet eine Liste der IP-Adressen oder Addressgruppen, denen bei
# eingeschränktem Zugriff eine Verwendung des jeweiligen Serices noch erlaubt
# ist.
##
set Firewall_IPS [list 192.168.0.1 192.168.0.0/16]

##
# @fn loadConfiguration
# Lädt die Firwall-Einstellunfen aus der Konfigurationsdatei
##
proc Firewall_loadConfiguration { } {
	global Firewall_CONFIG_FILE Firewall_SERVICES Firewall_IPS
	
	array set config  {}
	array set section {}
	set sectionName   {}
	
	if { ![catch { set fd [open $Firewall_CONFIG_FILE r] }] } then {
		catch {
			while { ![eof $fd] } {

				set line [string trimleft [gets $fd]]

				if { "\#" != [string index $line 0] } then {

					if { [regexp {\[([^\]]+)\]} $line dummy newSectionName] } then {
					set config($sectionName) [array get section]
						array_clear section
						set sectionName $newSectionName
					}
  
					if { [regexp {([^=]+)=(.+)} $line dummy name value] } then {
						set section([string trim $name]) [string trim $value]
					}

				}      
    
			}
			set config($sectionName) [array get section]
			array_clear section
		}
	
		close $fd
	}
	
	foreach sectionName [array names config] {
		if { {} != $sectionName } then {
			array set section $config($sectionName)
			
			set id     [array_getValue section Id]
			set ports  [array_getValue section Ports]
			set access [array_getValue section Access]
			
			set Firewall_SERVICES($id) [list PORTS $ports ACCESS $access]
			
			array_clear section
		}
	}

	if { [info exists config()] } then {
		array set emptySection $config()
		set Firewall_IPS [array_getValue emptySection IPs]
	}
	
}

##
# @fn saveConfiguration
# Speichert die Firewall-Einstellungen in der Konfigurationsdatei
##
proc Firewall_saveConfiguration {} {
	global Firewall_CONFIG_FILE Firewall_SERVICES Firewall_IPS
	
	set fd [open $Firewall_CONFIG_FILE w]
	catch {
	
		puts $fd "# Firewall Configuration file"
		puts $fd "#   created [clock format [clock seconds]]"
		puts $fd "# This file was automatically gernerated"
		puts $fd "# Please do not change anything"
		puts $fd ""
		
		puts $fd "IPs = $Firewall_IPS"
		puts $fd ""
		
		foreach serviceName [array names Firewall_SERVICES] {
			array set service $Firewall_SERVICES($serviceName)
			puts $fd "\[SERVICE $serviceName\]"
			puts $fd "Id = $serviceName"
			puts $fd "Ports = $service(PORTS)"
			puts $fd "Access = $service(ACCESS)"
			puts $fd ""
		}
		
	}
		close $fd
}

##
# @fn configureFirewall
# Konfiguriert die Firewall
##
proc Firewall_configureFirewall { } {
	global Firewall_SERVICES Firewall_IPS
	
	exec_cmd "/usr/sbin/iptables -F"
	exec_cmd "/usr/sbin/iptables -P INPUT ACCEPT"
	exec_cmd "/usr/sbin/iptables -A INPUT -i lo -j ACCEPT"
	exec_cmd "/usr/sbin/iptables -A INPUT -p tcp --dport 8182 -j DROP"


	foreach serviceName [array names Firewall_SERVICES] {
		array set service $Firewall_SERVICES($serviceName)
	
		if { $service(ACCESS) == "restricted" } then {
			foreach port $service(PORTS) {
				foreach ip $Firewall_IPS {
					exec_cmd "/usr/sbin/iptables -A INPUT -p tcp --dport $port -s $ip -j ACCEPT"
				}
			}
		}
		
		if { $service(ACCESS) == "none" || $service(ACCESS) == "restricted"} then {
			foreach port $service(PORTS) {
				exec_cmd "/usr/sbin/iptables -A INPUT -p tcp --dport $port -j DROP"
			}
		}
	
	}
	
}

##
# @fn exec_cmd
# Führt eine Kommandozeile aus
##
proc exec_cmd {cmdline} {
	set fd [open "|$cmdline" r]
	close $fd
}

##
# @fn array_clear
# Löscht die Elemente in einem Array
##
proc array_clear {name} {
	upvar $name arr
	foreach key [array names arr] {
		unset arr($key)
	}
}

##
# @fn array_getValue
# Liefert einen Wert aus einem Array
# Ist der Wert nicht vorhanden, wird {} zurückgegeben
##
proc array_getValue { pArray name } {
  upvar $pArray arr

  set value {}
  catch { set value $arr($name) }

  return $value
}
