#!/bin/tclsh

sourceOnce [file join $env(DOCUMENT_ROOT) config/easymodes/etc/hmipChannelConfigDialogs.tcl]
sourceOnce [file join /www/config/easymodes/em_common.tcl]

proc getWGTModeSelector {address wgtMode} {
  set html ""

  if {$wgtMode == "modeBWTH"} {
    set selBWTH selected
    set selSWITCH ''
  } else {
    set selBWTH ''
    set selSWITCH selected
  }

  append html "<tr>"
    append html "<td>\${lblMode}</td>"
    append html "<td>"
      ## The element name CHANNEL_OPERATION_MODE is not the parameter name. It's necessary for selecting the element via jQuery in the function showHintPrgLink()
      append html "<select id='wgtModeSelector' name='CHANNEL_OPERATION_MODE' onchange='wgtSelectMode(\"$address\",this.value);'>"
        append html "<option value='modeBWTH' $selBWTH>\${modeBWTH}</option>"
        append html "<option value='modeSWITCH' $selSWITCH>\${modeSWITCH}</option>"
      append html "</select>"
    append html "</td>"
  append html "</tr>"

  append html "<script type=\"text/javascript\">"
    append html "wgtSelectMode = function(chnAddress, val) \{"
      append html "var arChnAddress = chnAddress.split(':');"

      append html "var dev = DeviceList.getDeviceByAddress(chnAddress.split(':')\[0\]),"
      append html "virtChannels = \[\];"

      append html "virtChannels.push(DeviceList.getChannelByAddress(chnAddress));"
      append html "virtChannels.push(DeviceList.getChannelByAddress(arChnAddress\[0\]+':'+((parseInt(arChnAddress\[1\])) + 1)));"
      append html "virtChannels.push(DeviceList.getChannelByAddress(arChnAddress\[0\]+':'+((parseInt(arChnAddress\[1\])) + 2)));"

      append html "for(var i = 0; i <=2; i++) \{"
        append html "homematic('Interface.setMetadata', {'objectId': virtChannels\[i\].id, 'dataId': 'channelMode', 'value': val});"
        append html " virtChannels\[i\].channelMode = val;"
      append html "\}"

      append html "DeviceListPage.showConfiguration(false, 'DEVICE', dev.id);"

    append html "\};"
  append html "</script>"

  return $html
}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  global env iface_url psDescr dev_descr wgtChnMode
  upvar HTML_PARAMS   HTML_PARAMS
  upvar $pps          ps
  upvar $pps_descr    psDescr


  set url $iface_url($iface)

  set chn [getChannel $special_input_id]
  set devType $dev_descr(TYPE)

  set isWGT [string first HmIP-WGT $devType]
  set wgtFirstVirtCh false
  set wgtChnMode "--"

  if {($isWGT != -1) && ($chn == 4)} {set wgtFirstVirtCh true}

  # HmIP-WGT(-A) Get the selected mode (modeBWTH or modeSWITCH) of the first virtual switch actor (wtc chn. 4)
  # The next virtual switch actor channels are using the global variable wgtChnMode to determine their mode.
  if {[string first HmIP-WGT $devType] != -1} {
    catch {
      set isecmd "object chn = dom.GetObject('$devType $address');Write(chn.MetaData('channelMode'));"
      array set chnData [rega_script $isecmd]

      if {$chnData(STDOUT) != "null"} {
        set wgtChnMode $chnData(STDOUT)
      }
    }
  }

  if {$isWGT != -1} {
    append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl j_multiMode_$chn\" data=\"hmip-wgt\">"
  } else {
    append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"
  }

    if {($isWGT == -1) || (($isWGT != -1)  && ($wgtChnMode != "modeBWTH"))} {
      if {$wgtFirstVirtCh} {append HTML_PARAMS(separate_1) "[getWGTModeSelector $address $wgtChnMode]"}
      append HTML_PARAMS(separate_1) "[getSwitchVirtualReceiver $chn ps psDescr]"
    } else {
      if {$wgtFirstVirtCh} {
        append HTML_PARAMS(separate_1) "[getWGTModeSelector $address $wgtChnMode]"
      } else {
        append HTML_PARAMS(separate_1) "[getNoParametersToSet]"
      }


    }
  append HTML_PARAMS(separate_1) "</table>"
}

constructor