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

proc getMinValue {psDescr param} {
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set min [format {%1.1f} $param_descr(MIN)]
  return "$min"
}

proc getMaxValue {psDescr param} {
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set max [format {%1.1f} $param_descr(MAX)]
  return "$max"
}

proc getTextField {type param value prn} {
  set elemId 'separate_$type\_$prn'
  # Limit float to 2 decimal places
  if {[llength [split $value "."]] == 2} {
    set value [format {%1.2f} $value]
  }

  set s "<input id=$elemId type=\"text\" size=\"5\" value=$value name=$param>"
  return $s
}

proc getUnit {psDescr param} {
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

proc getMinMaxValueDescr {psDescr param} {
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

  global env iface_url
  
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

  foreach val [array names psDescr] {
    #puts "$val: $psDescr($val)\n"
  }

  puts "<script type=\"text/javascript\">"

    puts "addHintHeatingGroupDevice('$address');"

    puts "setDecalcTime = function(id) {"
      puts "var valHour = jQuery('#decalcHour').val();"
      puts "var valMin = jQuery('#decalcMin').val();"
      puts "jQuery('#separate_DEVICE_' + id).val((valHour * 60) + parseInt(valMin));"
    puts "};"

    puts "setTimeSelector = function(val) {"
      puts "var selHour = parseInt(val / 60);"
      puts "var selMin = val % 60;"
      puts "jQuery('#decalcHour').val(selHour).attr('selected',true);"
      puts "jQuery('#decalcMin').val(selMin).attr('selected',true);"
    puts "};"

    puts "ShowActiveWeeklyProgram = function(activePrg) {"
      puts "conInfo('activePrg: ' + activePrg);"
      puts " for (var i = 1; i <= 3; i++) {"
        puts "jQuery('#P' + i + '_Timeouts_Area').hide();"
      puts " }"
      puts " jQuery('#P' + activePrg + '_Timeouts_Area').show();"
    puts "};"

    puts "setDisplayMode = function(elem) {"
      puts "var mode = jQuery(elem).val();"
      puts "modeElem = jQuery(\".j_showHumidity\");"
      puts "if (mode == 0) {"
        puts "jQuery(modeElem).show();"
      puts "} else {jQuery(modeElem).hide();}"
    puts "};"

   puts "</script>"

  set prn 3
    # Choose the program to edit

    #left
    set param WEEK_PROGRAM_POINTER
    append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
      append HTML_PARAMS(separate_1) "<tr><td>\${stringTableWeekProgramPointer}</td>"
        append HTML_PARAMS(separate_1) "<td>\${stringTableWeekProgram1}</td><td><input style='vertical-align:bottom' type='radio' name='weeklyProgram' value='0'></td><td>&nbsp;</td>"
        append HTML_PARAMS(separate_1) "<td>\${stringTableWeekProgram2}</td><td><input style='vertical-align:bottom' type='radio' name='weeklyProgram' value='1'></td><td>&nbsp;</td>"
        append HTML_PARAMS(separate_1) "<td>\${stringTableWeekProgram3}</td><td><input style='vertical-align:bottom' type='radio' name='weeklyProgram' value='2'></td><td>&nbsp;</td>"
      append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "</table>"


  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    append HTML_PARAMS(separate_1) "<td class='hidden'><input type='text' id='separate_$DEVICE\_$prn' name='$param'></td>"
    append HTML_PARAMS(separate_1) "</tr>"

    # left
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td name=\"_expertParam\" class=\"_hidden\">\${stringTableWeekProgramToEdit}</td>"
      #append HTML_PARAMS(separate_1) "<td name=\"_expertParam\" class=\"_hidden\">[get_ComboBox options $param separate_$DEVICE\_$prn ps $param "onchange=\"ShowActiveWeeklyProgram(parseInt(\$(this).value)+1);\""][getHelpIcon $param [expr $hlpBoxWidth * 0.8] [expr $hlpBoxHeight / 2]]</td>"
      append HTML_PARAMS(separate_1) "<td name=\"_expertParam\" class=\"_hidden\">"
        append HTML_PARAMS(separate_1) "<select id=\"editProgram\" onchange=\"ShowActiveWeeklyProgram(parseInt(\$(this).value)+1);\">"
          append HTML_PARAMS(separate_1) "<option value='0'>\${stringTableWeekProgram1}</option>"
          append HTML_PARAMS(separate_1) "<option value='1'>\${stringTableWeekProgram2}</option>"
          append HTML_PARAMS(separate_1) "<option value='2'>\${stringTableWeekProgram3}</option>"
      append HTML_PARAMS(separate_1) "</select>[getHelpIcon $param [expr $hlpBoxWidth * 0.8] [expr $hlpBoxHeight / 2]]"
      append HTML_PARAMS(separate_1) "</td>"
    append HTML_PARAMS(separate_1) "</tr>"
  append HTML_PARAMS(separate_1) "</table>"

  ## Create 3 Weekly Programs ##

  for {set loop 1} {$loop <=3} {incr loop} {
    set pNr "P$loop";
    append HTML_PARAMS(separate_1) "<div id=\"$pNr\_Timeouts_Area\" style=\"display:none\">"
    foreach day {SATURDAY SUNDAY MONDAY TUESDAY WEDNESDAY THURSDAY FRIDAY} {
      append HTML_PARAMS(separate_1) "<div id=\"$pNr\_temp_prof_$day\"></div>"
    }
    append HTML_PARAMS(separate_1) "</div>"

    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "$pNr\_tom = new TimeoutManager('$iface', '$address', false, '$pNr\_');"
    foreach day {SATURDAY SUNDAY MONDAY TUESDAY WEDNESDAY THURSDAY FRIDAY} {

      for {set i 1} {$i <= 13} {incr i} {

        set timeout     $ps($pNr\_ENDTIME_${day}_$i)
        set temperature $ps($pNr\_TEMPERATURE_${day}_$i)
        append HTML_PARAMS(separate_1) "$pNr\_tom.setTemp('$day', $timeout, $temperature);"

        if {$timeout == 1440} then {
          break;
        }
      }

      append HTML_PARAMS(separate_1) "$pNr\_tom.setDivname('$day', '$pNr\_temp_prof_$day');"
      append HTML_PARAMS(separate_1) "$pNr\_tom.writeDay('$day');"
    }

    append HTML_PARAMS(separate_1) "</script>"
  }

  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "jQuery(\"input\[type='radio'\]\").change(function () {"
      append HTML_PARAMS(separate_1) "var selection=jQuery(this).val();"
      append HTML_PARAMS(separate_1) "conInfo(\"Radio button selection changed. Selected: \"+selection);"
      append HTML_PARAMS(separate_1) "jQuery('#separate_$DEVICE\_$prn').val(selection);"
    append HTML_PARAMS(separate_1) "});"

    #append HTML_PARAMS(separate_1) "jQuery(':radio\[value=\"1\"\]').attr('checked', 'checked');"
    append HTML_PARAMS(separate_1) "jQuery(':radio\[value=\"$ps($param)\"\]').attr('checked', 'checked');"
    append HTML_PARAMS(separate_1) "jQuery(':radio\[value=\"$ps($param)\"\]').change();"

    append HTML_PARAMS(separate_1) "jQuery('#editProgram').val($ps($param));"
    append HTML_PARAMS(separate_1) "ShowActiveWeeklyProgram(parseInt($ps($param)) + 1);"
  append HTML_PARAMS(separate_1) "</script>"

  ## END Weekly Programs ##


  #append HTML_PARAMS(separate_0) [cmd_link_paramset $iface $address MASTER MASTER DEVICE]
  append HTML_PARAMS(separate_1)  "<input id='separate_DEVICE_0' style='display:none' type='checkbox' value='dummy' />"
  append HTML_PARAMS(separate_1)  "<input id='separate_DEVICE_1' style='display:none' type='checkbox' value='dummy' />"
  append HTML_PARAMS(separate_1)  "<input id='separate_DEVICE_2' style='display:none' type='checkbox' value='dummy' />"

  append HTML_PARAMS(separate_1) "<hr>"

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    # left
    incr prn
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
    append HTML_PARAMS(separate_1)  "<td name=\"expertParam\" class=\"hidden\">[getTextField $DEVICE '$param' $ps($param) $prn]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
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
    append HTML_PARAMS(separate_1)  "<td name=\"expertParam\" class=\"hidden\">[getTextField $DEVICE '$param' $ps($param) $prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"

    append HTML_PARAMS(separate_1) "</tr>"
  append HTML_PARAMS(separate_1) "</table>"

  append HTML_PARAMS(separate_1) "<hr>"

  # TEMPERATURE_SETTINGS
  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

      # left
      incr prn
      set param TEMPERATURE_COMFORT
      append HTML_PARAMS(separate_1) "<tr><td>\${stringTableTemperatureComfort}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]<input id=\"comfortOld\" type=\"hidden\" value=\"$ps($param)\"></td>"
      append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
        append HTML_PARAMS(separate_1) "jQuery(\"#separate_$DEVICE\_$prn\").bind(\"blur\",function() {ProofAndSetValue(this.id, this.id, '[getMinValue psDescr $param]', '[getMaxValue psDescr $param]', 1);isEcoLTComfort(this.name);});"
      append HTML_PARAMS(separate_1) "</script>"


      # right
      incr prn
      set param TEMPERATURE_LOWERING
      append HTML_PARAMS(separate_1) "<td>\${stringTableTemperatureLowering}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $DEVICE $param $ps($param) $prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]<input id=\"ecoOld\" type=\"hidden\" value=\"$ps($param)\"></td>"
      append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
        append HTML_PARAMS(separate_1) "jQuery(\"#separate_$DEVICE\_$prn\").bind(\"blur\",function() {ProofAndSetValue(this.id, this.id, '[getMinValue psDescr $param]', '[getMaxValue psDescr $param]', 1);isEcoLTComfort(this.name);});"
      append HTML_PARAMS(separate_1) "</script>"
      append HTML_PARAMS(separate_1) "</tr>"

      append HTML_PARAMS(separate_1) "<tr id=\"errorRow\" class=\"hidden\"> <td></td> <td colspan=\"2\"><span id=\"errorComfort\" class=\"attention\"></span></td> <td colspan=\"2\"><span id=\"errorEco\" class=\"attention\"></span></td> </tr>"


    # left
    incr prn
    set param TEMPERATURE_MINIMUM
    array_clear options
    set i 0
    for {set val [getMinValue psDescr $param]} {$val <= [getMaxValue psDescr $param]} {set val [expr $val + 0.5]} {
      set options($i) "$val &#176;C"
      incr i;
    }
    append HTML_PARAMS(separate_1) "<tr><td>\${stringTableTemperatureMinimum}</td>"
    append HTML_PARAMS(separate_1)  "<td>[get_ComboBox options $param tmp_$DEVICE\_$prn ps $param onchange=setMinMaxTemp('tmp_$DEVICE\_$prn','separate_$DEVICE\_$prn')]</span> <span class='hidden'>[getTextField $DEVICE '$param' $ps($param) $prn]</span></td>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "setMinMaxTempOption('tmp_$DEVICE\_$prn', 'separate_$DEVICE\_$prn' );"
    append HTML_PARAMS(separate_1) "</script>"

    # right
    incr prn
    set param TEMPERATURE_MAXIMUM
    array_clear options
    set i 0
    for {set val [getMinValue psDescr $param]} {$val <= [getMaxValue psDescr $param]} {set val [expr $val + 0.5]} {
      set options($i) "$val &#176;C"
      incr i;
    }
    append HTML_PARAMS(separate_1) "<td>\${stringTableTemperatureMaximum}</td>"
    append HTML_PARAMS(separate_1)  "<td>[get_ComboBox options $param tmp_$DEVICE\_$prn ps $param onchange=setMinMaxTemp('tmp_$DEVICE\_$prn','separate_$DEVICE\_$prn')]</span> <span class='hidden'>[getTextField $DEVICE '$param' $ps($param) $prn]</span></td>"
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

  append HTML_PARAMS(separate_1) "</table>"
  append HTML_PARAMS(separate_1) "<hr>"

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

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

    set comment {
      # left
      incr prn
      set param TWO_POINT_HYSTERESIS
      append HTML_PARAMS(separate_1) "<tr><td>\${stringTableTwoPointHysteresis}</td>"
      append HTML_PARAMS(separate_1)  "<td>[getTextField $DEVICE '$param' $ps($param) $prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param][getHelpIcon $param $hlpBoxWidth $hlpBoxHeight]</td>"
    }

    # left
    incr prn
    set param HEATING_COOLING
    array_clear options
    set options(0) "\${stringTableHeating}"
    set options(1) "\${stringTableCooling}"

    append HTML_PARAMS(separate_1) "<tr><td>\${stringTableHeatingCooling}</td>"
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
    set param SHOW_SET_TEMPERATUR
    array_clear options
    set options(0) "\${stringTableClimateControlRegDisplayTempInfoActualTemp}"
    set options(1) "\${stringTableClimateControlRegDisplayTempInfoSetPoint}"

    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1) "<td name=\"_expertParam\" class=\"_hidden\">\${stringTableClimateControlRegDisplayTempInfo}</td>"
    append HTML_PARAMS(separate_1) "<td name=\"_expertParam\" class=\"_hidden\">[get_ComboBox options $param separate_$DEVICE\_$prn ps $param onchange=\"setDisplayMode(this)\"]</td>"

    array_clear options
    set options(0) "\${stringTableClimateControlRegDisplayTempHumT}"
    set options(1) "\${stringTableClimateControlRegDisplayTempHumTH}"

    # right
    incr prn
    set param SHOW_HUMIDITY
    append HTML_PARAMS(separate_1) "<td name=\"_expertParam\" class=\"hidden j_showHumidity\">\${stringTableClimateControlRegDisplayTempHum}</td>"
    append HTML_PARAMS(separate_1) "<td name=\"_expertParam\" class=\"hidden j_showHumidity\">[get_ComboBox options $param separate_$DEVICE\_$prn ps $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"


    # left
    incr prn
    set param DAYLIGHT_SAVING_TIME
    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableDST}</td>"
    append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">[getCheckBox $DEVICE '$param' $ps($param) $prn]</td>"
    append HTML_PARAMS(separate_1) "</tr>"

    # left
    incr prn
    set param SENDE_WEATHER_DATA
    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">\${stringTableSendWeatherData}</td>"
    append HTML_PARAMS(separate_1) "<td name=\"expertParam\" class=\"hidden\">[getCheckBox $DEVICE '$param' $ps($param) $prn]</td>"
    append HTML_PARAMS(separate_1) "</tr>"

  append HTML_PARAMS(separate_1) "</table>"
    append HTML_PARAMS(separate_1) "<hr name=\"expertParam\" class=\"hidden\">"

    append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
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


  if {[session_is_expert]} {
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
      append HTML_PARAMS(separate_1) "jQuery(\"\[name='expertParam'\]\").show();"
      append HTML_PARAMS(separate_1) "setDisplayMode(jQuery(\"\[name='SHOW_SET_TEMPERATUR'\]\").first());"
    append HTML_PARAMS(separate_1) "</script>"
  } else {
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
      append HTML_PARAMS(separate_1) "jQuery(\"\[name='expertParam'\]\").hide();"
    append HTML_PARAMS(separate_1) "</script>"
  }
  
  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">setDisplayMode(jQuery(\"\[name='SHOW_SET_TEMPERATUR'\]\").first());</script>"
  
}

constructor
