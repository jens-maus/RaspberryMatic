#!/bin/tclsh
#Kanal-EasyMode V1.4!
source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]

set PROFILE_PNAME(A) "MOTION_DETECTOR|EVENT_FILTER_NUMBER"
set PROFILE_PNAME(B) "MOTION_DETECTOR|EVENT_FILTER_PERIOD"
set PROFILE_PNAME(C) "MOTION_DETECTOR|MIN_INTERVAL"
set PROFILE_PNAME(D) "MOTION_DETECTOR|BRIGHTNESS_FILTER"
set PROFILE_PNAME(E) "MOTION_DETECTOR|LED_ONTIME"
set PROFILE_PNAME(F) "\${motionDetectorSendMotionWithinDetectionSpan}"

set PROFILES_MAP(0)  "Experte"
set PROFILES_MAP(1)  "TheOneAndOnlyEasyMode"



proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/ic_effects.js');</script>"
  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/MOTION_DETECTOR.js');</script>"
  
  global iface_url 

  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr  ps_descr

  set chn [lindex [split $special_input_id _] 1]

  set url $iface_url($iface)
  array set dev_descr [xmlrpc $url getParamset [list string $address] MASTER]
  set capture_within_interval  $dev_descr(CAPTURE_WITHIN_INTERVAL)  

  set help_txt "\${motionDetectorHelp}"

###

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
  append HTML_PARAMS(separate_1) "<tr><td><span class=\"stringtable_value\">$PROFILE_PNAME(A)</span></td><td id=\"Hm\">\${mdTrigger}"
  array_clear options
  set options(1) "1"
  set options(2) "2"
  set options(3) "3"
  set options(4) "4"
  set options(5) "5"
  set options(6) "6"
  set options(7) "7"
  set options(8) "8"
  set options(9) "9"
  set options(10) "10"
  set options(11) "11"
  set options(12) "12"
  set options(13) "13"
  set options(14) "14"
  set options(15) "15"
  append HTML_PARAMS(separate_1) [get_ComboBox options EVENT_FILTER_NUMBER separate_${special_input_id}_1 ps EVENT_FILTER_NUMBER "onchange=\"MD_init(\'separate_${special_input_id}_1\', 1, 15)\"" ] 
  append HTML_PARAMS(separate_1) "<span class=\"event_filter_number_$chn\"> Sensor-Impulsen innerhalb <span>"
  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">MD_init(\'separate_${special_input_id}_1\', 1, 15)</script>"    

  array_clear options
  set options(0.5) "0.5"
  set options(1.0) "1.0"
  set options(1.5) "1.5"
  set options(2.0) "2.0"
  set options(2.5) "2.5"
  set options(3.0) "3.0"
  set options(3.5) "3.5"
  set options(4.0) "4.0"
  set options(4.5) "4.5"
  set options(5.0) "5.0"
  set options(5.5) "5.5"
  set options(6.0) "6.0"
  set options(6.5) "6.5"
  set options(7.0) "7.0"
  set options(7.5) "7.5"
  append HTML_PARAMS(separate_1) [get_ComboBox options EVENT_FILTER_PERIOD separate_${special_input_id}_2 ps EVENT_FILTER_PERIOD] 
  append HTML_PARAMS(separate_1) "<span class=\"event_filter_number_$chn\">&nbsp;Sekunden</span></td></tr>"
  
  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">MD_proofClassic(\'separate_${special_input_id}_3\');</script>"

  append HTML_PARAMS(separate_1) "<tr><td>\${motionDetectorOnAirIntervalMode}</td><td>"
  append HTML_PARAMS(separate_1) "<select id=\"separate_${special_input_id}_3\" name=\"MD_sendmode\"onchange=\"MD_minInterval(\'separate_${special_input_id}_3\');\"><option>\${motionDetectorOnAirIntervalModeClassic}</option><option>\${motionDetectorOnAirIntervalModeDynamic}</option></select>"
  append HTML_PARAMS(separate_1) "&nbsp<input id=\"md_help_button\" type=\"button\" value=\"Hilfe\" onclick=\"MD_channel_help();\">"
  append HTML_PARAMS(separate_1) "</td></tr>"

  append HTML_PARAMS(separate_1) "<tr><td><span id=\"min_interval\"class=\"stringtable_value\">$PROFILE_PNAME(C)</span></td><td>"
  array_clear options
  set options(0)  "15s"
  set options(1)  "30s"
  set options(2)  "60s"
  set options(3)  "120s"
  set options(4)  "240s"
  append HTML_PARAMS(separate_1) [get_ComboBox options MIN_INTERVAL separate_${special_input_id}_4 ps        MIN_INTERVAL ]
  append HTML_PARAMS(separate_1) "</td></tr>"
  
  append HTML_PARAMS(separate_1) "<tr><td colspan=\"2\"><span>$PROFILE_PNAME(F)</span>"
  if {$capture_within_interval == 1} {
    append HTML_PARAMS(separate_1) "<input type=\"checkbox\" id=\"separate\_${special_input_id}_5\" name=\"CAPTURE_WITHIN_INTERVAL\" checked=\"checked\"></td>"
  } else {
    append HTML_PARAMS(separate_1) "<input type=\"checkbox\" id=\"separate\_${special_input_id}_5\" name=\"CAPTURE_WITHIN_INTERVAL\"></td>"
  }  

  
  append HTML_PARAMS(separate_1) "<tr><td><span class=\"stringtable_value\">$PROFILE_PNAME(D)</span></td><td>"
  array_clear  options
  set options(0) "1"
  set options(1) "2"
  set options(2) "3"
  set options(3) "4"
  set options(4) "5"
  set options(5) "6"
  set options(6) "7"
  set options(7) "8"
  append HTML_PARAMS(separate_1) [get_ComboBox options BRIGHTNESS_FILTER separate_${special_input_id}_6 ps BRIGHTNESS_FILTER "onchange=\"MD_init(\'separate_${special_input_id}_6\', 0, 7)\""]
  append HTML_PARAMS(separate_1) " \${motionDetectorMinumumOfLastValuesA} <span class=\"brightness _$chn\">\${motionDetectorMinumumOfLastValuesB1} [expr $ps(BRIGHTNESS_FILTER) + 1] \${motionDetectorMinumumOfLastValuesC}</span> \${motionDetectorMinumumOfLastValuesD}</td></tr>"
  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">MD_init(\'separate_${special_input_id}_6\', 0, 7)</script>"  

#  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
  append HTML_PARAMS(separate_1) "<tr><td><span class=\"stringtable_value\">$PROFILE_PNAME(E)</span></td><td>"
  append HTML_PARAMS(separate_1) "<input type=\"text\" id=\"separate_${special_input_id}_7\" name=\"LED_ONTIME\" size=\"5\" value=\"[format %.2f $ps(LED_ONTIME)]\">"
  append HTML_PARAMS(separate_1) " s (0 - 1.27)</td><td><p id=\"slider_1_7\" style=\"display:none\"></p></td></tr>"

  set param TRANSMIT_TRY_MAX
  if {[catch {set tmp $ps($param)}] == 0} {
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td>\${stringTableTransmitTryMax}</td>"
      append HTML_PARAMS(separate_1) "<td><input id=\"separate_${special_input_id}_8\" type=\"text\" size=\"5\" value=$ps($param) name=$param></td>"
    append HTML_PARAMS(separate_1) "</tr>"
  }

  append HTML_PARAMS(separate_1) "</table>"

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\" id=\"md_ch_help\" style=\"display:none\">"
  append HTML_PARAMS(separate_1) "<tr><td id=\"helpText\">$help_txt</td></tr>"
  append HTML_PARAMS(separate_1) "</table>"  

  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "st_setStringTableValues();"
    append HTML_PARAMS(separate_1) "jQuery(\"#md_help_button\").val(translateKey(\"genericBtnTxtHelp\"));"
  append HTML_PARAMS(separate_1) "</script>"
}

constructor
