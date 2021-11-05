#!/bin/tclsh

#Kanal-EasyMode!

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]

# Anzeigemodus
set PROFILE_PNAME(DISPLAY_TEMPERATUR_HUMIDITY_CHANGE) "\${lblModeDisplay}"
# Anzeige im Display
set PROFILE_PNAME(DISPLAY_TEMPERATUR_INFORMATION) "\${lblTempMode}"
# Temperatureinheit
set PROFILE_PNAME(DISPLAY_TEMPERATUR_UNIT) "\${lblTemperatureUnit}"
# Temperaturreglermodus
set PROFILE_PNAME(MODE_TEMPERATUR_REGULATOR) "\${lblModeTemperatureRegulator}"
# Komforttemperatur
set PROFILE_PNAME(TEMPERATUR_COMFORT_VALUE) "\${lblComfortTemp}"
# Absenktemperatur
set PROFILE_PNAME(TEMPERATUR_LOWERING_VALUE) "\${lblLowerTemp}"
# Party-/Urlaub-Endzeit
set PROFILE_PNAME(PARTY_END_TIME) "\${lblPartyEndTime}"
# Party-/Urlaubtemperatur
set PROFILE_PNAME(TEMPERATUR_PARTY_VALUE) "\${lblPartyTemp}"
# Entkalkungszeitpunkt
set PROFILE_PNAME(DECALCIFICATION) "\${lblDateOfDecalcification}"

#Namen der EasyModes tauchen nicht mehr auf. Der Durchgängkeit werden sie hier noch definiert.
set PROFILES_MAP(0)	"Experte"
set PROFILES_MAP(1)	"TheOneAndOnlyEasyMode"

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
	
	global env
	
	puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/CC.js');load_JSFunc('/config/easymodes/MASTER_LANG/HM_CC_TC.js');</script>"
	# puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_CC_TC.js');</script>"

	upvar PROFILES_MAP  PROFILES_MAP
	upvar HTML_PARAMS   HTML_PARAMS
	upvar PROFILE_PNAME PROFILE_PNAME
	upvar $pps          ps
	#upvar $pps_descr    ps_descr
	#upvar PROFILE_0     PROFILE_0
	upvar PROFILE_1     PROFILE_1

	# Zeittabelle sichtbar / unsichtbar schalten.
	append HTML_PARAMS(separate_1) "<script text=\"javascript\">"
	append HTML_PARAMS(separate_1) "CC_TimeTable_on_off();"
	append HTML_PARAMS(separate_1) "</script>"

	

	#append HTML_PARAMS(separate_0) [cmd_link_paramset $iface $address MASTER MASTER DEVICE]

	#linke Zelle
	append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\"><tr><td>"

	append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
#	Anzeige im Display
	append HTML_PARAMS(separate_1) "<tr><td>$PROFILE_PNAME(DISPLAY_TEMPERATUR_INFORMATION)</td><td>"
	array_clear options
	# Aktuelle Temperatur
	set options(0) "\${optionCurrentTemp}"
	# Solltemperatur
	set options(1) "\${optionSetPointTemp}"
	append HTML_PARAMS(separate_1) [get_ComboBox options DISPLAY_TEMPERATUR_INFORMATION separate_${special_input_id}_1 ps DISPLAY_TEMPERATUR_INFORMATION]
	append HTML_PARAMS(separate_1) "</td></tr>"

#	Temperatureinheit
	append HTML_PARAMS(separate_1) "<tr><td>$PROFILE_PNAME(DISPLAY_TEMPERATUR_UNIT)</td><td>"
	array_clear options
	# Grad Celsius
	set options(0) "\${optionDegree}"
	# Grad Fahrenheit
	set options(1) "\${optionFahrenheit}"
	append HTML_PARAMS(separate_1) [get_ComboBox options DISPLAY_TEMPERATUR_UNIT separate_${special_input_id}_2 ps DISPLAY_TEMPERATUR_UNIT "onchange=\"CC_setUnit()\""]
	append HTML_PARAMS(separate_1) "</td></tr>"
#	Temperaturregelmodus
	append HTML_PARAMS(separate_1) "<tr><td>$PROFILE_PNAME(MODE_TEMPERATUR_REGULATOR)</td><td>"
	array_clear options
	# Temperatur am Regler einstellen
	set options(0) "\${optionModeTemperatureRegulator0}"
	# Zeit u. Temperatur vorgeben
	set options(1) "\${optionModeTemperatureRegulator1}"
	# per Zentralenprogramm
	set options(2) "\${optionModeTemperatureRegulator2}"
	# Party-/Urlaubsmodus
	set options(3) "\${optionModeTemperatureRegulator3}"
	append HTML_PARAMS(separate_1) [get_ComboBox options MODE_TEMPERATUR_REGULATOR separate_${special_input_id}_3 ps MODE_TEMPERATUR_REGULATOR "onchange=\"CC_TimeTable_on_off()\""]
	append HTML_PARAMS(separate_1) "</td></tr>"
#	Anzeigemodus
	append HTML_PARAMS(separate_1) "<tr><td>$PROFILE_PNAME(DISPLAY_TEMPERATUR_HUMIDITY_CHANGE)</td><td>"
	array_clear options
	# Temperatur
	set options(0) "\${optionModeDisplay0}"
	# Temperatur und Feuchtigkeit
	set options(1) "\${optionModeDisplay1}"
	append HTML_PARAMS(separate_1) [get_ComboBox options DISPLAY_TEMPERATUR_HUMIDITY_CHANGE separate_${special_input_id}_4 ps DISPLAY_TEMPERATUR_HUMIDITY_CHANGE]
	append HTML_PARAMS(separate_1) "</td></tr>"
	
#	Entkalkungszeitpunkt
	append HTML_PARAMS(separate_1) "<tr><td>$PROFILE_PNAME(DECALCIFICATION)</td><td>"
	array_clear options
	set i 0
	foreach day {\${optionSat} \${optionSun} \${optionMon} \${optionTue} \${optionWed} \${optionThu} \${optionFri}} {
		set options($i) $day
		incr i
	}
	append HTML_PARAMS(separate_1) [get_ComboBox options DECALCIFICATION_DAY separate_${special_input_id}_9 ps DECALCIFICATION_DAY]
	append HTML_PARAMS(separate_1) "&nbsp;-&nbsp;"

	array_clear options
	for {set i 0} {$i < 24} {incr i} {
		if {$i < 10} then {
			set options($i) 0$i
		} else {
			set options($i) $i
		}
	}
	append HTML_PARAMS(separate_1) [get_ComboBox options DECALCIFICATION_HOUR separate_${special_input_id}_10 ps DECALCIFICATION_HOUR]
	append HTML_PARAMS(separate_1) "&nbsp;:&nbsp;"

	array_clear options
	set options(0) 00
	for {set i 10} {$i < 60} {set i [expr $i + 10]} {
		set options($i) $i
	}
	append HTML_PARAMS(separate_1) [get_ComboBox options DECALCIFICATION_MINUTE separate_${special_input_id}_11 ps DECALCIFICATION_MINUTE]
##	append HTML_PARAMS(separate_1) "Uhr</table></td> <td><hr style=\"height:12.5em; width:1px\"></td>  <td>"
	append HTML_PARAMS(separate_1) "</table></td> <td style=\"border-left-width:1px; border-style:solid \">&nbsp</td>  <td>"
#	linke Zelle zuende, rechte startet
	append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
#	Absenktemperatur	
	append HTML_PARAMS(separate_1) "<tr><td>$PROFILE_PNAME(TEMPERATUR_LOWERING_VALUE)&nbsp;&nbsp;&nbsp;<img src=\"/ise/img/cc_moon.png\"></td><td>"
	append HTML_PARAMS(separate_1) [get_InputElem TEMPERATUR_LOWERING_VALUE separate_${special_input_id}_6_temp ps tmp_TEMPERATUR_LOWERING_VALUE "onchange =\"CC_check_Value('separate_${special_input_id}_6');\""]
	# unsichtbares Eingabefeld, welches die Temperaturen in Celsius aufnimmt, auch wenn Fahrenheit eingestellt ist. Das ist ntig, da der
	# Heizungsregler die gesendeten Werte in Grad Celsius erwartet. Die Werte werden durch CC_conv_CF errechnet
	append HTML_PARAMS(separate_1) "<input type=\"hidden\" id=\"separate_${special_input_id}_6\" name=\"TEMPERATUR_LOWERING_VALUE\">"
	#Das C in <span>C</span> der naechsten Zeile wird in der Funktion /js/ic_setprofiles/CC_setUnit() evtl. in F(ahrenheit) gewandelt
	append HTML_PARAMS(separate_1) "&deg;<span class=\"CF\">C</span></td></tr>"

#	Komforttemperatur
	append HTML_PARAMS(separate_1) "<tr><td>$PROFILE_PNAME(TEMPERATUR_COMFORT_VALUE)&nbsp;&nbsp;<img src=\"/ise/img/cc_sun.png\"></td><td>"
	append HTML_PARAMS(separate_1) [get_InputElem TEMPERATUR_COMFORT_VALUE separate_${special_input_id}_5_temp ps tmp_TEMPERATUR_COMFORT_VALUE "onchange=\"CC_check_Value('separate_${special_input_id}_5');\""]
	# unsichtbares Eingabefeld, welches die Temperaturen in Celsius aufnimmt, auch wenn Fahrenheit eingestellt ist. Das ist nötig, da der
	# Heizungsregler die gesendeten Werte in Grad Celsius erwartet. Die Werte werden durch CC_conv_CF errechnet
	append HTML_PARAMS(separate_1) "<input type=\"hidden\" id=\"separate_${special_input_id}_5\" name=\"TEMPERATUR_COMFORT_VALUE\">"
	#Das C in <span>C</span> der naechsten Zeile wird in der Funktion /js/ic_setprofiles/CC_setUnit() evtl. in F(ahrenheit) gewandelt
	append HTML_PARAMS(separate_1) "&deg;<span class=\"CF\">C</span></td></tr>"
	
#	append HTML_PARAMS(separate_1) "<td colspan=\"2\"><hr class=\"CLASS20600\"/>"
	append HTML_PARAMS(separate_1) "<td colspan=\"2\"><hr>"

#	Party-/Urlaubs-Endzeit	
	append HTML_PARAMS(separate_1) "<tr><td>$PROFILE_PNAME(PARTY_END_TIME)</td><td id=\"party_end_time_cell\"></td></tr>"

#	Party-/Urlaubstemperatur
	append HTML_PARAMS(separate_1) "<tr><td>$PROFILE_PNAME(TEMPERATUR_PARTY_VALUE)</td><td>"
	append HTML_PARAMS(separate_1) [get_InputElem TEMPERATUR_PARTY_VALUE separate_${special_input_id}_8_temp ps tmp_TEMPERATUR_PARTY_VALUE "onchange =\"CC_check_Value('separate_${special_input_id}_8');\""]
	# unsichtbares Eingabefeld, welches die Temperaturen in Celsius aufnimmt, auch wenn Fahrenheit eingestellt ist. Das ist ntig, da der
	# Heizungsregler die gesendeten Werte in Grad Celsius erwartet. Die Werte werden durch CC_conv_CF errechnet
	append HTML_PARAMS(separate_1) "<input type=\"hidden\" id=\"separate_${special_input_id}_8\" name=\"TEMPERATUR_PARTY_VALUE\">"
	#Das C in <span>C</span> der naechsten Zeile wird in der Funktion /js/ic_setprofiles/CC_setUnit() evtl. in F(ahrenheit) gewandelt
	append HTML_PARAMS(separate_1) "&deg;<span class=\"CF\">C</span></td></tr></table>"

#	rechte Zelle endet
	append HTML_PARAMS(separate_1) "</td></tr></table>"

	append HTML_PARAMS(separate_1) "<div id=\"Timeouts_Area\" style=\"display:none\">"
	#Die DIV - Tags müssen schon existieren, wenn man in die Funktion tom.setTemp geht
	foreach day {SATURDAY SUNDAY MONDAY TUESDAY WEDNESDAY THURSDAY FRIDAY} {
		append HTML_PARAMS(separate_1) "<div id=\"temp_prof_$day\"></div>"
	}
	append HTML_PARAMS(separate_1) "</div>"

	append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
	append HTML_PARAMS(separate_1) "tom = new TimeoutManager('$iface', '$address', true);"

	foreach day {SATURDAY SUNDAY MONDAY TUESDAY WEDNESDAY THURSDAY FRIDAY} {

		for {set i 1} {$i <= 24} {incr i} {

			set timeout     $ps(TIMEOUT_${day}_$i)
			set temperature $ps(TEMPERATUR_${day}_$i)
			append HTML_PARAMS(separate_1) "tom.setTemp('$day', $timeout, $temperature);"

			if {$timeout == 1440} then {
				break;
			}
		}

		append HTML_PARAMS(separate_1) "tom.setDivname('$day', 'temp_prof_$day');"
		append HTML_PARAMS(separate_1) "tom.writeDay('$day');"
	}

	append HTML_PARAMS(separate_1) "pet = new PartyEndTimeManager ('$iface', '$address', 'party_end_time_cell', 'PARTY_END_TIME', 'separate_${special_input_id}_7');"
	append HTML_PARAMS(separate_1) "pet.writeControl($ps(PARTY_END_TIME));"
	# Temperatureinheiten C oder F
	append HTML_PARAMS(separate_1) "CC_setUnit();"
	append HTML_PARAMS(separate_1) "</script>"

  puts "<script type=\"text/javascript\">translatePage();</script>"
}
constructor
