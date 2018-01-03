#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmip_helper.tcl]

proc getMinValue {param} {
  global psDescr
  array_clear param_descr
  set param [trimParam $param]
  array set param_descr $psDescr($param)
  set min [format {%1.1f} $param_descr(MIN)]
  return "$min"
}

proc getMaxValue {param} {
  global psDescr
  array_clear param_descr
  set param [trimParam $param]
  array set param_descr $psDescr($param)
  set max [format {%1.1f} $param_descr(MAX)]
  return "$max"
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

proc getDescription {param} {
  set result $param
  set desc(EVENT_DELAY_UNIT) "stringTableEventDelayUnit"
  set desc(EVENT_RANDOMTIME_UNIT) "stringTableEventRandomTimeUnit"
  if {[catch {set result $desc($param)}]} {
   return $result
  }
  return $result
}

proc trimParam {param} {
  set s [string trimleft $param ']
  set s [string trimright $s ']
  return $s
}

proc getHorizontalLine {} {
  return "<tr><td colspan=\"2\"><hr></td></tr>"
}

proc getTimeUnitComboBox {param value chn prn special_input_id} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'
  #set s "<tr id=\"timeBase\_$prn\_$pref\" class=\"hidden\">"

  set s "<tr id=\"timeBase_$chn\_$prn\" class=\"hidden\">"
    append s "<td>\${[getDescription $param]}</td>"
    append s "<td>"
      append s "<select id=$elemId name=$param>"
        append s "<option value='0'>\${optionUnit100MS}</option>"
        append s "<option value='1'>\${optionUnitS}</option>"
        append s "<option value='2'>\${optionUnitM}</option>"
        append s "<option value='3'>\${optionUnitH}</option>"
      append s "</select>"
    append s "</td>"
  append s "</tr>"
  append s "<script type=\"text/javascript\">"
    append s "jQuery($j_elemId).val('$value');"
  append s "</script>"
  return $s
}

proc getTextField {param value inputId} {
  set elemId '$inputId'
  # Limit float to 2 decimal places
  if {[llength [split $value "."]] == 2} {
    set value [format {%1.2f} $value]
  }
  set s "<input id=$elemId type=\"text\" size=\"5\" value=$value name=$param onblur=\"ProofAndSetValue(this.id, this.id, [getMinValue $param], [getMaxValue $param], 1)\"/>"
  return $s
}

catch {unset internalKey}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr

  #upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  #upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr    ps_descr

  set specialID "[lindex [split $special_input_id _] 0]"

  set chn [lindex [split $special_input_id _] 1]

  array set psDescr [xmlrpc $iface_url($iface) getParamsetDescription [list string $address] [list string MASTER]]

    foreach val [array names psDescr] {
     #puts "$val: $psDescr($val)\n"
    }


  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    set prn 1
    append HTML_PARAMS(separate_1) "<tr>"
    append HTML_PARAMS(separate_1) "<td>\${stringTableEventDelay}</td>"
    append HTML_PARAMS(separate_1) [getComboBox $chn $prn "$specialID" "delayShort"]
    append HTML_PARAMS(separate_1) "</tr>"

    set param EVENT_DELAY_UNIT
    append HTML_PARAMS(separate_1) [getTimeUnitComboBox $param $ps($param) $chn $prn $special_input_id]

    # 2
    incr prn
    set param EVENT_DELAY_VALUE
    append HTML_PARAMS(separate_1) "<tr id=\"timeFactor_$chn\_$prn\" class=\"hidden\">"
      append HTML_PARAMS(separate_1) "<td>\${stringTableEventDelayValue}</td>"
      append HTML_PARAMS(separate_1) "<td>[getTextField '$param' $ps($param) separate_${special_input_id}_$prn]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"
    append HTML_PARAMS(separate_1) "<tr id=\"space_$chn\_$prn\" class=\"hidden\"><td><br/></td></tr>"
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">setTimeout(function() {setCurrentDelayShortOption($chn, [expr $prn - 1], '$specialID');}, 100)</script>"
  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">translatePage();</script>"

    #3
   incr prn
   append HTML_PARAMS(separate_1) "<tr><td>"
      array_clear options
      set options(0) "\${stringTableShutterContactMsgPosA2}"
      set options(1) "\${stringTableShutterContactMsgPosA1}"
      set options(2) "\${stringTableShutterContactMsgPosA3}"
      append HTML_PARAMS(separate_1) "<tr><td>\${stringTableShutterContactHmIPMsgPosA0}</td><td>"
      append HTML_PARAMS(separate_1) [get_ComboBox options MSG_FOR_POS_A separate_${special_input_id}_$prn ps MSG_FOR_POS_A]
    append HTML_PARAMS(separate_1) "</td></tr>"

    #4
   incr prn
   append HTML_PARAMS(separate_1) "<tr><td>"
      array_clear options
      set options(0) "\${stringTableShutterContactMsgPosA2}"
      set options(1) "\${stringTableShutterContactMsgPosA1}"
      set options(2) "\${stringTableShutterContactMsgPosA3}"
      append HTML_PARAMS(separate_1) "<tr><td>\${stringTableShutterContactHmIPMsgPosB0}</td><td>"
      append HTML_PARAMS(separate_1) [get_ComboBox options MSG_FOR_POS_B separate_${special_input_id}_$prn ps MSG_FOR_POS_B]
    append HTML_PARAMS(separate_1) "</td></tr>"

}

constructor


