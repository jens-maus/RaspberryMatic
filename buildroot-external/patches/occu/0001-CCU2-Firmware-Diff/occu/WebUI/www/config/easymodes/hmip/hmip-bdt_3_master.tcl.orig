#!/bin/tclsh

source [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {
  global env iface_url psDescr
  
  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  set chn [getChannel $special_input_id]

  set cur_profile $chn

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

    set prn 1
    append HTML_PARAMS(separate_1) "[getDimmerTransmitter $chn ps psDescr]"

  append HTML_PARAMS(separate_1) "</table>"
}

constructor

