##
# Interface.rssiInfo
# Liefert Informationen über die Empfangsfeldstärken.
#
# Parameter:
#   interface: [string] Bezeichnung der Schnittstelle
#
# Rückgabewert: [array]
#   Jedes Element istn Objekt mit den folgenden Feldern:
#     name:     [string] Bezeichnung des Geräts
#     parntner: [array] Liste der Kommunikationspartner
#               Jedes Element ist ein Objekt mit den folgenden Feldern:
#                 name    : [string] Name des Kommunikationspartners
#                 rssiData: [array]  RSSI-Daten
#                           Das Array enthält zwei Elemente. Jedes ist eine Ganzzahl und codiert die jeweilige Empfangsfeldstärke.
#                           Der Wert 65536 bedeutet, dass keine Informationen vorliegen.
##

checkXmlRpcStatus [catch { array set rssiInfo [xmlrpc $interface(URL) rssiInfo] }]

set result "\["
set first 1

foreach deviceName [array names rssiInfo] {
	array set partnerList $rssiInfo($deviceName)
	if {1 != $first} then { append result "," } else { set first 0 }
	
	append result "\{"
	append result "\"name\":[json_toString $deviceName]"
	append result ",\"partner\": \["
	
	set _first 1
	foreach partnerName [array names partnerList] {
		set rssiData $partnerList($partnerName)
		if {1 != $_first} then {append result ","} else { set _first 0 }
		
		append result "\{"
		append result "\"name\":[json_toString $partnerName]"
		append result ",\"rssiData\":\[[lindex $rssiData 0],[lindex $rssiData 1]\]"
		append result "\}"
	}
	
	append result "\]"
	append result "\}"
	
	array_clear partnerList
}


append result "\]"



jsonrpc_response $result