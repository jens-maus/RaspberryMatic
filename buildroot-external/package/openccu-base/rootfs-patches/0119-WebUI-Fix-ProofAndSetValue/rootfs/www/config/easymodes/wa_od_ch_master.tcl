#!/bin/tclsh

# Kapazitive Füllstandsanzeige

source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]
source [file join $env(DOCUMENT_ROOT) config/easymodes/EnterFreeValue.tcl]


proc getMinValue {ps_descr param} {
  upvar ps_descr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set min $param_descr(MIN)

  # Limit float to 2 decimal places
  if {$param == "LED_ONTIME"} {
    set min [format {%1.2f} $min]
  }
  return "$min"
}

proc getMaxValue {ps_descr param} {
  upvar ps_descr descr
  array_clear param_descr
  array set param_descr $descr($param)
  set max $param_descr(MAX)

  # Limit float to 2 decimal places
  if {$param == "LED_ONTIME"} {
    set max [format {%1.2f} $max]
  }
  return "$max"
}

proc getMinMaxValueDescr {ps_descr param} {
	upvar ps_descr descr 
  array_clear param_descr
	array set param_descr $descr($param)
	set min $param_descr(MIN)
	set max $param_descr(MAX)

  if {$param == "LED_ONTIME"} {
    set min [format {%1.2f} $min]
    set max [format {%1.2f} $max]
  }

  return "($min - $max)" 
}

proc getUnit {ps_descr param} {
  upvar ps_descr descr 
  array_clear param_descr
  array set param_descr $descr($param)
  set unit $param_descr(UNIT)
  return "$unit"
}

# Runded die Nachkommstelle auf 0 oder 5
proc setDecimalPlaces {val} {
  set splittedVal [split $val .]
  # Vorkommastelle
  set integerPlaces [lindex $splittedVal 0]
  # Nachkommastelle
  set decimalPlaces [lindex $splittedVal 1]
    
  if {$decimalPlaces > 0 && $decimalPlaces < 3 } {
    set decimalPlaces 0
  } elseif {$decimalPlaces >= 3 && $decimalPlaces <= 7} {
    set decimalPlaces 5
  } elseif {$decimalPlaces == 8 || $decimalPlaces == 9 } {
    incr integerPlaces
    set decimalPlaces 0
  }
  set percentVal $integerPlaces
  append percentVal "."
  append percentVal $decimalPlaces
  return $percentVal 
}

proc createPercentField {name val devType loop} {

  set id "'separate_CHANNEL_1_$loop'"
  set idString "id=$id"
  set tmpId "'tmp_1_$loop'" 
  set percentVal 0      
  set checked "checked=\"checked\""
  set disabled ""
   
  if {$val != 0} {
    set percentVal [setDecimalPlaces [format {%1.1f} [expr 100.0 / (200.0/$val)]]]

    if {$val == "255"} {
      set checked ""
      set disabled "disabled=\'disabled\'"
      set percentVal "0"
    }
  }

  set html "<tr>"
    append html "<td class=\"stringtable_value\">$devType|$name</td>"
    append html "<td><input type=\"text\" id=$tmpId value=$percentVal name=\"tmp_$name\" size=\"5\" $disabled onchange=\"setVal(this, \'channel\');\" ></td>"
    append html "<td><input id=\"activateThreshold_$loop\" type=\"checkbox\" $checked onclick=\"setThresholdActiv(this, $tmpId, $id, $val, 'channel')\"> <span id=\"param_$loop\"><textarea id=\"profile_$loop\">\${lblActive}</textarea></span> </td>"
    append html "<td><input type=\"text\" $idString value=\"$val\" name=$name size=\"5\" style=\"display:none\"></td>"
  append html "</tr>"
  return $html
}



proc setSelectedCase {selCase elmID} {
  puts "<script type=\"text/javasscript\">"
    puts "var options = \$\$('select#$elmID option');"
    puts "if \('$selCase' != '1' \) \{"
      puts "var lblFillingLevel = translateKey('lblFillingLevel100');"
      puts "var addOn = \"&nbsp;(\"+ lblFillingLevel+ \"%)\";"

      puts "document.getElementById(\"caseHeightMinMaxB\").style.display = \"inline\";"
      puts "document.getElementById(\"caseHeight\").innerHTML += addOn;"
    puts "\} else \{"
      puts "document.getElementById(\"caseHeightMinMaxA\").style.display = \"inline\";"
    puts "\}"

   puts "options\[$selCase\].selected = true;"
  puts "</script>"
}

proc displayFields {id mode} {
  # mode can be 'show' or 'hide' 
  if {$mode != "hide"} {
    set mode "show"
  }
  puts "<script type=\"text/javasscript\">"
    #puts "\$\$(\".j_custom\").invoke('$mode');"
    puts "\$\$(\"$id\").invoke('$mode');"
  puts "</script>"
}


proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

  puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/CapacitiveFillingLevelSensor.js');</script>"
  puts "<script type=\"text/javascript\">getLangInfo_Special('CAPACITIVE_FILLING_SENSOR.txt');</script>"

  global iface_url

  upvar PROFILES_MAP  PROFILES_MAP
  upvar HTML_PARAMS   HTML_PARAMS
  upvar PROFILE_PNAME PROFILE_PNAME
  upvar $pps          ps
  upvar $pps_descr  ps_descr
  
  set url $iface_url($iface)
  set customActive $ps(USE_CUSTOM)
  set devType "CAPACITIVE_FILLING_LEVEL_SENSOR"
  set selectedCase 0

  set comment {
    foreach val [array names ps] {
      puts "$val: $ps($val)<br/>"
    }
    foreach val [array names ps_descr] {
      puts "$val: $ps_descr($val)<br/>"
    }

    puts "<br/><br/>"
  }


  append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\">"

    append HTML_PARAMS(separate_1) "<tr style=\"visibility:hidden; display:none;\">"
      append HTML_PARAMS(separate_1) "<td>" 
        append HTML_PARAMS(separate_1) "<input id=\"separate_CHANNEL_1_1\" type=\"hidden\" value=\"0\" name=\"UI_HINT\">"
        append HTML_PARAMS(separate_1) "<input id=\"separate_CHANNEL_1_2\" type=\"hidden\" value=\"Expertenprofil\" name=\"UI_DESCRIPTION\">"
      append HTML_PARAMS(separate_1) "</td>" 
    append HTML_PARAMS(separate_1) "</tr>" 

  
    #append HTML_PARAMS(separate_1) "<tr><td><span style=\"color:red\">USER</span></td></tr>"
    
 
    set paramNr 3
    set param "TRANSMIT_TRY_MAX"
    set min [getMinValue ps_descr $param]
    set max [getMaxValue ps_descr $param]
    append HTML_PARAMS(separate_1) "<tr class=\"j_custom\">"
      append HTML_PARAMS(separate_1) "<td class=\"stringtable_value\">$devType|$param</td>"
      append HTML_PARAMS(separate_1) "<td> <input type=\"text\" id=\"separate_CHANNEL_1_$paramNr\" name=\"$param\" value=\"$ps($param)\" onblur=\"ProofAndSetValue('separate_CHANNEL_1_$paramNr', 'separate_CHANNEL_1_$paramNr', parseInt($min), parseInt($max), parseFloat(1));\"> </td>"
      append HTML_PARAMS(separate_1) "<td>[getUnit ps_descr $param] [getMinMaxValueDescr ps_descr $param] </td>"
    append HTML_PARAMS(separate_1) "</tr>"

    incr paramNr
    set param "LED_ONTIME"
    set min [getMinValue ps_descr $param]
    set max [getMaxValue ps_descr $param]
    append HTML_PARAMS(separate_1) "<tr class=\"j_custom\">"
      append HTML_PARAMS(separate_1) "<td class=\"stringtable_value\">$devType|$param</td>"
      append HTML_PARAMS(separate_1) "<td> <input type=\"text\" id=\"separate_CHANNEL_1_$paramNr\" name=\"$param\" value=\"[format {%1.2f} $ps($param)]\" onblur=\"ProofAndSetValue('separate_CHANNEL_1_$paramNr', 'separate_CHANNEL_1_$paramNr', '$min', '$max', parseFloat(1));\"> </td>"
      append HTML_PARAMS(separate_1) "<td>[getUnit ps_descr $param] [getMinMaxValueDescr ps_descr $param] </td>"
    append HTML_PARAMS(separate_1) "</tr>"

    incr paramNr
    set param "WATER_LOWER_THRESHOLD_CH"
    set min [getMinValue ps_descr $param]
    set max [getMaxValue ps_descr $param]
    append HTML_PARAMS(separate_1) [createPercentField $param $ps($param) "$devType" $paramNr]
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">translate('$paramNr', '$special_input_id')</script>"
 
    incr paramNr
    set param "WATER_UPPER_THRESHOLD_CH"
    set min [getMinValue ps_descr $param]
    set max [getMaxValue ps_descr $param]
    append HTML_PARAMS(separate_1) [createPercentField $param $ps($param) "$devType" $paramNr]
    append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">translate('$paramNr', '$special_input_id')</script>"
  
    incr paramNr
    set param "CASE_DESIGN"
    set selectedCase $ps($param)
    set caseSelectorID "'separate_CHANNEL_1_$paramNr'" 
    append HTML_PARAMS(separate_1) "<tr class=\"j_custom\">"
      append HTML_PARAMS(separate_1) "<td class=\"stringtable_value\">$devType|$param</td>"
      append HTML_PARAMS(separate_1) "<td>" 
        append HTML_PARAMS(separate_1) "<select class=\"stringtable_select\" style=\"width:160px;\" id=$caseSelectorID name=\"$param\" onchange=\"caseHasChanged(this)\">"
          append HTML_PARAMS(separate_1) "<option value=\"0\">$devType|CASE_DESIGN=VERTICAL_BARREL</option>" 
          append HTML_PARAMS(separate_1) "<option value=\"1\">$devType|CASE_DESIGN=HORIZONTAL_BARREL</option>" 
          append HTML_PARAMS(separate_1) "<option value=\"2\">$devType|CASE_DESIGN=RECTANGLE</option>" 
        append HTML_PARAMS(separate_1) "</select>"
        setSelectedCase $selectedCase "separate_CHANNEL_1_$paramNr"
      append HTML_PARAMS(separate_1) "</td>"
      append HTML_PARAMS(separate_1) "<td><img src=\"/ise/img/help.png\" style=\"cursor: pointer; width:24px; height:24px;\" onclick=\"showHelpElem('show')\"></td>"
    append HTML_PARAMS(separate_1) "</tr>"
    
    incr paramNr
    set param "CASE_HIGH"
    set min [getMinValue ps_descr $param]
    set max 300
    append HTML_PARAMS(separate_1) "<tr class=\"j_custom j_caseHeight\">"
      append HTML_PARAMS(separate_1) "<td class=\"stringtable_value\" id=\"caseHeight\">$devType|$param</td>"
      append HTML_PARAMS(separate_1) "<td> <input type=\"text\" id=\"separate_CHANNEL_1_$paramNr\" name=\"$param\" value=\"$ps($param)\" onblur=\"ProofValue('separate_CHANNEL_1_$paramNr',parseInt($min), $caseSelectorID, [getMaxValue ps_descr $param]);\"> </td>"
      append HTML_PARAMS(separate_1) "<td>"
        append HTML_PARAMS(separate_1) "<span id=\"caseHeightMinMaxA\" style=\"display:none;\">[getUnit ps_descr $param] [getMinMaxValueDescr ps_descr $param]</span>"
        append HTML_PARAMS(separate_1) "<span id=\"caseHeightMinMaxB\" style=\"display:none;\">[getUnit ps_descr $param] (100 - $max)</span>"
      append HTML_PARAMS(separate_1) "</td>"
    append HTML_PARAMS(separate_1) "</tr>"

    incr paramNr
    set param "CASE_WIDTH"
    set min [getMinValue ps_descr $param]
    set max [getMaxValue ps_descr $param]
    append HTML_PARAMS(separate_1) "<tr class=\"j_custom j_caseWidth\">"
      append HTML_PARAMS(separate_1) "<td class=\"stringtable_value\">$devType|$param</td>"
      append HTML_PARAMS(separate_1) "<td> <input type=\"text\" id=\"separate_CHANNEL_1_$paramNr\" name=\"$param\" value=\"$ps($param)\" onblur=\"ProofAndSetValue('separate_CHANNEL_1_$paramNr','separate_CHANNEL_1_$paramNr', parseInt($min), parseInt($max), parseFloat(1));\"> </td>"
      append HTML_PARAMS(separate_1) "<td>[getUnit ps_descr $param] [getMinMaxValueDescr ps_descr $param] </td>"
    append HTML_PARAMS(separate_1) "</tr>"

    incr paramNr
    set param "CASE_LENGTH"
    set min [getMinValue ps_descr $param]
    set max [getMaxValue ps_descr $param]
    append HTML_PARAMS(separate_1) "<tr class=\"j_custom j_caseLength\">"
      append HTML_PARAMS(separate_1) "<td class=\"stringtable_value\">$devType|$param</td>"
      append HTML_PARAMS(separate_1) "<td> <input type=\"text\" id=\"separate_CHANNEL_1_$paramNr\" name=\"$param\" value=\"$ps($param)\" onblur=\"ProofAndSetValue('separate_CHANNEL_1_$paramNr', 'separate_CHANNEL_1_$paramNr', parseInt($min), parseInt($max), parseFloat(1));\"> </td>"
      append HTML_PARAMS(separate_1) "<td>[getUnit ps_descr $param] [getMinMaxValueDescr ps_descr $param] </td>"
    append HTML_PARAMS(separate_1) "</tr>"

    incr paramNr
    set param "FILL_LEVEL"
    set min [getMinValue ps_descr $param]
    set max [getMaxValue ps_descr $param]
    append HTML_PARAMS(separate_1) "<tr class=\"j_custom j_caseFilllevel\">"
      append HTML_PARAMS(separate_1) "<td class=\"stringtable_value\">$devType|$param</td>"
      append HTML_PARAMS(separate_1) "<td> <input type=\"text\" id=\"separate_CHANNEL_1_$paramNr\" name=\"$param\" value=\"$ps($param)\" onblur=\"ProofValue('separate_CHANNEL_1_$paramNr',parseInt($min), $caseSelectorID, [getMaxValue ps_descr $param]);\"> </td>"
      append HTML_PARAMS(separate_1) "<td>[getUnit ps_descr $param] [getMinMaxValueDescr ps_descr $param] </td>"
    append HTML_PARAMS(separate_1) "</tr>"
    
    incr paramNr
    set param "MEA_LENGTH"
    set min [getMinValue ps_descr $param]
    set max [getMaxValue ps_descr $param]
    append HTML_PARAMS(separate_1) "<tr class=\"j_custom\">"
      append HTML_PARAMS(separate_1) "<td class=\"stringtable_value\">$devType|$param</td>"
      append HTML_PARAMS(separate_1) "<td> <input type=\"text\" id=\"separate_CHANNEL_1_$paramNr\" name=\"$param\" value=\"$ps($param)\" onblur=\"ProofValue('separate_CHANNEL_1_$paramNr',parseInt($min), $caseSelectorID, [getMaxValue ps_descr $param]);\"> </td>"
      append HTML_PARAMS(separate_1) "<td>[getUnit ps_descr $param] [getMinMaxValueDescr ps_descr $param]</td>"
    append HTML_PARAMS(separate_1) "</tr>"

    incr paramNr
    set param "USE_CUSTOM"
    append HTML_PARAMS(separate_1) "<tr>"
      append HTML_PARAMS(separate_1) "<td class=\"stringtable_value\">$devType|$param</td>"
      if {$customActive} {
        append HTML_PARAMS(separate_1) "<td> <input type=\"checkbox\" id=\"separate_CHANNEL_1_$paramNr\" name=\"$param\" value=\"$ps($param)\" checked=\"checked\"> </td>"
      } else {
        append HTML_PARAMS(separate_1) "<td> <input type=\"checkbox\" id=\"separate_CHANNEL_1_$paramNr\" name=\"$param\" value=\"$ps($param)\"> </td>"
      }
    append HTML_PARAMS(separate_1) "</tr>"
    
    append HTML_PARAMS(separate_1) "<tr height=\"25\"/>"
    append HTML_PARAMS(separate_1) "<tr id=\"caseHelp\" style=\"display:none\" >"
      append HTML_PARAMS(separate_1) "<td colspan=\"3\">"
        append HTML_PARAMS(separate_1) "<div id=\"param_1\" style=\"padding-bottom:10px\"><textarea id=\"profile_1\" style=\"display:none\">\${hintCaseForm}</textarea></div>"
        append HTML_PARAMS(separate_1) "<img id=\"waHelpImage\" src=\"/ise/img/hm-sen-wa-od.png\">"
      append HTML_PARAMS(separate_1) "</td>"
    append HTML_PARAMS(separate_1) "</tr>"
  
  append HTML_PARAMS(separate_1) "</table>"

 
  # show certain fields only if the case is a horizontal one 
	switch $selectedCase {
	  0	{displayFields ".j_caseLength, .j_caseFilllevel" "hide"}
	  1	{displayFields ".j_caseLength" "hide"}
	  2	{displayFields ".j_casej_caseFilllevel" "hide"}
  }
  
  append HTML_PARAMS(separate_1) "<script type=\"text/javascript\">"
    append HTML_PARAMS(separate_1) "translateAndSetImage(\"#waHelpImage\", \"hm-sen-wa-od.png\");"
    append HTML_PARAMS(separate_1) "st_setStringTableValues();translate('1', '$special_input_id');"
  append HTML_PARAMS(separate_1) "</script>"
}
constructor
