#!/bin/tclsh

#Kanal-EasyMode!

#source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join /www/config/easymodes/em_common.tcl]

#Namen der EasyModes tauchen nicht mehr auf. Der Durchgängkeit werden sie hier noch definiert.
set PROFILES_MAP(0)  "Experte"
set PROFILES_MAP(1)  "TheOneAndOnlyEasyMode"

proc getCheckBox {type param value prn} {
  set checked ""
  if { $value } then { set checked "checked=\"checked\"" }
  set s "<input id='separate_$type\_$prn' type='checkbox' $checked value='dummy' name=$param/>"
  return $s
}

proc getMinValue {param} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set min [format {%1.1f} $param_descr(MIN)]
  return "$min"
}

proc getMaxValue {param} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set max [format {%1.1f} $param_descr(MAX)]
  return "$max"
}

proc getTextField {type param value prn} {
  global psDescr
  set elemId 'separate_$type\_$prn'
  # Limit float to 2 decimal places
  if {[llength [split $value "."]] == 2} {
    set value [format {%1.2f} $value]
  }
  set s "<input id=$elemId type=\"text\" size=\"5\" value=$value name=\"$param\" onblur=\"ProofAndSetValue(this.id, this.id, [getMinValue $param], [getMaxValue $param], 1)\"/>"


  return $s
}

proc getUnit {param} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set unit $param_descr(UNIT)

  if {$unit == "minutes"} {
   set unit "\${lblMinutes}"
  }

  if {$unit == "K"} {
    set unit "&#176;C"
  }

  return "$unit"
}

proc getMinMaxValueDescr {param} {
  global psDescr
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set min $param_descr(MIN)
  set max $param_descr(MAX)

  # Limit float to 2 decimal places
  if {[llength [split $min "."]] == 2} {
    set min [format {%1.2f} $min]
    set max [format {%1.2f} $max]
  }
  return "($min - $max)"
}

proc getHelpIcon {topic x y} {
  set ret "<img src=\"/ise/img/help.png\" style=\"cursor: pointer; width:18px; height:18px; position:relative; top:2px\" onclick=\"showParamHelp('$topic', '$x', '$y')\">"
  return $ret
}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr
  
  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/CC.js');load_JSFunc('/config/easymodes/MASTER_LANG/HEATINGTHERMOSTATE_2ND_GEN.js');load_JSFunc('/config/easymodes/MASTER_LANG/HEATINGTHERMOSTATE_2ND_GEN_HELP.js');</script>"

  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    ps_descr
  
  #upvar PROFILE_0     PROFILE_0
  upvar PROFILE_1     PROFILE_1

  set DEVICE "DEVICE"

  set hlpBoxWidth 450
  set hlpBoxHeight 160

  array set psDescr [xmlrpc $iface_url($iface) getParamsetDescription [list string $address] [list string MASTER]]

  puts "<script type=\"text/javascript\">"

    puts "addHintHeatingGroupDevice('$address');"

    puts "setDecalcTime = function(id) {"
      puts "var valHour = jQuery('#decalcHour').val();"
      puts "var valMin = jQuery('#decalcMin').val();"
      puts "jQuery('#separate_DEVICE_' + id).val((valHour * 60) + parseInt(valMin));"
    puts "}"

    puts "setTimeSelector = function(val) {"
      puts "var selHour = parseInt(val / 60);"
      puts "var selMin = val % 60;"
      puts "jQuery('#decalcHour').val(selHour).attr('selected',true);"
      puts "jQuery('#decalcMin').val(selMin).attr('selected',true);"
    puts "}"
   puts "</script>"

  # Zeittabelle sichtbar / unsichtbar schalten.
  ##append HTML_PARAMS(separate_1) "<script text=\"javascript\">"
  ##append HTML_PARAMS(separate_1) "CC_TimeTable_on_off();"
  ##append HTML_PARAMS(separate_1) "</script>"


    ## Wochenprogramm ##

    append HTML_PARAMS(separate_1) "<div id=\"Timeouts_Area\" style=\"display:none\">"
    #Die DIV - Tags müssen schon existieren, wenn man in die Funktion tom.setTemp geht
    foreach day {SATURDAY SUNDAY MONDAY TUESDAY WEDNESDAY THURSDAY FRIDAY} {
      append HTML_PARAMS(separate_1) "<div id=\"temp_prof_$day\"></div>"
    }
    append HTML_PARAMS(separate_1) "</div>"

    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "tom = new TimeoutManager('$iface', '$address');"

    foreach day {SATURDAY SUNDAY MONDAY TUESDAY WEDNESDAY THURSDAY FRIDAY} {

      for {set i 1} {$i <= 13} {incr i} {

        set timeout     $ps(ENDTIME_${day}_$i)
        set temperature $ps(TEMPERATURE_${day}_$i)
        append HTML_PARAMS(separate_1) "tom.setTemp('$day', $timeout, $temperature);"

        if {$timeout == 1440} then {
          break;
        }
      }

      append HTML_PARAMS(separate_1) "tom.setDivname('$day', 'temp_prof_$day');"
      append HTML_PARAMS(separate_1) "tom.writeDay('$day');"
    }

    # TODO - Set the weekly program only visible while certain modes are active.
    # This has to be clarified with the developer of the device
    append HTML_PARAMS(separate_1)  "jQuery('#Timeouts_Area').show();"

    append HTML_PARAMS(separate_1) "</script>"

    ## Ende Wochenprogramm ##


  #append HTML_PARAMS(separate_0) [cmd_link_paramset $iface $address MASTER MASTER DEVICE]
  append HTML_PARAMS(separate_1)  "<input id='separate_DEVICE_0' style='display:none' type='checkbox' value='dummy' />"
  append HTML_PARAMS(separate_1)  "<input id='separate_DEVICE_1' style='display:none' type='checkbox' value='dummy' />"
  append HTML_PARAMS(separate_1)  "<input id='separate_DEVICE_2' style='display:none' type='checkbox' value='dummy' />"

  append HTML_PARAMS(separate_1) "<hr>"

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

      # left
      set prn 3
      set param BURST_RX
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableBurstRX}</td>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">"
      append HTML_PARAMS(separate_1) "[getCheckBox $DEVICE '$param' $ps($param) $prn]"
      append HTML_PARAMS(separate_1) "</td>"
      # right
      incr prn
      set param CYCLIC_INFO_MSG
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableCyclicInfoMsg}</td>"
      append HTML_PARAMS(separate_1)  "<td name=\"expertParam\" class=\"hidden\">[getCheckBox $DEVICE '$param' $ps($param) $prn]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

      # left
      incr prn
      set param BUTTON_LOCK
      append HTML_PARAMS(separate_1) "<tr><td>\${stringTableButtonLock}</td><td>"
      append HTML_PARAMS(separate_1)  [getCheckBox $DEVICE '$param' $ps($param) $prn][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]
      append HTML_PARAMS(separate_1) "</td>"

      # right
      incr prn
      set param CYCLIC_INFO_MSG_DIS
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableCyclicInfoMsgDis}</td>"
      append HTML_PARAMS(separate_1)  "<td name=\"expertParam\" class=\"hidden\">[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

      # left
      incr prn
      set param GLOBAL_BUTTON_LOCK
      append HTML_PARAMS(separate_1) "<tr><td>\${stringTableGlobalButtonLock}</td><td>"
      append HTML_PARAMS(separate_1)  [getCheckBox $DEVICE '$param' $ps($param) $prn][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]
      append HTML_PARAMS(separate_1) "</td>"

      # right
      incr prn
      set param LOCAL_RESET_DISABLE
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableLocalResetDisable}</td>"
      append HTML_PARAMS(separate_1)  "<td name=\"expertParam\" class=\"hidden\">[getCheckBox $DEVICE '$param' $ps($param) $prn]</td>"

      append HTML_PARAMS(separate_1) "</tr>"

      # left
      incr prn
      set param MODUS_BUTTON_LOCK
      append HTML_PARAMS(separate_1) "<tr><td>\${stringTableModusButtonLock}</td><td>"
      append HTML_PARAMS(separate_1)  [getCheckBox $DEVICE '$param' $ps($param) $prn][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]
      append HTML_PARAMS(separate_1) "</td>"

      # right
      incr prn
      set param LOW_BAT_LIMIT
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableBatteryLowBatLimit}</td>"
      append HTML_PARAMS(separate_1)  "<td name=\"expertParam\" class=\"hidden\">[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"

      append HTML_PARAMS(separate_1) "</tr>"

      # left
      incr prn
      set param BACKLIGHT_ON_TIME
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableBackLightOnTime}</td>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

      # left
      incr prn
      set param BUTTON_RESPONSE_WITHOUT_BACKLIGHT
      append HTML_PARAMS(separate_1) "<tr><td name=\"expertParam\" class=\"hidden\">\${stringTableButtonResponseWithoutBacklight}</td>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">"
      append HTML_PARAMS(separate_1)  [getCheckBox $DEVICE '$param' $ps($param) $prn]
      append HTML_PARAMS(separate_1) "</td>"
      append HTML_PARAMS(separate_1) "</tr>"
  append HTML_PARAMS(separate_1) "</table>"

  append HTML_PARAMS(separate_1) "<hr>"

  # TEMPERATURE_SETTINGS
  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

      # left
      incr prn
      set param TEMPERATURE_COMFORT
      append HTML_PARAMS(separate_1) "<tr><td>\${stringTableTemperatureComfort}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]<input id=\"comfortOld\" type=\"hidden\" value=\"$ps($param)\"></td>"
      append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
        append HTML_PARAMS(separate_1) "jQuery(\"#separate_$DEVICE\_$prn\").bind(\"blur\",function() {ProofAndSetValue(this.id, this.id, [getMinValue $param], [getMaxValue $param], 1);isEcoLTComfort(this.name);});"
      append HTML_PARAMS(separate_1) "</script>"


      # right
      incr prn
      set param TEMPERATURE_LOWERING
      append HTML_PARAMS(separate_1) "<td>\${stringTableTemperatureLowering}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]<input id=\"ecoOld\" type=\"hidden\" value=\"$ps($param)\"></td>"
      append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
        append HTML_PARAMS(separate_1) "jQuery(\"#separate_$DEVICE\_$prn\").bind(\"blur\",function() {ProofAndSetValue(this.id, this.id, [getMinValue $param], [getMaxValue $param], 1);isEcoLTComfort(this.name);});"
      append HTML_PARAMS(separate_1) "</script>"
      append HTML_PARAMS(separate_1) "</tr>"

      append HTML_PARAMS(separate_1) "<tr id=\"errorRow\" class=\"hidden\"> <td></td> <td colspan=\"2\"><span id=\"errorComfort\" class=\"attention\"></span></td> <td colspan=\"2\"><span id=\"errorEco\" class=\"attention\"></span></td> </tr>"

      # left
      incr prn
      set param TEMPERATURE_MINIMUM
      array_clear options
      set i 0
      for {set val [getMinValue $param]} {$val <= [getMaxValue $param]} {set val [expr $val + 0.5]} {
        set options($i) "$val &#176;C"
        incr i;
      }
      append HTML_PARAMS(separate_1) "<tr><td>\${stringTableTemperatureMinimum}</td>"
      append HTML_PARAMS(separate_1)  "<td>[get_ComboBox options $param tmp_$DEVICE\_$prn ps $param onchange=setMinMaxTemp('tmp_$DEVICE\_$prn','separate_$DEVICE\_$prn')]</span> <span class='hidden'>[getTextField $DEVICE $param $ps($param) $prn]</span></td>"
      append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
      append HTML_PARAMS(separate_1) "setMinMaxTempOption('tmp_$DEVICE\_$prn', 'separate_$DEVICE\_$prn' );"
      append HTML_PARAMS(separate_1) "</script>"

      # right
      incr prn
      set param TEMPERATURE_MAXIMUM
      array_clear options
      set i 0
      for {set val [getMinValue $param]} {$val <= [getMaxValue $param]} {set val [expr $val + 0.5]} {
        set options($i) "$val &#176;C"
        incr i;
      }
      append HTML_PARAMS(separate_1) "<td>\${stringTableTemperatureMaximum}</td>"
      append HTML_PARAMS(separate_1)  "<td>[get_ComboBox options $param tmp_$DEVICE\_$prn ps $param onchange=setMinMaxTemp('tmp_$DEVICE\_$prn','separate_$DEVICE\_$prn')]</span> <span class='hidden'>[getTextField $DEVICE $param $ps($param) $prn]</span></td>"
      append HTML_PARAMS(separate_1) "</tr>"
      append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
      append HTML_PARAMS(separate_1) "setMinMaxTempOption('tmp_$DEVICE\_$prn', 'separate_$DEVICE\_$prn' );"
      append HTML_PARAMS(separate_1) "</script>"

      # left
      incr prn
      set param MIN_MAX_VALUE_NOT_RELEVANT_FOR_MANU_MODE
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableMinMaxValNotRelevantForManuMode}</td>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">[getCheckBox $DEVICE '$param' $ps($param) $prn]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

      # left
      incr prn
      set param TEMPERATUREFALL_VALUE
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableTemperatureFallValue}</td>"
      append HTML_PARAMS(separate_1)  "<td name=\"expertParam\" class=\"hidden\">[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"

      # right
      incr prn
      set param TEMPERATUREFALL_WINDOW_OPEN
      append HTML_PARAMS(separate_1) "<td>\${stringTableTemperatureFallWindowOpen}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

      # left
      incr prn
      set param TEMPERATUREFALL_MODUS
      array_clear options
      set options(0) "\${stringTableTemperatureFallModeOpt0}"
      set options(1) "\${stringTableTemperatureFallModeOpt1}"
      set options(2) "\${stringTableTemperatureFallModeOpt2}"

      # TODO activate with homematic version 2.8 (party)
      ##set options(3) "\${stringTableTemperatureFallModeOpt3}"
      set options(4) "\${stringTableTemperatureFallModeOpt4}"
      append HTML_PARAMS(separate_1) "<tr><td>\${stringTableTemperatureFallModeOptions}</td><td>"
      append HTML_PARAMS(separate_1)  [get_ComboBox options $param separate_$DEVICE\_$prn ps $param][getHelpIcon $param $hlpBoxWidth [expr $hlpBoxHeight + 20]]

      append HTML_PARAMS(separate_1) "</td>"
      # right
      incr prn
      set param TEMPERATUREFALL_WINDOW_OPEN_TIME_PERIOD
      array_clear options
      for {set i [expr int([getMinValue $param])]} {$i <= [expr int([getMaxValue $param])]} {incr i 5} {
        set options($i) $i
      }
      append HTML_PARAMS(separate_1) "<td>\${stringTableTemperatureFallOpenTimePeriod}</td>"
      # append HTML_PARAMS(separate_1)  "<td>[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
      append HTML_PARAMS(separate_1)  "<td>[get_ComboBox options $param separate_$DEVICE\_$prn ps $param]&nbsp;[getUnit $param][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

  append HTML_PARAMS(separate_1) "</table>"

  append HTML_PARAMS(separate_1) "<hr>"

  # TEMPERATURE_SETTINGS
  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

      # left
      incr prn
      set param DECALCIFICATION_WEEKDAY
      array_clear options
      set i 0
      foreach day {\${optionSat} \${optionSun} \${optionMon} \${optionTue} \${optionWed} \${optionThu} \${optionFri}} {
        set options($i) $day
        incr i
      }
      append HTML_PARAMS(separate_1) "<tr><td>\${stringTableClimateControlRegDecalcDay}</td>"
      append HTML_PARAMS(separate_1) "<td>[get_ComboBox options $param separate_$DEVICE\_$prn ps $param]</td>"

      # right
      incr prn
      set param DECALCIFICATION_TIME
      append HTML_PARAMS(separate_1) "<td  style=\"text-align:right;\">\${stringTableClimateControlRegDecalcTime}</td>"

        # Decalcification hour
        append HTML_PARAMS(separate_1) "<td>"
          append HTML_PARAMS(separate_1) "<select id='decalcHour' onChange='setDecalcTime($prn);'>"
            for {set i 0} {$i<=23} {incr i} {
              append HTML_PARAMS(separate_1) "<option value='$i'>$i</option>"
            }
          append HTML_PARAMS(separate_1) "</select> : "
        # Decalcification minute
          append HTML_PARAMS(separate_1) "<select id='decalcMin' onChange='setDecalcTime($prn);'>"
              append HTML_PARAMS(separate_1) "<option value='0'>00</option>"
              append HTML_PARAMS(separate_1) "<option value='30'>30</option>"
          append HTML_PARAMS(separate_1) "</select>"
          append HTML_PARAMS(separate_1) "[getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]"
        append HTML_PARAMS(separate_1) "</td>"
      append HTML_PARAMS(separate_1)  "<td class='hidden'>[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"

      puts "<script type=\"text/javascript\">setTimeSelector($ps($param));</script>"
      append HTML_PARAMS(separate_1) "</tr>"

      # left
      incr prn
      set param TEMPERATURE_OFFSET
      array_clear options
      set i 0
      for {set val -3.5} {$val <= 3.5} {set val [expr $val + 0.5]} {
        set options($i) "$val &#176;C"
        incr i;
      }
      append HTML_PARAMS(separate_1) "<tr><td>\${stringTableTemperatureOffset}</td>"
      append HTML_PARAMS(separate_1) "<td>[get_ComboBox options $param separate_$DEVICE\_$prn ps $param][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

      # left
      incr prn
      set param BOOST_TIME_PERIOD
      array_clear options
      set i 0
      for {set val 0} {$val <= 30} {incr val 5} {
          set options($i) "$val min"
        incr i;
      }
      append HTML_PARAMS(separate_1) "<tr><td>\${stringTableBoostTimePeriod}</td>"
      append HTML_PARAMS(separate_1) "<td>[get_ComboBox options $param separate_$DEVICE\_$prn ps $param][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
      append HTML_PARAMS(separate_1) "</td>"

      # mid
      incr prn
      set param BOOST_POSITION
      append HTML_PARAMS(separate_1) "<td>\${stringTableBoostPosition}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"

      # right
      incr prn
      set param BOOST_AFTER_WINDOW_OPEN
      append HTML_PARAMS(separate_1) "<td>\${stringTableBoostAfterWindowOpen}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getCheckBox $DEVICE '$param' $ps($param) $prn][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

  append HTML_PARAMS(separate_1) "</table>"

  append HTML_PARAMS(separate_1) "<hr>"

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
      # left
      incr prn
      set param SHOW_WEEKDAY
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableShowWeekday}</td>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">[getCheckBox $DEVICE '$param' $ps($param) $prn]</td>"
       append HTML_PARAMS(separate_1) "</tr>"

      # left
      incr prn
      set param DISPLAY_INFORMATION
      array_clear options
      set options(0) "\${stringTableDisplayInformationOpt0}"
      set options(1) "\${stringTableDisplayInformationOpt1}"
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableDisplayInformation}</td>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">[get_ComboBox options $param separate_$DEVICE\_$prn ps $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

      # left
      incr prn
      set param DAYLIGHT_SAVING_TIME
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableDST}</td>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">[getCheckBox $DEVICE '$param' $ps($param) $prn]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

  append HTML_PARAMS(separate_1) "</table>"
  append HTML_PARAMS(separate_1) "<hr name=\"expertParam\" class=\"hidden\">"

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
      # left
      incr prn
      set param VALVE_OFFSET
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableValveOffset}</td>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param $hlpBoxWidth [expr $hlpBoxHeight + 40]]</td>"

      # mid
      incr prn
      set param VALVE_ERROR_RUN_POSITION
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableValveErrorPosition}</td>"
      append HTML_PARAMS(separate_1)  "<td name=\"expertParam\" class=\"hidden\">[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"

      # right
      incr prn
      set param VALVE_MAXIMUM_POSITION
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableValveMaxPosition}</td>"
      append HTML_PARAMS(separate_1)  "<td name=\"expertParam\" class=\"hidden\">[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

  append HTML_PARAMS(separate_1) "</table>"
  append HTML_PARAMS(separate_1) "<hr name=\"expertParam\" class=\"hidden\">"

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
      # left
      incr prn
      set param ADAPTIVE_REGULATION
      array_clear options
      set options(0) "\${stringTableAdaptiveRegulationOpt0}"
      set options(1) "\${stringTableAdaptiveRegulationOpt1}"
      set options(2) "\${stringTableAdaptiveRegulationOpt2}"
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableAdaptiveRegulation}</td><td>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">[get_ComboBox options $param separate_$DEVICE\_$prn ps $param]</td>"
      append HTML_PARAMS(separate_1) "</td>"
      append HTML_PARAMS(separate_1) "</tr>"

      # left
      incr prn
      set param MANU_MODE_PRIORITIZATION
      array_clear options
      set options(0) "\${stringTableManuPartyModePrioOpt0}"
      set options(1) "\${stringTableManuPartyModePrioOpt1}"
      set options(2) "\${stringTableManuPartyModePrioOpt2}"
      set options(3) "\${stringTableManuPartyModePrioOpt3}"
      set options(4) "\${stringTableManuPartyModePrioOpt4}"

      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableManuModePrio}</td><td>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">[get_ComboBox options $param separate_$DEVICE\_$prn ps $param][getHelpIcon $param $hlpBoxWidth 400]</td>"
      append HTML_PARAMS(separate_1) "</td>"

      # right
      incr prn
      set param PARTY_MODE_PRIORITIZATION
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTablePartyModePrio}</td><td>"
      append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">[get_ComboBox options $param separate_$DEVICE\_$prn ps $param][getHelpIcon $param $hlpBoxWidth 400]</td>"
      append HTML_PARAMS(separate_1) "</td>"
      append HTML_PARAMS(separate_1) "</tr>"
  append HTML_PARAMS(separate_1) "</table>"
  append HTML_PARAMS(separate_1) "<hr name=\"expertParam\" class=\"hidden\">"

set comment {
  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

      # left
      incr prn
      set param I_VALUE_INTERN
      append HTML_PARAMS(separate_1) "<tr><td>\${stringTableIValueIntern}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"

      # mid
      incr prn
      set param P_VALUE_INTERN
      append HTML_PARAMS(separate_1) "<td>\${stringTablePValueIntern}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"

      # right
      incr prn
      set param P_START_VALUE_INTERN
      append HTML_PARAMS(separate_1) "<td>\${stringTablePStartValueIntern}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

      # left
      incr prn
      set param I_VALUE_EXTERN
      append HTML_PARAMS(separate_1) "<tr><td>\${stringTableIValueExtern}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"

      # mid
      incr prn
      set param P_VALUE_EXTERN
      append HTML_PARAMS(separate_1) "<td>\${stringTablePValueExtern}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"

      # right
      incr prn
      set param P_START_VALUE_EXTERN
      append HTML_PARAMS(separate_1) "<td>\${stringTablePStartValueExtern}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit $param]&nbsp;[getMinMaxValueDescr $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

  append HTML_PARAMS(separate_1) "</table>"
  append HTML_PARAMS(separate_1) "<hr>"
}
  if {[session_is_expert]} {
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
      append HTML_PARAMS(separate_1) "jQuery(\"\[name='expertParam'\]\").show();"
    append HTML_PARAMS(separate_1) "</script>"
  } else {
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
      append HTML_PARAMS(separate_1) "jQuery(\"\[name='expertParam'\]\").hide();"
    append HTML_PARAMS(separate_1) "</script>"
  }
}

constructor
