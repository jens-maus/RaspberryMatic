#!/bin/tclsh

#Kanal-EasyMode!

source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipChannelConfigDialogs.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipDSTPanel.tcl]
source [file join /www/config/easymodes/em_common.tcl]

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr
  
  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr

  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
    set chn 0
    set prn 1

    append HTML_PARAMS(separate_1) "[getMaintenance $chn ps psDescr]"

    incr prn
    append HTML_PARAMS(separate_1) "[getDSTPanel ps psDescr]"

  append HTML_PARAMS(separate_1) "</table>"


}

constructor
