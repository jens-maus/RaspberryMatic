#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]

proc getUnit {psDescr param} {
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set unit $param_descr(UNIT)
  return "$unit"
}

proc getMinMaxValueDescr {psDescr param} {
	upvar psDescr descr
  array_clear param_descr
	array set param_descr $descr($param)
  set min $param_descr(MIN)
  set max $param_descr(MAX)

  # Limit float to 3 decimal places
  if {[llength [split $min "."]] == 2} {
    set min [format {%1.3f} $min]
    set max [format {%1.3f} $max]
  }
  return "($min - $max)"
}

proc getTextField {psDescr type param value inputId} {
  upvar psDescr descr
  array_clear param_descr
  array set param_descr $descr($param)

  set elemId '$inputId'

  set s "<input id=$elemId type=\"text\" size=\"5\" value=\"$value\" name=\"$param\" onblur=\"ProofAndSetValue($elemId, $elemId,$param_descr(MIN), $param_descr(MAX), parseFloat(1))\"/>"
  return $s
}

proc getComboBox {param prn special_input_id} {
	  global psDescr
	  upvar ps ps
	  set CHANNEL "CHANNEL"

	  array_clear options
    set options(0) "\${PowerMeterIGLSensorGAS}"
    set options(1) "\${PowerMeterIGLSensorIR}"
    set options(2) "\${PowerMeterIGLSensorLED}"
    set options(3) "\${PowerMeterIGLSensorUnknown}"

    append s "<td>"
    append s "[get_ComboBox options $param separate_${special_input_id}_$prn ps $param]"
    append s "</td>"
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

	puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/HM_ES_TX_WM.js')</script>"

  set CHANNEL "CHANNEL"

  array set psDescr [xmlrpc $iface_url($iface) getParamsetDescription [list string $address] [list string MASTER]]

	append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

      set prn 1
      set param METER_TYPE
      append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1)  "<td>\${PowerMeterIGLMeterType}</td>"
      append HTML_PARAMS(separate_1) [getComboBox $param $prn $special_input_id]
      append HTML_PARAMS(separate_1) "</tr>"

      incr prn
      set param METER_CONSTANT_GAS
      append HTML_PARAMS(separate_1) "<tr name='sensor_0' class='hidden'>"
        append HTML_PARAMS(separate_1) "<td>\${PowerMeterIGLConstantGas}</td>"
        append HTML_PARAMS(separate_1) "<td>[getTextField psDescr $CHANNEL $param [format "%.3f" $ps($param)] separate_${special_input_id}_$prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

      incr prn
      set param METER_CONSTANT_IR
    	append HTML_PARAMS(separate_1) "<tr name='sensor_1' class='hidden'>"
    	  append HTML_PARAMS(separate_1) "<td>\${PowerMeterIGLConstantIR}</td>"
	      append HTML_PARAMS(separate_1) "<td>[getTextField psDescr $CHANNEL $param $ps($param) separate_${special_input_id}_$prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
	    append HTML_PARAMS(separate_1) "</tr>"

      incr prn
      set param METER_SENSIBILITY_IR
    	append HTML_PARAMS(separate_1) "<tr name='sensor_1' class='hidden'>"
    	  append HTML_PARAMS(separate_1) "<td>\${PowerMeterIGLSensibilityIR}</td>"
	      append HTML_PARAMS(separate_1) "<td>[getTextField psDescr $CHANNEL $param $ps($param) separate_${special_input_id}_$prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
	    append HTML_PARAMS(separate_1) "</tr>"

      incr prn
      set param METER_CONSTANT_LED
      append HTML_PARAMS(separate_1) "<tr name='sensor_2' class='hidden'>"
        append HTML_PARAMS(separate_1) "<td>\${PowerMeterIGLConstantLed}</td>"
        append HTML_PARAMS(separate_1) "<td>[getTextField psDescr $CHANNEL $param $ps($param) separate_${special_input_id}_$prn]&nbsp;[getUnit psDescr $param]&nbsp;[getMinMaxValueDescr psDescr $param]</td>"
      append HTML_PARAMS(separate_1) "</tr>"

  append HTML_PARAMS(separate_1) "</table>"

  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "function showParameter() \{"
      append HTML_PARAMS(separate_1) "var meterType = jQuery('#separate_${special_input_id}_1').val();"
      append HTML_PARAMS(separate_1) " jQuery('tr.hidden').hide();"
      append HTML_PARAMS(separate_1) "jQuery(\"\[name='sensor_\" + meterType+ \"'\]\").show();"
      append HTML_PARAMS(separate_1) "if(meterType == 3) \{"
      append HTML_PARAMS(separate_1) " jQuery('tr.hidden').show();"
      append HTML_PARAMS(separate_1) "\}"
    append HTML_PARAMS(separate_1) "\};"
    append HTML_PARAMS(separate_1) "showParameter();"
    append HTML_PARAMS(separate_1) "jQuery('#separate_${special_input_id}_1').bind('change',function() \{"
    append HTML_PARAMS(separate_1) "showParameter();"
    append HTML_PARAMS(separate_1) "\});"
  append HTML_PARAMS(separate_1) "</script>"
}

constructor


