#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/options.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/DIMMER_VIRTUAL_RECEIVER/getColorElement.tcl]

set PROFILES_MAP(0) "\${expert}"
set PROFILES_MAP(1) "\${dimmer_on_off}"
set PROFILES_MAP(2) "\${dimmer_on_when_change_signal}"
set PROFILES_MAP(3) "\${dimmer_toggle}"


set PROFILE_0(UI_HINT)  0
set PROFILE_0(UI_DESCRIPTION)  "Expertenprofil"
set PROFILE_0(UI_TEMPLATE)    "Expertenprofil"

set PROFILE_1(LONG_PROFILE_ACTION_TYPE)    1
set PROFILE_1(SHORT_CT_OFF)      {0 2}
set PROFILE_1(SHORT_CT_OFFDELAY)  {0 2}
set PROFILE_1(SHORT_CT_ON)      {0 2}
set PROFILE_1(SHORT_CT_ONDELAY)    {0 2}
set PROFILE_1(SHORT_CT_RAMPOFF) 0
set PROFILE_1(SHORT_CT_RAMPON) 2
set PROFILE_1(SHORT_COND_VALUE_LO)  {99 range 0 - 255}
set PROFILE_1(SHORT_COND_VALUE_HI)  150
set PROFILE_1(SHORT_OFFDELAY_TIME_BASE)       {0 range 0 - 7}
set PROFILE_1(SHORT_OFFDELAY_TIME_FACTOR)     {0 range 0 - 31}
set PROFILE_1(SHORT_OFF_TIME_BASE)            {7 range 0 - 7}
set PROFILE_1(SHORT_OFF_TIME_FACTOR)          {31 range 0 - 31}
set PROFILE_1(SHORT_ONDELAY_TIME_BASE)        {0 range 0 - 7}
set PROFILE_1(SHORT_ONDELAY_TIME_FACTOR)      {0 range 0 - 31}
set PROFILE_1(SHORT_ON_TIME_BASE)             {7 range 0 - 7}
set PROFILE_1(SHORT_ON_TIME_FACTOR)           {31 range 0 - 31}
set PROFILE_1(SHORT_ON_TIME_MODE)  0
set PROFILE_1(SHORT_OFF_TIME_MODE)  0
set PROFILE_1(SHORT_OUTPUT_BEHAVIOUR) {7 range 0 - 7}
set PROFILE_1(SHORT_OPTICAL_SIGNAL_COLOR) {7 range 0 - 7}
set PROFILE_1(SHORT_OPTICAL_SIGNAL_OFF_COLOR) {7 range 0 - 7}
set PROFILE_1(SHORT_OPTICAL_SIGNAL_BEHAVIOUR) {1 range 0 - 12}
set PROFILE_1(SHORT_OPTICAL_SIGNAL_OFF_BEHAVIOUR) {1 range 0 - 12}
set PROFILE_1(SHORT_PROFILE_REPETITIONS) {0 range 0 - 255}
set PROFILE_1(SHORT_ACTION_TYPE)  1
set PROFILE_1(SHORT_JT_OFF)      1
set PROFILE_1(SHORT_JT_OFFDELAY)  3
set PROFILE_1(SHORT_JT_ON)      4
set PROFILE_1(SHORT_JT_ONDELAY)   {0 6}
set PROFILE_1(SHORT_JT_RAMPOFF)   2
set PROFILE_1(SHORT_JT_RAMPON)   {0 5}
set PROFILE_1(SHORT_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_1(SHORT_OFF_LEVEL) {0.0 range 0.0 - 1.005}
set PROFILE_1(UI_DESCRIPTION)  "Beim &Ouml;ffnen des Schaltkontaktes wird der Schalter ein- und beim Schlie&szlig;en ausgeschaltet. Die Schaltzuordnung l&auml;sst sich auch umkehren."
set PROFILE_1(UI_TEMPLATE)    $PROFILE_1(UI_DESCRIPTION)  
set PROFILE_1(UI_HINT)  1

set PROFILE_2(LONG_PROFILE_ACTION_TYPE)    1
set PROFILE_2(SHORT_ACTION_TYPE)  1
set PROFILE_2(SHORT_COND_VALUE_LO)  {101 range 0 - 255}
set PROFILE_2(SHORT_COND_VALUE_HI)  {201 range 0 - 255}
set PROFILE_2(SHORT_CT_OFF)      {0 2 3 4}
set PROFILE_2(SHORT_CT_OFFDELAY) {0 2 3 4}
set PROFILE_2(SHORT_CT_ON)      {0 2 3 4}
set PROFILE_2(SHORT_CT_ONDELAY) {0 2 3 4}
set PROFILE_2(SHORT_CT_RAMPOFF) {0 2 3 4}
set PROFILE_2(SHORT_CT_RAMPON)  {0 2 3 4}
set PROFILE_2(SHORT_JT_OFF)      1
set PROFILE_2(SHORT_JT_OFFDELAY)  3
set PROFILE_2(SHORT_JT_ON)      0
set PROFILE_2(SHORT_JT_ONDELAY)    0
set PROFILE_2(SHORT_JT_RAMPOFF) 2
set PROFILE_2(SHORT_JT_RAMPON)  0
set PROFILE_2(SHORT_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_2(SHORT_OFF_LEVEL) {0.0 range 0.0 - 1.005}
set PROFILE_2(SHORT_OFFDELAY_TIME_BASE)       {0 range 0 - 7}
set PROFILE_2(SHORT_OFFDELAY_TIME_FACTOR)     {0 range 0 - 31}
set PROFILE_2(SHORT_OFF_TIME_BASE)            {7 range 0 - 7}
set PROFILE_2(SHORT_OFF_TIME_FACTOR)          {31 range 0 - 31}
set PROFILE_2(SHORT_ONDELAY_TIME_BASE)        {0 range 0 - 7}
set PROFILE_2(SHORT_ONDELAY_TIME_FACTOR)      {0 range 0 - 31}
set PROFILE_2(SHORT_ON_TIME_BASE)             {7 range 0 - 7}
set PROFILE_2(SHORT_ON_TIME_FACTOR)           {31 range 0 - 31}
set PROFILE_2(SHORT_ON_TIME_MODE)  0
set PROFILE_2(SHORT_OFF_TIME_MODE)  0
set PROFILE_2(SHORT_OUTPUT_BEHAVIOUR) {7 range 0 - 7}
set PROFILE_2(SHORT_OPTICAL_SIGNAL_COLOR) {7 range 0 - 7}
set PROFILE_2(SHORT_OPTICAL_SIGNAL_OFF_COLOR) {7 range 0 - 7}
set PROFILE_2(SHORT_OPTICAL_SIGNAL_BEHAVIOUR) {1 range 0 - 12}
set PROFILE_2(SHORT_OPTICAL_SIGNAL_OFF_BEHAVIOUR) {1 range 0 - 12}
set PROFILE_2(SHORT_PROFILE_REPETITIONS) {0 range 0 - 255}
set PROFILE_2(UI_DESCRIPTION)  "Bei ausgew&auml;hlten Kontaktzustandswechseln wird der Schalter f&uuml;r eine bestimmte Zeit eingeschaltet."
set PROFILE_2(UI_TEMPLATE)    $PROFILE_2(UI_DESCRIPTION)  
set PROFILE_2(UI_HINT)  2


set PROFILE_3(SHORT_COND_VALUE_HI) {201 range 0 - 255}
set PROFILE_3(SHORT_COND_VALUE_LO) {101 range 0 - 255}
set PROFILE_3(SHORT_CT_OFF) 0
set PROFILE_3(SHORT_CT_OFFDELAY) 0
set PROFILE_3(SHORT_CT_ON) 0
set PROFILE_3(SHORT_CT_ONDELAY) 0
set PROFILE_3(SHORT_CT_RAMPOFF) 0
set PROFILE_3(SHORT_CT_RAMPON) 0
set PROFILE_3(SHORT_DIM_MAX_LEVEL) 1.000000
set PROFILE_3(SHORT_DIM_MIN_LEVEL) 0.000000
set PROFILE_3(SHORT_DIM_STEP) 0.050000
set PROFILE_3(SHORT_JT_OFF) 1
set PROFILE_3(SHORT_JT_OFFDELAY) 5
set PROFILE_3(SHORT_JT_ON) 4
set PROFILE_3(SHORT_JT_ONDELAY) 2
set PROFILE_3(SHORT_JT_RAMPOFF) 6
set PROFILE_3(SHORT_JT_RAMPON) 3
set PROFILE_3(SHORT_MULTIEXECUTE) 0
set PROFILE_3(SHORT_OFFDELAY_BLINK) {0 1}
set PROFILE_3(SHORT_OFFDELAY_BLINK_PERIOD_OFFDELAYLEVEL) 4
set PROFILE_3(SHORT_OFFDELAY_BLINK_PERIOD_OLDLEVEL) 4
set PROFILE_3(SHORT_OFFDELAY_STEP) 0.050000
set PROFILE_3(SHORT_OFFDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_OFFDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(SHORT_OFF_LEVEL) {0.0 range 0.0 - 1.005}
set PROFILE_3(SHORT_OFF_TIME_BASE) {7 range 0 - 7}
set PROFILE_3(SHORT_OFF_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_3(SHORT_OFF_TIME_MODE) 0
set PROFILE_3(SHORT_ONDELAY_MODE) 0
set PROFILE_3(SHORT_ONDELAY_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_ONDELAY_TIME_FACTOR) {0 range 0 - 31}
set PROFILE_3(SHORT_ON_LEVEL) {1.0 range 0.0 - 1.005}
set PROFILE_3(SHORT_ON_MIN_LEVEL) {0.1 range 0.0 - 1.0}
set PROFILE_3(SHORT_ON_TIME_BASE) {7 range 0 - 7}
set PROFILE_3(SHORT_ON_TIME_FACTOR) {31 range 0 - 31}
set PROFILE_3(SHORT_ON_TIME_MODE) 0
set PROFILE_3(SHORT_OUTPUT_BEHAVIOUR) {7 range 0 - 7}
set PROFILE_3(SHORT_OPTICAL_SIGNAL_COLOR) {7 range 0 - 7}
set PROFILE_3(SHORT_OPTICAL_SIGNAL_OFF_COLOR) {7 range 0 - 7}
set PROFILE_3(SHORT_OPTICAL_SIGNAL_BEHAVIOUR) {1 range 0 - 12}
set PROFILE_3(SHORT_OPTICAL_SIGNAL_OFF_BEHAVIOUR) {1 range 0 - 12}
set PROFILE_3(SHORT_PROFILE_ACTION_TYPE) 1
set PROFILE_3(SHORT_RAMPOFF_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_RAMPOFF_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_3(SHORT_RAMPON_TIME_BASE) {0 range 0 - 7}
set PROFILE_3(SHORT_RAMPON_TIME_FACTOR) {5 range 0 - 31}
set PROFILE_3(SHORT_RAMP_START_STEP) 0.050000
set PROFILE_3(UI_DESCRIPTION)  "Bei ausgew&auml;hlten Kontaktzustandswechseln wird der Schalter f&uuml;r eine bestimmte Zeit eingeschaltet."
set PROFILE_3(UI_TEMPLATE)    $PROFILE_3(UI_DESCRIPTION)
set PROFILE_3(UI_HINT)  3

#set SUBSET_1(NAME)          "Offen-Ein/Zu-Aus"
set SUBSET_1(NAME)          "\${subset_1}"
set SUBSET_1(SUBSET_OPTION_VALUE)  1
set SUBSET_1(SHORT_CT_OFF)      0
set SUBSET_1(SHORT_CT_OFFDELAY)    0
set SUBSET_1(SHORT_CT_ON)      2
set SUBSET_1(SHORT_CT_ONDELAY)    2
set SUBSET_1(SHORT_CT_RAMPOFF)    0
set SUBSET_1(SHORT_CT_RAMPON)    2
set SUBSET_1(SHORT_JT_OFF)      1
set SUBSET_1(SHORT_JT_OFFDELAY)    3
set SUBSET_1(SHORT_JT_ON)      4
set SUBSET_1(SHORT_JT_ONDELAY)    6
set SUBSET_1(SHORT_JT_RAMPOFF)    2
set SUBSET_1(SHORT_JT_RAMPON)    5


#set SUBSET_2(NAME)          "Offen-Aus/Zu-Ein"
set SUBSET_2(NAME)          "\${subset_2}"
set SUBSET_2(SUBSET_OPTION_VALUE)  2
set SUBSET_2(SHORT_CT_OFF)      2
set SUBSET_2(SHORT_CT_OFFDELAY)    2
set SUBSET_2(SHORT_CT_ON)      0
set SUBSET_2(SHORT_CT_ONDELAY)    0
set SUBSET_2(SHORT_CT_RAMPOFF)    0
set SUBSET_2(SHORT_CT_RAMPON)    2
set SUBSET_2(SHORT_JT_OFF)      1
set SUBSET_2(SHORT_JT_OFFDELAY)    3
set SUBSET_2(SHORT_JT_ON)      4
set SUBSET_2(SHORT_JT_ONDELAY)    0
set SUBSET_2(SHORT_JT_RAMPOFF)    2
set SUBSET_2(SHORT_JT_RAMPON)    0


#set SUBSET_3(NAME)          "Schließen"
set SUBSET_3(NAME)          "\${subset_3}"
set SUBSET_3(SUBSET_OPTION_VALUE)  3
set SUBSET_3(SHORT_COND_VALUE_LO)  50
set SUBSET_3(SHORT_CT_OFF)      2
set SUBSET_3(SHORT_CT_OFFDELAY)    2
set SUBSET_3(SHORT_CT_ON)      2
set SUBSET_3(SHORT_CT_ONDELAY)    2
set SUBSET_3(SHORT_CT_RAMPOFF)    2
set SUBSET_3(SHORT_CT_RAMPON)    2
set SUBSET_3(SHORT_JT_OFF)      1
set SUBSET_3(SHORT_JT_OFFDELAY)    3
set SUBSET_3(SHORT_JT_ON)      0
set SUBSET_3(SHORT_JT_ONDELAY)    0
set SUBSET_3(SHORT_JT_RAMPOFF)    2
set SUBSET_3(SHORT_JT_RAMPON)    0


#set SUBSET_4(NAME)          "Kippen"
set SUBSET_4(NAME)          "\${subset_4}"
set SUBSET_4(SUBSET_OPTION_VALUE)  4
set SUBSET_4(SHORT_COND_VALUE_LO)   99
set SUBSET_4(SHORT_COND_VALUE_HI)   199
set SUBSET_4(SHORT_CT_OFF)      4
set SUBSET_4(SHORT_CT_OFFDELAY)    4
set SUBSET_4(SHORT_CT_ON)      4
set SUBSET_4(SHORT_CT_ONDELAY)    4
set SUBSET_4(SHORT_CT_RAMPOFF)    4
set SUBSET_4(SHORT_CT_RAMPON)    4
set SUBSET_4(SHORT_JT_OFF)      1
set SUBSET_4(SHORT_JT_OFFDELAY)    3
set SUBSET_4(SHORT_JT_ON)      0
set SUBSET_4(SHORT_JT_ONDELAY)    0
set SUBSET_4(SHORT_JT_RAMPOFF)    2
set SUBSET_4(SHORT_JT_RAMPON)    0



#set SUBSET_5(NAME)          "ganz Öffnen"
set SUBSET_5(NAME)          "\${subset_5}"
set SUBSET_5(SUBSET_OPTION_VALUE)  5
set SUBSET_5(SHORT_COND_VALUE_LO)   101
set SUBSET_5(SHORT_CT_OFF)      0
set SUBSET_5(SHORT_CT_OFFDELAY)    0
set SUBSET_5(SHORT_CT_ON)      0
set SUBSET_5(SHORT_CT_ONDELAY)    0
set SUBSET_5(SHORT_CT_RAMPOFF)    0
set SUBSET_5(SHORT_CT_RAMPON)    0
set SUBSET_5(SHORT_JT_OFF)      1
set SUBSET_5(SHORT_JT_OFFDELAY)    3
set SUBSET_5(SHORT_JT_ON)      0
set SUBSET_5(SHORT_JT_ONDELAY)    0
set SUBSET_5(SHORT_JT_RAMPOFF)    2
set SUBSET_5(SHORT_JT_RAMPON)    0


#set SUBSET_6(NAME)          "Kippen oder ganz Öffnen"
set SUBSET_6(NAME)          "\${subset_6}"
set SUBSET_6(SUBSET_OPTION_VALUE)  6
set SUBSET_6(SHORT_COND_VALUE_LO)  99
set SUBSET_6(SHORT_CT_OFF)      0
set SUBSET_6(SHORT_CT_OFFDELAY)    0
set SUBSET_6(SHORT_CT_ON)      0
set SUBSET_6(SHORT_CT_ONDELAY)    0
set SUBSET_6(SHORT_CT_RAMPOFF)    0
set SUBSET_6(SHORT_CT_RAMPON)    0
set SUBSET_6(SHORT_JT_OFF)      1
set SUBSET_6(SHORT_JT_OFFDELAY)    3
set SUBSET_6(SHORT_JT_ON)      0
set SUBSET_6(SHORT_JT_ONDELAY)    0
set SUBSET_6(SHORT_JT_RAMPOFF)    2
set SUBSET_6(SHORT_JT_RAMPON)    0


#set SUBSET_7(NAME)          "jede Änderung"
set SUBSET_7(NAME)          "\${subset_7}"
set SUBSET_7(SUBSET_OPTION_VALUE)  7
set SUBSET_7(SHORT_COND_VALUE_HI)  201
set SUBSET_7(SHORT_CT_OFF)      3
set SUBSET_7(SHORT_CT_OFFDELAY)    3
set SUBSET_7(SHORT_CT_ON)      3
set SUBSET_7(SHORT_CT_ONDELAY)   3
set SUBSET_7(SHORT_CT_RAMPOFF)    3
set SUBSET_7(SHORT_CT_RAMPON)    3
set SUBSET_7(SHORT_JT_OFF)      1
set SUBSET_7(SHORT_JT_OFFDELAY)    3
set SUBSET_7(SHORT_JT_ON)      0
set SUBSET_7(SHORT_JT_ONDELAY)    0
set SUBSET_7(SHORT_JT_RAMPOFF)    2
set SUBSET_7(SHORT_JT_RAMPON)    0

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  
  global dev_descr_sender dev_descr_receiver  
  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps      
  upvar $pps_descr    ps_descr

  set ch $dev_descr_sender(INDEX)
  set isBSL20 false

  foreach pro [array names PROFILES_MAP] {
    upvar PROFILE_$pro PROFILE_$pro
  }

  set Fw [getReceiverFw]
  set fwMajor [lindex $Fw 0]
  # set fwMinor [lindex $Fw 1]
  # set fwPatch [lindex $Fw 2]

  if {($dev_descr_receiver(PARENT_TYPE)  == "HmIP-BSL") && ($fwMajor >= 2)} {
    set isBSL20 true
  }

  set cur_profile [get_cur_profile2 ps PROFILES_MAP PROFILE_TMP $peer_type]
  
  #global SUBSETS
  set name "x"
  set i 1
  while {$name != ""} {
    upvar SUBSET_$i SUBSET_$i
    array set subset [array get SUBSET_$i]
    set name ""
    catch {set name $subset(NAME)}
    array_clear subset
    incr i
  }

#  die Texte der Platzhalter einlesen
  puts "<script type=\"text/javascript\">getLangInfo('$dev_descr_sender(TYPE)', '$dev_descr_receiver(TYPE)');</script>"
  puts "<script type=\"text/javascript\">getLangInfo_Special('HmIP_DEVICES.txt');</script>"

  set prn 0
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) [cmd_link_paramset2 $iface $address ps_descr ps "LINK" ${special_input_id}_$prn]
  append HTML_PARAMS(separate_$prn) "</textarea></div>"

#1
  incr prn
  set pref 1
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  append HTML_PARAMS(separate_$prn) "<tr><td>\${SWITCH_DIR}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_1 SUBSET_2} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn ]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  
  incr pref
  append HTML_PARAMS(separate_$prn)  "<tr><td>\${DEF_OPEN}</td><td>"  
  array_clear options
  set options(99)  "\${def_open_a}"
  set options(101) "\${def_open_b}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_COND_VALUE_LO separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_COND_VALUE_LO]
  append HTML_PARAMS(separate_$prn) "</td></tr>"
  
  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  if {$isBSL20} {
    append HTML_PARAMS(separate_$prn) "[getHorizontalLine]"
  }

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  if {[info exists ps(SHORT_ON_MIN_LEVEL)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_MIN_LEVEL}</td><td>"
    option DIM_LEVELwoLastValue
    append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_MIN_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_MIN_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_MIN_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"
  }

  set param SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

  set param SHORT_PROFILE_REPETITIONS
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getRepetitionSelector PROFILE_$prn ${special_input_id} $param]

    # OFF_TIME
    append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn blink0 $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"
  }

  set param SHORT_OPTICAL_SIGNAL_COLOR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

  set param SHORT_OPTICAL_SIGNAL_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectBehaviourElement PROFILE_$prn ${special_input_id} $param]
  }

  if {$isBSL20} {
    append HTML_PARAMS(separate_$prn) "[getHorizontalLine]"

    incr pref
    append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_LEVEL}</td><td>"
    option DIM_OFFLEVEL
    append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_OFF_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    set param SHORT_OPTICAL_SIGNAL_OFF_COLOR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
    }

    set param SHORT_OPTICAL_SIGNAL_OFF_BEHAVIOUR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectBehaviourElement PROFILE_$prn ${special_input_id} $param]
    }

    append HTML_PARAMS(separate_$prn) "[getHorizontalLine]"
  }

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

#2
  incr prn
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  set pref 1
  append HTML_PARAMS(separate_$prn) "<tr><td>\${CHANGE_SIGNAL}&nbsp;\${at}</td><td>"
  append HTML_PARAMS(separate_$prn) [subset2combobox {SUBSET_3 SUBSET_4 SUBSET_5 SUBSET_6 SUBSET_7} subset_$prn\_$pref separate_${special_input_id}_$prn\_$pref PROFILE_$prn]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  if {$isBSL20} {
    append HTML_PARAMS(separate_$prn) "[getHorizontalLine]"
  }

  # OFFDELAY
  # append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # OFF_TIME
  # append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  if {[info exists ps(SHORT_ON_MIN_LEVEL)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_MIN_LEVEL}</td><td>"
    option DIM_LEVELwoLastValue
    append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_MIN_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_MIN_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_MIN_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"
  }

  set param SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

  set param SHORT_PROFILE_REPETITIONS
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getRepetitionSelector PROFILE_$prn ${special_input_id} $param]

    # OFF_TIME
    append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn blink0 $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"
  }

  set param SHORT_OPTICAL_SIGNAL_COLOR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

  set param SHORT_OPTICAL_SIGNAL_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectBehaviourElement PROFILE_$prn ${special_input_id} $param]
  }

  if {$isBSL20} {
    append HTML_PARAMS(separate_$prn) "[getHorizontalLine]"

    incr pref
    append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_LEVEL}</td><td>"
    option DIM_OFFLEVEL
    append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_OFF_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    set param SHORT_OPTICAL_SIGNAL_OFF_COLOR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
    }

    set param SHORT_OPTICAL_SIGNAL_OFF_BEHAVIOUR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectBehaviourElement PROFILE_$prn ${special_input_id} $param]
    }

    append HTML_PARAMS(separate_$prn) "[getHorizontalLine]"
  }

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

  #3
  incr prn
  set pref 0
  if {$cur_profile == $prn} then {array set PROFILE_$prn [array get ps]}
  append HTML_PARAMS(separate_$prn) "<div id=\"param_$prn\"><textarea id=\"profile_$prn\" style=\"display:none\">"
  append HTML_PARAMS(separate_$prn) "\${description_$prn}"
  append HTML_PARAMS(separate_$prn) "<table class=\"ProfileTbl\">"

  incr pref
  append HTML_PARAMS(separate_$prn)  "<tr><td>\${DEF_OPEN}</td><td>"
  array_clear options
  set options(99)  "\${def_open_a}"
  set options(101) "\${def_open_b}"
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_COND_VALUE_LO separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_COND_VALUE_LO]
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  # ONDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ONDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_ONDELAY_TIME TIMEBASE_LONG]"

  # ON_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector ON_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_ON_TIME TIMEBASE_LONG]"

  if {$isBSL20} {
    append HTML_PARAMS(separate_$prn) "[getHorizontalLine]"
  }

  incr pref
  append HTML_PARAMS(separate_$prn) "<tr><td>\${ON_LEVEL}</td><td>"
  option DIM_ONLEVEL
  append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_ON_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_ON_LEVEL "onchange=\"ActivateFreePercent(\$('${special_input_id}_profiles'),$pref);\""]
  EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_ON_LEVEL
  append HTML_PARAMS(separate_$prn) "</td></tr>"

  set param SHORT_OUTPUT_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

  set param SHORT_OPTICAL_SIGNAL_COLOR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
  }

  set param SHORT_OPTICAL_SIGNAL_BEHAVIOUR
  if {[info exists ps($param)] == 1} {
    incr pref
    append HTML_PARAMS(separate_$prn) [getSelectBehaviourElement PROFILE_$prn ${special_input_id} $param]
  }

  if {$isBSL20} {
    append HTML_PARAMS(separate_$prn) "[getHorizontalLine]"

    incr pref
    append HTML_PARAMS(separate_$prn) "<tr><td>\${OFF_LEVEL}</td><td>"
    option DIM_OFFLEVEL
    append HTML_PARAMS(separate_$prn) [get_ComboBox options SHORT_OFF_LEVEL separate_${special_input_id}_$prn\_$pref PROFILE_$prn SHORT_OFF_LEVEL "onchange=\"ActivateFreePercent4InternalKey(\$('${special_input_id}_profiles'),$pref);\""]
    EnterPercent $prn $pref ${special_input_id} ps_descr SHORT_OFF_LEVEL
    append HTML_PARAMS(separate_$prn) "</td></tr>"

    set param SHORT_OPTICAL_SIGNAL_OFF_COLOR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectColorElement PROFILE_$prn ${special_input_id} $param]
    }

    set param SHORT_OPTICAL_SIGNAL_OFF_BEHAVIOUR
    if {[info exists ps($param)] == 1} {
      incr pref
      append HTML_PARAMS(separate_$prn) [getSelectBehaviourElement PROFILE_$prn ${special_input_id} $param]
    }

    append HTML_PARAMS(separate_$prn) "[getHorizontalLine]"
  }

  # OFFDELAY
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFFDELAY_TIME_FACTOR_DESCR ps PROFILE_$prn delay $prn $special_input_id SHORT_OFFDELAY_TIME TIMEBASE_LONG]"

  # OFF_TIME
  append HTML_PARAMS(separate_$prn) "[getTimeSelector OFF_TIME_FACTOR_DESCR ps PROFILE_$prn timeOnOff $prn $special_input_id SHORT_OFF_TIME TIMEBASE_LONG]"

  append HTML_PARAMS(separate_$prn) "</table></textarea></div>"

}

constructor
