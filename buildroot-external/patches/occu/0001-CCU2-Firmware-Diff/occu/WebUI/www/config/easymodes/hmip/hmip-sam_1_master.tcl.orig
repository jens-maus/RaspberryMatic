#!/bin/tclsh
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipChannelConfigDialogs.tcl]
source [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global env iface_url psDescr
  
  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/MASTER_LANG/MOTION_DETECTOR.js');</script>"

  set chn [getChannel $special_input_id]

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    set prn 1
    append HTML_PARAMS(separate_1) "[getAccelerationTransceiver $chn ps psDescr]"
  append HTML_PARAMS(separate_1) "</table>"
}

constructor


