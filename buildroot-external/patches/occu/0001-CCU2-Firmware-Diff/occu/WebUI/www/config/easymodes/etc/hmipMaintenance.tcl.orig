source [file join $env(DOCUMENT_ROOT) config/easymodes/etc/uiElements.tcl]

proc getMaintenance {chn p descr} {
  upvar $p ps
  upvar $descr psDescr
  upvar prn prn

  set html ""

  set param CYCLIC_INFO_MSG
  append html "<tr>"
    append html "<td>\${stringTableCyclicInfoMsg}</td>"
    append html  "<td>[getCheckBox '$param' $ps($param) $chn '$prn\_tmp' "onchange=\"setCyclicInfoMsg(this, '$chn', '$prn');\""]</td>"
    append html  "<td class=\"hidden\">[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn
  set param CYCLIC_INFO_MSG_DIS
  append html "<tr>"
    append html "<td>\${stringTableCyclicInfoMsgDis}</td>"
    append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn
  set param CYCLIC_INFO_MSG_DIS_UNCHANGED
  append html "<tr>"
    append html "<td>\${stringTableCyclicInfoMsgDisUnChanged}</td>"
    append html  "<td>[getTextField $param $ps($param) $chn $prn]&nbsp;[getMinMaxValueDescr $param]</td>"
  append html "</tr>"

  incr prn
  set param LOCAL_RESET_DISABLED
  append html "<tr>"
    append html "<td>\${stringTableLocalResetDisable}</td>"
    append html  "<td>[getCheckBox '$param' $ps($param) $chn $prn]</td>"
  append html "</tr>"

  append html "<script type=\"text/javascript\">"
    append html "setCyclicInfoMsg = function(elm, chn, prn) \{"
      append html " var value = (jQuery(elm).prop('checked')) ? 1 : 0; "
      # don`t use jQuery - the dirty flag will not be recognized
      append html " document.getElementById('separate_CHANNEL_' + chn + '_' + prn ).value = value; "
    append html "\};"
  append html "</script>"

  return $html
}