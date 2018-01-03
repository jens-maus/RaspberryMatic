#!/bin/tclsh

source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipWeeklyProgram.tcl]
source [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr
  
  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    append HTML_PARAMS(separate_1) [getWeeklyProgram $address ps]
  append HTML_PARAMS(separate_1) "</table>"
}
constructor
