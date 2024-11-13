#!/bin/tclsh


# type = 'delay' or 'timeOnOff'
# base = Unit, factor = value
proc getComboBox {prn pref specialElement type {extraparam ""}} {
    global psDescr
    upvar ps ps
    set s ""

    switch $type {

      "autoInterval" {
        append s [getAutoInterval $prn $pref $specialElement]
      }

      "delay" {
        append s [getDelay $prn $pref $specialElement]
      }

      "delayShort" {
        append s [getDelayShort $prn $pref $specialElement]
      }

      "delayShortA" {
        append s [getDelayShortA $prn $pref $specialElement]
      }

      "eventDelay" {
        append s [getPanelB $prn $pref $specialElement "eventDelay"]
      }

      "eventFilterTime" {
        append s [getEventFilterTime $prn $pref $specialElement]
      }

      "eventRandomTime" {
        append s [getPanelA $prn $pref $specialElement "eventRandomTime"]
      }

      "txMinDelay" {
        append s [getPanelA $prn $pref $specialElement]
      }
      "delay0To20M_step2M" {
        append s [getDelay0to20M_step2M $prn $pref $specialElement]
      }

      "timeMin_10_15_20_25_30" {
        append s [getMin_10_15_20_25_30 $prn $pref $specialElement]
      }

      "timeOnOff" {
        append s [getTimeOnOff $prn $pref $specialElement]
      }

      "timeOnOffShort" {
        append s [getTimeOnOffShort $prn $pref $specialElement]
      }


      "rampOnOff" {
        append s [getRampOnOff $prn $pref $specialElement $extraparam]
      }

      "switchingInterval" {
        append s [getSwitchingInterval $prn $pref $specialElement]
      }

      "switchingIntervalOnTime" {
        append s [getSwitchingIntervalOnTime $prn $pref $specialElement]
      }

      "blindRunningTime" {
        append s [getBlindRunningTime $prn $pref $specialElement]
      }

      "slatRunningTime" {
        append s [getSlatRunningTime $prn $pref $specialElement]
      }

      "alarmTimeMax10Min" {
        append s [getAlarmTimeMax10Min $prn $pref $specialElement]
      }

      "blink" {
        append s [getBlink $prn $pref $specialElement]
      }

      "blink0" {
        append s [getBlink $prn $pref $specialElement]
      }

      "interval_1D_7D_14D_28D" {
        append s [getInterval_1D_7D_14D_28D $prn $pref $specialElement]
      }

    }

    return $s
}

proc getPanelA {prn pref specialElement {paramType ""}} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelayA\_$prn\_$pref\" onchange=\"setPanelAValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit100MS}</option>"
        append s "<option value=\"2\">\${optionUnit300MS}</option>"
        append s "<option value=\"3\">\${optionUnit500MS}</option>"
        append s "<option value=\"4\">\${optionUnit1500MS}</option>"
        append s "<option value=\"5\">\${optionUnit1S}</option>"
        append s "<option value=\"6\">\${optionUnit3S}</option>"
        append s "<option value=\"7\">\${optionUnit30S}</option>"
        append s "<option value=\"8\">\${optionUnit1M}</option>"
        append s "<option value=\"9\">\${optionUnit2M}</option>"
        append s "<option value=\"10\">\${optionUnit4M}</option>"
        append s "<option value=\"11\">\${optionUnit15M}</option>"
        append s "<option value=\"12\">\${optionUnit1H}</option>"
        append s "<option value=\"13\">\${stringTableEnterValue}</option>"
      append s "/<select>"

      if {$paramType == "eventDelay"} {
        append s "&nbsp;[getHelpIcon EVENT_DELAY 450 75]"
      }

      if {$paramType == "eventRandomTime"} {
        append s "&nbsp;[getHelpIcon EVENT_RANDOMTIME 450 75]"
      }

      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentDelayShortOptionPanelA = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"01\"\] = 1;"
          append s "optionMap\[\"03\"\] = 2;"
          append s "optionMap\[\"05\"\] = 3;"
          append s "optionMap\[\"010\"\] = 5;"
          append s "optionMap\[\"015\"\] = 4;"
          append s "optionMap\[\"11\"\] = 5;"
          append s "optionMap\[\"030\"\] = 6;"
          append s "optionMap\[\"13\"\] = 6;"
          append s "optionMap\[\"130\"\] = 7;"
          append s "optionMap\[\"21\"\] = 8;"
          append s "optionMap\[\"22\"\] = 9;"
          append s "optionMap\[\"24\"\] = 10;"
          append s "optionMap\[\"215\"\] = 11;"
          append s "optionMap\[\"31\"\] = 12;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 13;"
          append s "window.setTimeout(function() {jQuery(\"#timeDelayA_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 13) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setPanelAValues = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"
          append s "switch (value) \{"
            append s "case 0:"
              # keine Verzögerung
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"
            append s "case 1:"
              # 100 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 2:"
              # 300 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 3:"
              # 500 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(5);"
              append s "break;"
           append s "case 4:"
              # 1.5 sec
              append s "baseElem.val(0);"
              append s "factorElem.val(15);"
              append s "break;"
            append s "case 5:"
              # 1 sec
              append s "if (baseElem.val() != 1 || factorElem.val() != 1) \{"
                append s "baseElem.val(0);"
                append s "factorElem.val(10);"
              append s "\}"
              append s "break;"
            append s "case 6:"
              # 3 sec
              append s "if (baseElem.val() != 1 || factorElem.val() != 3) \{"
                append s "baseElem.val(0);"
                append s "factorElem.val(30);"
              append s "\}"
              append s "break;"
            append s "case 7:"
              # 30 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 8:"
              # 1 min
              append s "baseElem.val(2);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 9:"
              # 2 min
              append s "baseElem.val(2);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 10:"
              # 4 min
              append s "baseElem.val(2);"
              append s "factorElem.val(4);"
              append s "break;"
            append s "case 11:"
              # 15 min
              append s "baseElem.val(2);"
              append s "factorElem.val(15);"
              append s "break;"
            append s "case 12:"
              # 1 hour
              append s "baseElem.val(3);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 13:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"
              append s "break;"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s
}

proc getPanelB {prn pref specialElement {paramType ""}} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelayA\_$prn\_$pref\" onchange=\"setPanelBValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit100MS}</option>"
        append s "<option value=\"2\">\${optionUnit300MS}</option>"
        append s "<option value=\"3\">\${optionUnit500MS}</option>"
        append s "<option value=\"4\">\${optionUnit1500MS}</option>"
        append s "<option value=\"5\">\${optionUnit1S}</option>"
        append s "<option value=\"6\">\${optionUnit3S}</option>"
        append s "<option value=\"7\">\${optionUnit30S}</option>"
        append s "<option value=\"8\">\${optionUnit1M}</option>"
        append s "<option value=\"9\">\${optionUnit2M}</option>"
        append s "<option value=\"10\">\${optionUnit4M}</option>"
        append s "<option value=\"11\">\${optionUnit15M}</option>"
        append s "<option value=\"12\">\${stringTableEnterValue}</option>"
      append s "/<select>"

      if {$paramType == "eventDelay"} {
        append s "&nbsp;[getHelpIcon EVENT_DELAY 450 75]"
      }

      if {$paramType == "eventRandomTime"} {
        append s "&nbsp;[getHelpIcon EVENT_RANDOMTIME 450 75]"
      }

      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentDelayShortOptionPanelB = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"01\"\] = 1;"
          append s "optionMap\[\"03\"\] = 2;"
          append s "optionMap\[\"05\"\] = 3;"
          append s "optionMap\[\"010\"\] = 5;"
          append s "optionMap\[\"015\"\] = 4;"
          append s "optionMap\[\"11\"\] = 5;"
          append s "optionMap\[\"030\"\] = 6;"
          append s "optionMap\[\"13\"\] = 6;"
          append s "optionMap\[\"130\"\] = 7;"
          append s "optionMap\[\"21\"\] = 8;"
          append s "optionMap\[\"22\"\] = 9;"
          append s "optionMap\[\"24\"\] = 10;"
          append s "optionMap\[\"215\"\] = 11;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 12;"
          append s "window.setTimeout(function() {jQuery(\"#timeDelayA_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

        #  append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 12) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setPanelBValues = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"
          append s "switch (value) \{"
            append s "case 0:"
              # keine Verzögerung
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"
            append s "case 1:"
              # 100 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 2:"
              # 300 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 3:"
              # 500 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(5);"
              append s "break;"
           append s "case 4:"
              # 1.5 sec
              append s "baseElem.val(0);"
              append s "factorElem.val(15);"
              append s "break;"
            append s "case 5:"
              # 1 sec
              append s "if (baseElem.val() != 1 || factorElem.val() != 1) \{"
                append s "baseElem.val(0);"
                append s "factorElem.val(10);"
              append s "\}"
              append s "break;"
            append s "case 6:"
              # 3 sec
              append s "if (baseElem.val() != 1 || factorElem.val() != 3) \{"
                append s "baseElem.val(0);"
                append s "factorElem.val(30);"
              append s "\}"
              append s "break;"
            append s "case 7:"
              # 30 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 8:"
              # 1 min
              append s "baseElem.val(2);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 9:"
              # 2 min
              append s "baseElem.val(2);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 10:"
              # 4 min
              append s "baseElem.val(2);"
              append s "factorElem.val(4);"
              append s "break;"
            append s "case 11:"
              # 15 min
              append s "baseElem.val(2);"
              append s "factorElem.val(15);"
              append s "break;"
            append s "case 12:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s
}



proc getDelayShort {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setDelayShortValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit100MS}</option>"
        append s "<option value=\"2\">\${optionUnit300MS}</option>"
        append s "<option value=\"3\">\${optionUnit500MS}</option>"
        append s "<option value=\"4\">\${optionUnit1500MS}</option>"
        append s "<option value=\"5\">\${optionUnit1S}</option>"
        append s "<option value=\"6\">\${optionUnit3S}</option>"
        append s "<option value=\"7\">\${optionUnit30S}</option>"
        append s "<option value=\"8\">\${optionUnit1M}</option>"
        append s "<option value=\"9\">\${optionUnit2M}</option>"
        append s "<option value=\"10\">\${optionUnit15M}</option>"
        append s "<option value=\"11\">\${optionUnit1H}</option>"
        append s "<option value=\"12\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentDelayShortOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"01\"\] = 1;"
          append s "optionMap\[\"03\"\] = 2;"
          append s "optionMap\[\"05\"\] = 3;"
          append s "optionMap\[\"010\"\] = 5;"
          append s "optionMap\[\"015\"\] = 4;"
          append s "optionMap\[\"11\"\] = 5;"
          append s "optionMap\[\"030\"\] = 6;"
          append s "optionMap\[\"13\"\] = 6;"
          append s "optionMap\[\"130\"\] = 7;"
          append s "optionMap\[\"41\"\] = 8;"
          append s "optionMap\[\"42\"\] = 9;"
          append s "optionMap\[\"415\"\] = 10;"
          append s "optionMap\[\"71\"\] = 11;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 12;"
          append s "window.setTimeout(function() {jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 12) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setDelayShortValues = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"
          append s "switch (value) \{"
            append s "case 0:"
              # keine Verzögerung
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"
            append s "case 1:"
              # 100 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 2:"
              # 300 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 3:"
              # 500 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(5);"
              append s "break;"
           append s "case 4:"
              # 1.5 sec
              append s "baseElem.val(0);"
              append s "factorElem.val(15);"
              append s "break;"
            append s "case 5:"
              # 1 sec
              append s "baseElem.val(0);"
              append s "factorElem.val(10);"
              append s "break;"
            append s "case 6:"
              # 3 sec
              append s "baseElem.val(0);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 7:"
              # 30 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 8:"
              # 1 min
              append s "baseElem.val(4);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 9:"
              # 2 min
              append s "baseElem.val(4);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 10:"
              # 15 min
              append s "baseElem.val(4);"
              append s "factorElem.val(15);"
              append s "break;"
            append s "case 11:"
              # 1 hour
              append s "baseElem.val(7);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 12:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"
              append s "break;"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s
}

proc getDelayShortA {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setDelayShortValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"

        append s "<option value=\"1\">\${optionUnit30S}</option>"
        append s "<option value=\"2\">\${optionUnit1M}</option>"
        append s "<option value=\"3\">\${optionUnit2M}</option>"
        append s "<option value=\"4\">\${optionUnit5M}</option>"
        append s "<option value=\"5\">\${optionUnit15M}</option>"
        append s "<option value=\"6\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentDelayShortOptionA = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"130\"\] = 1;"
          append s "optionMap\[\"21\"\] = 2;"
          append s "optionMap\[\"22\"\] = 3;"
          append s "optionMap\[\"25\"\] = 4;"
          append s "optionMap\[\"215\"\] = 5;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 6;"
          append s "window.setTimeout(function() {jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 6) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setDelayShortValues = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"
          append s "switch (value) \{"
            append s "case 0:"
              # keine Verzögerung
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"
            append s "case 1:"
              # 30 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 2:"
              # 1 min
              append s "baseElem.val(2);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 3:"
              # 2 min
              append s "baseElem.val(2);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 4:"
              # 5 min
              append s "baseElem.val(2);"
              append s "factorElem.val(5);"
              append s "break;"
            append s "case 5:"
              # 15 min
              append s "baseElem.val(2);"
              append s "factorElem.val(15);"
              append s "break;"
            append s "case 6:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"
              append s "break;"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s
}

proc getEventFilterTime {prn pref specialElement} {
      set helpEvemtFilterTime EVENT_FILTER_TIME
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setEventFilterTime(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit500MS}</option>"
        append s "<option value=\"2\">\${optionUnit1S}</option>"
        append s "<option value=\"3\">\${optionUnit5S}</option>"
        append s "<option value=\"4\">\${optionUnit10S}</option>"
        append s "<option value=\"5\">\${optionUnit30S}</option>"
        append s "<option value=\"6\">\${optionUnit60S}</option>"
        append s "<option value=\"7\">\${optionUnit105S}</option>"
        append s "<option value=\"8\">\${stringTableEnterValue}</option>"
      append s "/<select>&nbsp;&nbsp;"

      append s [getHelpIcon $helpEvemtFilterTime]

      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentEventFilterTime = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00.00\"\] = 0;"
          append s "optionMap\[\"10.50\"\] = 1;"
          append s "optionMap\[\"20.50\"\] = 2;"
          append s "optionMap\[\"100.50\"\] = 3;"
          append s "optionMap\[\"101.00\"\] = 4;"
          append s "optionMap\[\"152.00\"\] = 5;"
          append s "optionMap\[\"154.00\"\] = 6;"
          append s "optionMap\[\"157.00\"\] = 7;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 8;"
          append s "window.setTimeout(function() {jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 8) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setEventFilterTime = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"
          append s "switch (value) \{"
            append s "case 0:"
              # keine Verzögerung
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"
            append s "case 1:"
              # 500 ms
              append s "baseElem.val(1);"
              append s "factorElem.val(0.5);"
              append s "break;"
            append s "case 2:"
              # 1 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(0.5);"
              append s "break;"
            append s "case 3:"
              # 5 sec
              append s "baseElem.val(10);"
              append s "factorElem.val(0.5);"
              append s "break;"
           append s "case 4:"
              # 10 sec
              append s "baseElem.val(10);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 5:"
              # 30 sec
              append s "baseElem.val(15);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 6:"
              # 60 sec
              append s "baseElem.val(15);"
              append s "factorElem.val(4);"
              append s "break;"
            append s "case 7:"
              # 105 sec
              append s "baseElem.val(15);"
              append s "factorElem.val(7);"
              append s "break;"
            append s "case 8:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"
              append s "break;"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s
}

proc getDelay0to20M_step2M {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setDelay0to20M_step2MValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit2M}</option>"
        append s "<option value=\"2\">\${optionUnit4M}</option>"
        append s "<option value=\"3\">\${optionUnit6M}</option>"
        append s "<option value=\"4\">\${optionUnit8M}</option>"
        append s "<option value=\"5\">\${optionUnit10M}</option>"
        append s "<option value=\"6\">\${optionUnit12M}</option>"
        append s "<option value=\"7\">\${optionUnit14M}</option>"
        append s "<option value=\"8\">\${optionUnit16M}</option>"
        append s "<option value=\"9\">\${optionUnit18M}</option>"
        append s "<option value=\"10\">\${optionUnit20M}</option>"

        # append s "<option value=\"5\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setDelay0to20M_step2MOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"40\"\] = 0;"
          append s "optionMap\[\"42\"\] = 1;"
          append s "optionMap\[\"44\"\] = 2;"
          append s "optionMap\[\"46\"\] = 3;"
          append s "optionMap\[\"48\"\] = 4;"
          append s "optionMap\[\"410\"\] = 5;"
          append s "optionMap\[\"412\"\] = 6;"
          append s "optionMap\[\"414\"\] = 7;"
          append s "optionMap\[\"416\"\] = 8;"
          append s "optionMap\[\"418\"\] = 9;"
          append s "optionMap\[\"420\"\] = 10;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 11;"
          append s "window.setTimeout(function() {jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 11) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setDelay0to20M_step2MValues = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # keine Einschaldauer
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"

            append s "case 1:"
              # 2 min
              append s "baseElem.val(4);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 2:"
              # 4 min
              append s "baseElem.val(4);"
              append s "factorElem.val(4);"
              append s "break;"
            append s "case 3:"
              # 6 min
              append s "baseElem.val(4);"
              append s "factorElem.val(6);"
              append s "break;"
            append s "case 4:"
              # 8 min
              append s "baseElem.val(4);"
              append s "factorElem.val(8);"
              append s "break;"
            append s "case 5:"
              # 10 min
              append s "baseElem.val(4);"
              append s "factorElem.val(10);"
              append s "break;"
            append s "case 6:"
              # 12 min
              append s "baseElem.val(4);"
              append s "factorElem.val(12);"
              append s "break;"
            append s "case 7:"
              # 14 min
              append s "baseElem.val(4);"
              append s "factorElem.val(14);"
              append s "break;"
            append s "case 8:"
              # 16 min
              append s "baseElem.val(4);"
              append s "factorElem.val(16);"
              append s "break;"
            append s "case 9:"
              # 18 min
              append s "baseElem.val(4);"
              append s "factorElem.val(18);"
              append s "break;"
            append s "case 10:"
              # 20 min
              append s "baseElem.val(4);"
              append s "factorElem.val(20);"
              append s "break;"
            append s "case 11:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"

              append s "break;"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s
}

proc getDelay {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setDelayValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit100MS}</option>"
        append s "<option value=\"2\">\${optionUnit5S}</option>"
        append s "<option value=\"3\">\${optionUnit10S}</option>"
        append s "<option value=\"4\">\${optionUnit30S}</option>"
        append s "<option value=\"5\">\${optionUnit1M}</option>"
        append s "<option value=\"6\">\${optionUnit2M}</option>"
        append s "<option value=\"7\">\${optionUnit5M}</option>"
        append s "<option value=\"8\">\${optionUnit10M}</option>"
        append s "<option value=\"9\">\${optionUnit30M}</option>"
        append s "<option value=\"10\">\${optionUnit1H}</option>"
        append s "<option value=\"11\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentDelayOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"01\"\] = 1;"
          append s "optionMap\[\"21\"\] = 2;"
          append s "optionMap\[\"31\"\] = 3;"
          append s "optionMap\[\"33\"\] = 4;"
          append s "optionMap\[\"41\"\] = 5;"
          append s "optionMap\[\"42\"\] = 6;"
          append s "optionMap\[\"45\"\] = 7;"
          append s "optionMap\[\"61\"\] = 8;"
          append s "optionMap\[\"63\"\] = 9;"
          append s "optionMap\[\"71\"\] = 10;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 11;"
          append s "window.setTimeout(function() {jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 11) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setDelayValues = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1)),"
          append s "trBlinkElm = jQuery('#'+elmID).parent().parent().next().next().next().next(),"
          append s "blinkElm = jQuery(trBlinkElm).find('select').first();"

          append s "if(typeof blinkElm\[0\] != 'undefined') {"
            append s "if ((value == 0) && (blinkElm\[0\].name.indexOf('_BLINK') > -1)) {trBlinkElm.hide();blinkElm.val(0);} else {trBlinkElm.show();}"
          append s "}"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # keine Verzögerung
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"

            append s "case 1:"
              # 100 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 2:"
              # 5 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 3:"
              # 10 sec
              append s "baseElem.val(3);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 4:"
              # 30 sec
              append s "baseElem.val(3);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 5:"
              # 1 min
              append s "baseElem.val(4);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 6:"
              # 2 min
              append s "baseElem.val(4);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 7:"
              # 5 min
              append s "baseElem.val(4);"
              append s "factorElem.val(5);"
              append s "break;"
            append s "case 8:"
              # 10 min
              append s "baseElem.val(6);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 9:"
              # 30 min
              append s "baseElem.val(6);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 10:"
              # 1h
              append s "baseElem.val(7);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 11:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"

              append s "break;"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s

}

proc getTimeOnOffShort {prn pref specialElement {extraparam ""}} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeOnOff\_$prn\_$pref\" onchange=\"setTimeValuesShort(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit100MS}</option>"
        append s "<option value=\"2\">\${optionUnit300MS}</option>"
        append s "<option value=\"3\">\${optionUnit1S}</option>"
        append s "<option value=\"4\">\${optionUnit3S}</option>"
        append s "<option value=\"5\">\${optionUnit30S}</option>"
        append s "<option value=\"6\">\${optionUnit1M}</option>"
        append s "<option value=\"7\">\${optionUnit2M}</option>"
        append s "<option value=\"8\">\${optionUnit1H}</option>"
        append s "<option value=\"9\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentTimeShortOption = function(prn, pref, specialElement, baseValue, factorValue) {"

          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"01\"\] = 1;"
          append s "optionMap\[\"03\"\] = 2;"
          append s "optionMap\[\"11\"\] = 3;"
          append s "optionMap\[\"030\"\] = 4;"
          append s "optionMap\[\"130\"\] = 5;"
          append s "optionMap\[\"21\"\] = 6;"
          append s "optionMap\[\"22\"\] = 7;"
          append s "optionMap\[\"31\"\] = 8;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 9;"
          append s "window.setTimeout(function() {jQuery(\"#timeOnOff_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          #append s "console.log(\"ONTIME baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 9) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"


        append s "setTimeValuesShort = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref),"
          append s "factorElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn + \"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # not in use
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"
            append s "case 1:"
              # 100 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 2:"
              # 300 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 3:"
              # 1 s
              append s "baseElem.val(1);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 4:"
              # 3 s Standard for min delay
              append s "baseElem.val(0);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 5:"
              # 30 s
              append s "baseElem.val(1);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 6:"
              # 1 min
              append s "baseElem.val(2);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 7:"
              # 2 min
              append s "baseElem.val(2);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 8:"
              # 1 h
              append s "baseElem.val(3);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 9:"
              # Wert eingeben
               append s "timeBaseTRElem.show();"
               append s "timeFactorTRElem.show();"
               append s "spaceTRElem.show();"
              append s "break;"


            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"
      return $s
}

# Returns a option list with values for the ontime delay, offtime delay and so on
proc getTimeOnOff {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeOnOff\_$prn\_$pref\" name=\"timeOnOff\_$prn\" onchange=\"setTimeValues(this.id, $prn, $pref, \'$specialElement\');\" onmouseup=\"preventOnOffNonActive(this)\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit100MS}</option>"
        append s "<option value=\"2\">\${optionUnit1S}</option>"
        append s "<option value=\"3\">\${optionUnit2S}</option>"
        append s "<option value=\"4\">\${optionUnit3S}</option>"
        append s "<option value=\"5\">\${optionUnit5S}</option>"
        append s "<option value=\"6\">\${optionUnit10S}</option>"
        append s "<option value=\"7\">\${optionUnit30S}</option>"
        append s "<option value=\"8\">\${optionUnit1M}</option>"
        append s "<option value=\"9\">\${optionUnit2M}</option>"
        append s "<option value=\"10\">\${optionUnit5M}</option>"
        append s "<option value=\"11\">\${optionUnit10M}</option>"
        append s "<option value=\"12\">\${optionUnit30M}</option>"
        append s "<option value=\"13\">\${optionUnit1H}</option>"
        append s "<option value=\"14\">\${optionUnit2H}</option>"
        append s "<option value=\"15\">\${optionUnit3H}</option>"
        append s "<option value=\"16\">\${optionUnit5H}</option>"
        append s "<option value=\"17\">\${optionUnit8H}</option>"
        append s "<option value=\"18\">\${optionUnit12H}</option>"
        append s "<option value=\"19\">\${optionUnit24H}</option>"
        append s "<option value=\"20\">\${stringTablePermanent}</option>"
        append s "<option value=\"21\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentTimeOption = function(prn, pref, specialElement, baseValue, factorValue) {"

          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"01\"\] = 1;"
          append s "optionMap\[\"11\"\] = 2;"
          append s "optionMap\[\"12\"\] = 3;"
          append s "optionMap\[\"13\"\] = 4;"
          append s "optionMap\[\"21\"\] = 5;"
          append s "optionMap\[\"31\"\] = 6;"
          append s "optionMap\[\"33\"\] = 7;"
          append s "optionMap\[\"41\"\] = 8;"
          append s "optionMap\[\"42\"\] = 9;"
          append s "optionMap\[\"45\"\] = 10;" ;# 5 Minutes - floor terminal block 6 or 10 channels
          append s "optionMap\[\"51\"\] = 10;" ;# 5 Minutes - all other devices
          append s "optionMap\[\"61\"\] = 11;"
          append s "optionMap\[\"63\"\] = 12;"
          append s "optionMap\[\"71\"\] = 13;"
          append s "optionMap\[\"72\"\] = 14;"
          append s "optionMap\[\"73\"\] = 15;"
          append s "optionMap\[\"75\"\] = 16;"
          append s "optionMap\[\"78\"\] = 17;"
          append s "optionMap\[\"712\"\] = 18;"
          append s "optionMap\[\"724\"\] = 19;"
          append s "optionMap\[\"731\"\] = 20;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() :jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"


          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 21;"
          append s "window.setTimeout(function() {jQuery(\"#timeOnOff_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          #append s "console.log(\"ONTIME baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"


          # Enter user value
          append s "if (optionVal == 21) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"


        append s "setTimeValues = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref),"
          append s "factorElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn + \"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # not in use
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"
            append s "case 1:"
              # not in use
              append s "baseElem.val(0);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 2:"
              # 1 s
              append s "baseElem.val(1);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 3:"
              # 2 s
              append s "baseElem.val(1);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case4:"
              # 3 s
              append s "baseElem.val(1);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 5:"
              # 5 s
              append s "baseElem.val(2);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 6:"
              # 10 s
              append s "baseElem.val(3);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 7:"
              # 30 s
              append s "baseElem.val(3);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 8:"
              # 1 m
              append s "baseElem.val(4);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 9:"
              # 2 m
              append s "baseElem.val(4);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 10:"
              # 5 m
              append s "baseElem.val(5);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 11:"
              # 10 m
              append s "baseElem.val(6);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 12:"
              # 30 m
              append s "baseElem.val(6);"
              append s "factorElem.val(3);"
              append s "break;"

            append s "case 13:"
              # 1 h
              append s "baseElem.val(7);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 14:"
              # 2 h
              append s "baseElem.val(7);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 15:"
              # 3 h
              append s "baseElem.val(7);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 16:"
              # 5 h
              append s "baseElem.val(7);"
              append s "factorElem.val(5);"
              append s "break;"
            append s "case 17:"
              # 8 h
              append s "baseElem.val(7);"
              append s "factorElem.val(8);"
              append s "break;"
            append s "case 18:"
              # 12 h
              append s "baseElem.val(7);"
              append s "factorElem.val(12);"
              append s "break;"
            append s "case 19:"
              # 24 h
              append s "baseElem.val(7);"
              append s "factorElem.val(24);"
              append s "break;"
            append s "case 20:"
              # Unendlich
              append s "baseElem.val(7);"
              append s "factorElem.val(31);"
              append s "break;"
            append s "case 21:"
              # Wert eingeben
               append s "timeBaseTRElem.show();"
               append s "timeFactorTRElem.show();"
               append s "spaceTRElem.show();"
              append s "break;"

            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"
      return $s
}

proc getRampOnOff {prn pref specialElement {extraparam ""}} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setRampOnOffValues(this.id, $prn, $pref, \'$specialElement\')\">"
        if {[string equal $extraparam "SERVOSPEED"] == 0} {
          append s "<option value=\"0\">\${optionNotActive}</option>"
        } else {
          append s "<option value=\"0\">\${optionServoSpeed}</option>"
        }
        append s "<option value=\"1\">\${optionUnit200MS}</option>"
        append s "<option value=\"2\">\${optionUnit500MS}</option>"
        append s "<option value=\"3\">\${optionUnit1S}</option>"
        append s "<option value=\"4\">\${optionUnit2S}</option>"
        append s "<option value=\"5\">\${optionUnit5S}</option>"
        append s "<option value=\"6\">\${optionUnit10S}</option>"
        append s "<option value=\"7\">\${optionUnit20S}</option>"
        append s "<option value=\"8\">\${optionUnit30S}</option>"
        append s "<option value=\"9\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentRampOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"02\"\] = 1;"
          append s "optionMap\[\"05\"\] = 2;"
          append s "optionMap\[\"010\"\] = 3;"
          append s "optionMap\[\"11\"\] = 3;"
          append s "optionMap\[\"020\"\] = 4;"
          append s "optionMap\[\"12\"\] = 4;"
          append s "optionMap\[\"15\"\] = 5;"
          append s "optionMap\[\"110\"\] = 6;"
          append s "optionMap\[\"120\"\] = 7;"
          append s "optionMap\[\"130\"\] = 8;"

          # append s "var baseVal = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          # append s "factorVal =   jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 9;"
          append s "window.setTimeout(function() {jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          #append s "console.log(\"RAMP baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 9) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setRampOnOffValues = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # keine Verzögerung
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"
            append s "case 1:"
              # 200 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 2:"
              # 500 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(5);"
              append s "break;"
            append s "case 3:"
              # 1 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 4:"
              # 2 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 5:"
              # 5 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(5);"
              append s "break;"
            append s "case 6:"
              # 10 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(10);"
              append s "break;"
            append s "case 7:"
              # 20 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(20);"
              append s "break;"
            append s "case 8:"
              # 30 sec
              append s "baseElem.val(1);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 9:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"

              append s "break;"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s
}

proc getSwitchingInterval {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setSwitchingIntervalValues(this.id, $prn, $pref, \'$specialElement\')\">"
      # SPHM-1282  append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit1D}</option>"
        append s "<option value=\"2\">\${optionUnit7D}</option>"
        append s "<option value=\"3\">\${optionUnit14D}</option>"
        append s "<option value=\"4\">\${optionUnit24D}</option>"

        # append s "<option value=\"5\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentSwitchingIntervalOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"71\"\] = 1;"
          append s "optionMap\[\"77\"\] = 2;"
          append s "optionMap\[\"714\"\] = 3;"
          append s "optionMap\[\"724\"\] = 4;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 5;"
          append s "window.setTimeout(function() {jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 5) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setSwitchingIntervalValues = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # keine Verzögerung
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"

            append s "case 1:"
              # 1 day
              append s "baseElem.val(7);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 2:"
              # 7 days
              append s "baseElem.val(7);"
              append s "factorElem.val(7);"
              append s "break;"
            append s "case 3:"
              # 14 days
              append s "baseElem.val(7);"
              append s "factorElem.val(14);"
              append s "break;"
            append s "case 4:"
              # 24 days
              append s "baseElem.val(7);"
              append s "factorElem.val(24);"
              append s "break;"
            append s "case 5:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"

              append s "break;"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s
}

proc getInterval_1D_7D_14D_28D {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setInterval_1D_7D_14D_28D(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionUnit1D}</option>"
        append s "<option value=\"1\">\${optionUnit7D}</option>"
        append s "<option value=\"2\">\${optionUnit14D}</option>"
        append s "<option value=\"3\">\${optionUnit28D}</option>"
        append s "<option value=\"4\">\${optionDisable}</option>"
        append s "<option value=\"5\">\${stringTableEnterValue}</option>"

      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentInterval_1D_7D_14D_28D = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"41\"\] = 0;"
          append s "optionMap\[\"47\"\] = 1;"
          append s "optionMap\[\"414\"\] = 2;"
          append s "optionMap\[\"428\"\] = 3;"
          append s "optionMap\[\"00\"\] = 4;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 5;"
          append s "window.setTimeout(function() {jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 5) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setInterval_1D_7D_14D_28D = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # keine Verzögerung
              append s "baseElem.val(4);"
              append s "factorElem.val(1);"
              append s "break;"

            append s "case 1:"
              # 1 day
              append s "baseElem.val(4);"
              append s "factorElem.val(7);"
              append s "break;"
            append s "case 2:"
              # 7 days
              append s "baseElem.val(4);"
              append s "factorElem.val(14);"
              append s "break;"
            append s "case 3:"
              # 14 days
              append s "baseElem.val(4);"
              append s "factorElem.val(28);"
              append s "break;"
            append s "case 4:"
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"
            append s "case 5:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s
}

proc getSwitchingIntervalOnTime {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setSwitchingIntervalOnTimeValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit1M}</option>"
        append s "<option value=\"2\">\${optionUnit2M}</option>"
        append s "<option value=\"3\">\${optionUnit5M}</option>"
        append s "<option value=\"4\">\${optionUnit10M}</option>"

        # append s "<option value=\"5\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentSwitchingIntervalOnTimeOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"41\"\] = 1;"
          append s "optionMap\[\"42\"\] = 2;"
          append s "optionMap\[\"45\"\] = 3;"
          append s "optionMap\[\"410\"\] = 4;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 5;"
          append s "window.setTimeout(function() {jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 5) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setSwitchingIntervalOnTimeValues = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # keine Einschaldauer
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"

            append s "case 1:"
              # 1 min
              append s "baseElem.val(4);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 2:"
              # 2 min
              append s "baseElem.val(4);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 3:"
              # 5 min
              append s "baseElem.val(4);"
              append s "factorElem.val(5);"
              append s "break;"
            append s "case 4:"
              # 10 min
              append s "baseElem.val(4);"
              append s "factorElem.val(10);"
              append s "break;"
            append s "case 5:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"

              append s "break;"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s
}

## START ##

proc getAutoInterval {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setAutoIntervalValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionNotActive}</option>"
        append s "<option value=\"1\">\${optionUnit1H}</option>"
        append s "<option value=\"2\">\${optionUnit12H}</option>"
        append s "<option value=\"3\">\${optionUnit24H}</option>"
        append s "<option value=\"4\">\${optionUnit7D}</option>"
        # append s "<option value=\"5\">\${stringTableEnterValue}</option>"

      append s "/<select>"

      append s "&nbsp;[getHelpIcon AUTO_SENSOR_CLEANING 600 150]"

      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentAutoIntervalOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"00\"\] = 0;"
          append s "optionMap\[\"41\"\] = 1;"
          append s "optionMap\[\"412\"\] = 2;"
          append s "optionMap\[\"51\"\] = 3;"
          append s "optionMap\[\"61\"\] = 4;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 5;"
          append s "window.setTimeout(function() {jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 5) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setAutoIntervalValues = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # keine Verzögerung
              append s "baseElem.val(0);"
              append s "factorElem.val(0);"
              append s "break;"

            append s "case 1:"
              # 1 hour
              append s "baseElem.val(4);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 2:"
              # 12 hours
              append s "baseElem.val(4);"
              append s "factorElem.val(12);"
              append s "break;"
            append s "case 3:"
              # 24 hours / 1 day
              append s "baseElem.val(5);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 4:"
              # 7 days
              append s "baseElem.val(6);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 5:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"

              append s "break;"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s
}

## END ##

proc getBlindRunningTime {prn pref specialElement} {
      set helpRunningTime BLIND_REFERENCE_RUNNING_TIME

      set s ""
      append s "<td>"
        append s  "<select id=\"timeDelay\_$prn\_$pref\" name=\"presetsAutoCalibration\" onchange=\"setBlindRunningTimeValues(this.id, $prn, $pref, \'$specialElement\')\">"
          append s "<option value=\"0\">\${optionUnit30S}</option>"
          append s "<option value=\"1\">\${optionUnit45S}</option>"
          append s "<option value=\"2\">\${optionUnit60S}</option>"
          append s "<option value=\"3\">\${optionUnit90S}</option>"
          append s "<option value=\"4\">\${stringTableEnterValue}</option>"

        append s "/<select> "
        append s [getHelpIcon $helpRunningTime]
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentBlindRunningTimeOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"230\"\] = 0;"
          append s "optionMap\[\"245\"\] = 1;"
          append s "optionMap\[\"260\"\] = 2;"
          append s "optionMap\[\"290\"\] = 3;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 4;"
          append s "window.setTimeout(function() {jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          # append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 4) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setBlindRunningTimeValues = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # 30 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 1:"
              # 45 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(45);"
              append s "break;"
            append s "case 2:"
              # 60 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(60);"
              append s "break;"
            append s "case 3:"
              # 90 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(90);"
              append s "break;"
            append s "case 4:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"

              append s "break;"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s
}

proc getSlatRunningTime {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" name=\"presetsAutoCalibration\" onchange=\"setSlatRunningTimeValues(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionUnit1S}</option>"
        append s "<option value=\"1\">\${optionUnit2S}</option>"
        append s "<option value=\"2\">\${optionUnit3S}</option>"
        append s "<option value=\"3\">\${optionUnit4S}</option>"
        append s "<option value=\"4\">\${optionUnit5S}</option>"

        append s "<option value=\"5\">\${optionUnit10S}</option>"
        append s "<option value=\"6\">\${optionUnit15S}</option>"
        append s "<option value=\"7\">\${optionUnit20S}</option>"
        append s "<option value=\"8\">\${optionUnit25S}</option>"
        append s "<option value=\"9\">\${optionUnit30S}</option>"
        append s "<option value=\"10\">\${stringTableEnterValue}</option>"

      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentSlatRunningTimeOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"21\"\] = 0;"
          append s "optionMap\[\"22\"\] = 1;"
          append s "optionMap\[\"23\"\] = 2;"
          append s "optionMap\[\"24\"\] = 3;"
          append s "optionMap\[\"25\"\] = 4;"
          append s "optionMap\[\"210\"\] = 5;"
          append s "optionMap\[\"215\"\] = 6;"
          append s "optionMap\[\"220\"\] = 7;"
          append s "optionMap\[\"225\"\] = 8;"
          append s "optionMap\[\"230\"\] = 9;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 10;"
          append s "window.setTimeout(function() {jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          # append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 10) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setSlatRunningTimeValues = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # 1 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 1:"
              # 2 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 2:"
              # 3 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(3);"
              append s "break;"
            append s "case 3:"
              # 4 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(4);"
              append s "break;"
            append s "case 4:"
              # 5 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(5);"
              append s "break;"
            append s "case 5:"
              # 10 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(10);"
              append s "break;"
            append s "case 6:"
              # 15 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(15);"
              append s "break;"
            append s "case 7:"
              # 20 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(20);"
              append s "break;"
            append s "case 8:"
              # 25 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(25);"
              append s "break;"
            append s "case 9:"
              # 30 sec
              append s "baseElem.val(2);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 10:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"
              append s "break;"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s
}

proc getMin_10_15_20_25_30 {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setMin_10_15_20_25_30Values(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${optionUnit10M}</option>"
        append s "<option value=\"1\">\${optionUnit15M}</option>"
        append s "<option value=\"2\">\${optionUnit20M}</option>"
        append s "<option value=\"3\">\${optionUnit25M}</option>"
        append s "<option value=\"4\">\${optionUnit30M}</option>"

        append s "<option value=\"5\">\${stringTableEnterValue}</option>"
      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentTimeMin_10_15_20_25_30Option = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"210\"\] = 0;"
          append s "optionMap\[\"215\"\] = 1;"
          append s "optionMap\[\"220\"\] = 2;"
          append s "optionMap\[\"225\"\] = 3;"
          append s "optionMap\[\"230\"\] = 4;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 5;"
          append s "window.setTimeout(function() {jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          # append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 5) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setMin_10_15_20_25_30Values = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # 10 min
              append s "baseElem.val(2);"
              append s "factorElem.val(10);"
              append s "break;"

            append s "case 1:"
              # 15 min
              append s "baseElem.val(2);"
              append s "factorElem.val(15);"
              append s "break;"
            append s "case 2:"
              # 20 min
              append s "baseElem.val(2);"
              append s "factorElem.val(20);"
              append s "break;"
            append s "case 3:"
              # 25 min
              append s "baseElem.val(2);"
              append s "factorElem.val(25);"
              append s "break;"
            append s "case 4:"
              # 30 min
              append s "baseElem.val(2);"
              append s "factorElem.val(30);"
              append s "break;"
            append s "case 5:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"

              append s "break;"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s
}

proc getAlarmTimeMax10Min {prn pref specialElement} {
  set s ""
  append s "<td>"
  append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setAlarmTimeMax10MinValues(this.id, $prn, $pref, \'$specialElement\')\">"
    append s "<option value=\"0\">\${optionUnit1S}</option>"
    append s "<option value=\"1\">\${optionUnit5S}</option>"
    append s "<option value=\"2\">\${optionUnit10S}</option>"
    append s "<option value=\"3\">\${optionUnit30S}</option>"
    append s "<option value=\"4\">\${optionUnit1M}</option>"
    append s "<option value=\"5\">\${optionUnit2M}</option>"
    append s "<option value=\"6\">\${optionUnit3M}</option>"
    append s "<option value=\"7\">\${optionUnit4M}</option>"
    append s "<option value=\"8\">\${optionUnit5M}</option>"
    append s "<option value=\"9\">\${optionUnit6M}</option>"
    append s "<option value=\"10\">\${optionUnit8M}</option>"
    append s "<option value=\"11\">\${optionUnit10M}</option>"

    # Hide the next value because the max value should not exceed 10 minutes
    # append s "<option value=\"12\">\${stringTableEnterValue}</option>"
  append s "/<select>"
  append s "</td>"

  append s "<script type=\"text/javascript\">"

    append s "setCurrentAlarmTimeMax10MinOption = function(prn, pref, specialElement, baseValue, factorValue) {"
      append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
      append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
      append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1)),"
      append s "lblInvalidOntimeElm = jQuery(\"#alarmHiddenValue_\" + prn +\"_\" + pref),"
      append s "ontimePresetElm = jQuery(\"#timeDelay_\" + prn +\"_\" + pref),"
      append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
      append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1));"

      append s "var optionMap = \[\];"
      append s "optionMap\[\"11\"\] = 0;"
      append s "optionMap\[\"15\"\] = 1;"
      append s "optionMap\[\"110\"\] = 2;"
      append s "optionMap\[\"130\"\] = 3;"
      append s "optionMap\[\"41\"\] = 4;"
      append s "optionMap\[\"42\"\] = 5;"
      append s "optionMap\[\"43\"\] = 6;"
      append s "optionMap\[\"44\"\] = 7;"
      append s "optionMap\[\"45\"\] = 8;"
      append s "optionMap\[\"46\"\] = 9;"
      append s "optionMap\[\"48\"\] = 10;"
      append s "optionMap\[\"61\"\] = 11;"

      append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
      append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

      append s "currentVal = baseVal+factorVal,"
      append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 12;"
      append s "window.setTimeout(function() {jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

      # append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

      # Enter user value
      append s "if (optionVal == 12) {"
        append s "bVal = baseVal; fVal = factorVal;"
        append s "baseElem.val(bVal);"
        append s "factorElem.val(fVal);"
        append s "lblInvalidOntimeElm.show();"
        append s "ontimePresetElm.append('<option class=\"attention\" value=\"12\" selected=\"selected\">\${userSpecific}</option>');"
        append s "translatePage('#ProfileTbl_receiver');"
      append s "}"
    append s "};"

    append s "setAlarmTimeMax10MinValues = function(elmID, prn, pref, specialElement) {"
      append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
      append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
      append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
      append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
      append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
      append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1)),"
      append s "lblInvalidOntimeElm = jQuery(\"#alarmHiddenValue_\" + prn +\"_\" + pref);"

      append s "timeBaseTRElem.hide();"
      append s "timeFactorTRElem.hide();"
      append s "spaceTRElem.hide();"

      append s "lblInvalidOntimeElm.hide();"

      append s "switch (value) \{"
        append s "case 0:"
          # 1 s
          append s "baseElem.val(1);"
          append s "factorElem.val(1);"
          append s "break;"
        append s "case 1:"
          # 5 sec
          append s "baseElem.val(1);"
          append s "factorElem.val(5);"
          append s "break;"
        append s "case 2:"
          # 10 sec
          append s "baseElem.val(1);"
          append s "factorElem.val(10);"
          append s "break;"
        append s "case 3:"
          # 30 sec
          append s "baseElem.val(1);"
          append s "factorElem.val(30);"
          append s "break;"
        append s "case 4:"
          # 1 min
          append s "baseElem.val(4);"
          append s "factorElem.val(1);"
          append s "break;"
        append s "case 5:"
          # 2 min
          append s "baseElem.val(4);"
          append s "factorElem.val(2);"
          append s "break;"
        append s "case 6:"
          # 3 min
          append s "baseElem.val(4);"
          append s "factorElem.val(3);"
          append s "break;"
        append s "case 7:"
          # 4 min
          append s "baseElem.val(4);"
          append s "factorElem.val(4);"
          append s "break;"
        append s "case 8:"
          # 5 min
          append s "baseElem.val(4);"
          append s "factorElem.val(5);"
          append s "break;"
        append s "case 9:"
          # 6 min
          append s "baseElem.val(4);"
          append s "factorElem.val(6);"
          append s "break;"
        append s "case 10:"
          # 8 min
          append s "baseElem.val(4);"
          append s "factorElem.val(8);"
          append s "break;"
        append s "case 11:"
          # 10 min
          append s "baseElem.val(6);"
          append s "factorElem.val(1);"
          append s "break;"
         append s "case 12:"
          append s "baseElem.val(bVal);"
          append s "factorElem.val(fVal);"
          append s "lblInvalidOntimeElm.show();"
          append s "break;"
        append s "default: conInfo(\"Problem\");"
      append s "\}"
    append s "};"
  append s "</script>"

  return $s
}

proc getBlink {prn pref specialElement} {
      set s ""
      append s "<td>"
      append s  "<select id=\"timeDelay\_$prn\_$pref\" onchange=\"setBlinkOptions(this.id, $prn, $pref, \'$specialElement\')\">"
        append s "<option value=\"0\">\${stringTablePermanent}</option>"
        append s "<option value=\"1\">\${optionUnit100MS}</option>"
        append s "<option value=\"2\">\${optionUnit500MS}</option>"
        append s "<option value=\"3\">\${optionUnit1S}</option>"
        append s "<option value=\"4\">\${optionUnit2S}</option>"
        append s "<option value=\"5\">\${optionUnit5S}</option>"
        append s "<option value=\"6\">\${stringTableEnterValue}</option>"

      append s "/<select>"
      append s "</td>"

      append s "<script type=\"text/javascript\">"

        append s "setCurrentBlinkOption = function(prn, pref, specialElement, baseValue, factorValue) {"
          append s "var timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\" + pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\" + prn + \"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "var optionMap = \[\];"
          append s "optionMap\[\"731\"\] = 0;"
          append s "optionMap\[\"01\"\] = 1;"
          append s "optionMap\[\"05\"\] = 2;"
          append s "optionMap\[\"11\"\] = 3;"
          append s "optionMap\[\"12\"\] = 4;"
          append s "optionMap\[\"15\"\] = 5;"

          append s "var baseVal = (typeof baseValue != 'undefined') ? baseValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + pref).val(),"
          append s "factorVal = (typeof factorValue != 'undefined') ? factorValue.toString() : jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\" + (parseInt(pref) + 1)).val(),"

          append s "currentVal = baseVal+factorVal,"
          append s "optionVal = (optionMap\[currentVal\] != undefined) ? optionMap\[currentVal\] : 6;"
          append s "window.setTimeout(function() {jQuery(\"#timeDelay_\" + prn + \"_\" + pref).val(optionVal).change();}, 10);"

          #append s "console.log(\"DELAY baseVal: \" + baseVal + \" - factorVal: \" + factorVal + \" - currentVal: \" + currentVal + \" - optionVal: \" + optionVal);"

          # Enter user value
          append s "if (optionVal == 6) {"
            append s "timeBaseTRElem.show();"
            append s "timeFactorTRElem.show();"
            append s "spaceTRElem.show();"
          append s "}"

        append s "};"

        append s "setBlinkOptions = function(elmID, prn, pref, specialElement) {"
          append s "var value= parseInt(jQuery(\"#\"+elmID).val()),"
          append s "baseElem = jQuery(\"#separate_\" + specialElement + \"_\" + prn + \"_\"+ pref),"
          append s "factorElem = jQuery(\"#separate_\" +specialElement + \"_\"+ prn +\"_\" + (parseInt(pref) + 1)),"
          append s "timeBaseTRElem = jQuery(\"#timeBase_\" + prn +\"_\"+ pref),"
          append s "timeFactorTRElem = jQuery(\"#timeFactor_\"+prn+\"_\" + (parseInt(pref) + 1)),"
          append s "spaceTRElem = jQuery(\"#space_\" + prn +\"_\"+ (parseInt(pref) + 1));"

          append s "timeBaseTRElem.hide();"
          append s "timeFactorTRElem.hide();"
          append s "spaceTRElem.hide();"

          append s "switch (value) \{"
            append s "case 0:"
              # permanently
              append s "baseElem.val(7);"
              append s "factorElem.val(31);"
              append s "break;"

            append s "case 1:"
              # 100ms
              append s "baseElem.val(0);"
              append s "factorElem.val(1);"
              append s "break;"

            append s "case 2:"
              # 500 ms
              append s "baseElem.val(0);"
              append s "factorElem.val(5);"
              append s "break;"
            append s "case 3:"
              # 1 s
              append s "baseElem.val(1);"
              append s "factorElem.val(1);"
              append s "break;"
            append s "case 4:"
              # 2 s
              append s "baseElem.val(1);"
              append s "factorElem.val(2);"
              append s "break;"
            append s "case 5:"
              # 5 s
              append s "baseElem.val(1);"
              append s "factorElem.val(5);"
              append s "break;"
            append s "case 6:"
              append s "timeBaseTRElem.show();"
              append s "timeFactorTRElem.show();"
              append s "spaceTRElem.show();"

              append s "break;"
            append s "default: conInfo(\"Problem\");"
          append s "\}"
        append s "};"
      append s "</script>"

      return $s
}

##

proc trimParam {param} {
  set s [string trimleft $param ']
  set s [string trimright $s ']
  return $s
}

proc getEventFilterNumber {param value chn prn special_input_id {extraparam ""}} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'
    set s "<tr id=\"timeBase_$chn\_$prn\" class=\"hidden\">"
      append s "<td>\${[getDescription $param\_A $extraparam]}</td>"
      append s "<td>"
        append s "<select id=$elemId name=$param>"
          append s "<option value='0'>0</option>"
          append s "<option value='1'>1</option>"
          append s "<option value='2'>2</option>"
          append s "<option value='3'>3</option>"
          append s "<option value='4'>4</option>"
          append s "<option value='5'>5</option>"
          append s "<option value='6'>6</option>"
          append s "<option value='7'>7</option>"
          append s "<option value='8'>8</option>"
          append s "<option value='9'>9</option>"
          append s "<option value='10'>10</option>"
          append s "<option value='11'>11</option>"
          append s "<option value='12'>12</option>"
          append s "<option value='13'>13</option>"
          append s "<option value='14'>14</option>"
          append s "<option value='15'>15</option>"
        append s "</select>"
      append s "</td>"
    append s "</tr>"
    append s "<script type=\"text/javascript\">"
      append s "jQuery($j_elemId).val('$value');"
      # don`t use jQuery - the dirty flag will not be recognized
      append s "document.getElementById($elemId)\[$value\].defaultSelected = true;"
    append s "</script>"
    return $s
}

proc getTimeUnitComboBox {param value chn prn special_input_id {extraparam ""}} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'

  set s "<tr id=\"timeBase_$chn\_$prn\" class=\"hidden\">"
    append s "<td>\${[getDescription $param $extraparam]}</td>"
    append s "<td>"
      append s "<select id=$elemId name=$param>"
        append s "<option value='0'>\${optionUnit100MS}</option>"
        append s "<option value='1'>\${optionUnit1S}</option>"
        append s "<option value='2'>\${optionUnit5S}</option>"
        append s "<option value='3'>\${optionUnit10S}</option>"
        append s "<option value='4'>\${optionUnit1M}</option>"
        append s "<option value='5'>\${optionUnit5M}</option>"
        append s "<option value='6'>\${optionUnit10M}</option>"
        append s "<option value='7'>\${optionUnitH}</option>"
      append s "</select>"
    append s "</td>"
  append s "</tr>"
  append s "<script type=\"text/javascript\">"
    append s "jQuery($j_elemId).val('$value');"
    # don`t use jQuery - the dirty flag will not be recognized
    append s "document.getElementById($elemId)\[$value\].defaultSelected = true;"
  append s "</script>"
  return $s
}

proc getTimeUnitComboBoxB {param value chn prn special_input_id {extraparam ""}} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'

  set s "<tr id=\"timeBase_$chn\_$prn\" class=\"hidden\">"
    append s "<td>\${[getDescription $param $extraparam]}</td>"
    append s "<td>"
      append s "<select id=$elemId name=$param>"
        append s "<option value='0'>\${optionUnit1S}</option>"
        append s "<option value='1'>\${optionUnit5S}</option>"
        append s "<option value='2'>\${optionUnit10S}</option>"
        append s "<option value='3'>\${optionUnit1M}</option>"
        append s "<option value='4'>\${optionUnit5M}</option>"
        append s "<option value='5'>\${optionUnit10M}</option>"
        append s "<option value='6'>\${optionUnitH}</option>"
        append s "<option value='7'>\${optionUnit1D}</option>"
      append s "</select>"
    append s "</td>"
  append s "</tr>"
  append s "<script type=\"text/javascript\">"
    append s "jQuery($j_elemId).val('$value');"
    # don`t use jQuery - the dirty flag will not be recognized
    append s "document.getElementById($elemId)\[$value\].defaultSelected = true;"
  append s "</script>"
  return $s
}

proc getTimeUnitComboBoxC {param value chn prn special_input_id {extraparam ""}} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'

  set s "<tr id=\"timeBase_$chn\_$prn\" class=\"hidden\">"
    append s "<td>\${[getDescription $param $extraparam]}</td>"
    append s "<td>"
      append s "<select id=$elemId name=$param>"
        append s "<option value='0'>\${optionUnitS}</option>"
        append s "<option value='1'>\${optionUnit10S}</option>"
        append s "<option value='2'>\${optionUnitM}</option>"
        append s "<option value='3'>\${optionUnit10M}</option>"
        append s "<option value='4'>\${optionUnitH}</option>"
        append s "<option value='5'>\${optionUnitD}</option>"
        append s "<option value='6'>\${optionUnit7D}</option>"
      append s "</select>"
    append s "</td>"
  append s "</tr>"
  append s "<script type=\"text/javascript\">"
    append s "jQuery($j_elemId).val('$value');"
    # don`t use jQuery - the dirty flag will not be recognized
    append s "document.getElementById($elemId)\[$value\].defaultSelected = true;"
  append s "</script>"
  return $s
}

proc getTimeUnitComboBoxD {param value chn prn special_input_id {extraparam ""}} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'

  set s "<tr id=\"timeBase_$chn\_$prn\" class=\"hidden\">"
    append s "<td>\${[getDescription $param $extraparam]}</td>"
    append s "<td>"
      append s "<select id=$elemId name=$param>"
        append s "<option value='0'>\${optionUnit1S}</option>"
        append s "<option value='1'>\${optionUnit10S}</option>"
        append s "<option value='2'>\${optionUnit1M}</option>"
        append s "<option value='3'>\${optionUnit1H}</option>"
        append s "<option value='4'>\${optionUnit1D}</option>"
        append s "<option value='5'>\${optionUnit7D}</option>"
        append s "<option value='6'>\${optionUnit28D}</option>"
      append s "</select>"
    append s "</td>"
  append s "</tr>"
  append s "<script type=\"text/javascript\">"
    append s "jQuery($j_elemId).val('$value');"
    # don`t use jQuery - the dirty flag will not be recognized
    append s "document.getElementById($elemId)\[$value\].defaultSelected = true;"
  append s "</script>"
  return $s
}

proc getTimeUnitComboBoxShort {param value chn prn special_input_id {extraparam ""}} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'

  set trName ""
  set specialVal0 ""
  set specialVal1 ""

  if {[string equal $extraparam ""] != 1} {
    set specialVal0 [lindex [split $extraparam =] 0]
    set specialVal1 [lindex [split $extraparam =] 1]

    if {[string equal $specialVal0 "trNAME"] != -1 } {
      set trName name=$specialVal1
    }
  }

  set s "<tr $trName id=\"timeBase_$chn\_$prn\" class=\"hidden\">"
    append s "<td>\${[getDescription $param $extraparam]}</td>"
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
    # don`t use jQuery - the dirty flag will not be recognized
    append s "document.getElementById($elemId)\[$value\].defaultSelected = true;"
  append s "</script>"
  return $s
}

proc getTimeUnitComboBoxShortwoHour {param value chn prn special_input_id {extraparam ""}} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'

  set trName ""
  set specialVal0 ""
  set specialVal1 ""

  if {[string equal $extraparam ""] != 1} {
    set specialVal0 [lindex [split $extraparam =] 0]
    set specialVal1 [lindex [split $extraparam =] 1]

    if {[string equal $specialVal0 "trNAME"] != -1 } {
      set trName name=$specialVal1
    }
  }

  set s "<tr $trName id=\"timeBase_$chn\_$prn\" class=\"hidden\">"
    append s "<td>\${[getDescription $param $extraparam]}</td>"
    append s "<td>"
      append s "<select id=$elemId name=$param>"
        append s "<option value='0'>\${optionUnit100MS}</option>"
        append s "<option value='1'>\${optionUnitS}</option>"
        append s "<option value='2'>\${optionUnitM}</option>"
      append s "</select>"
    append s "</td>"
  append s "</tr>"
  append s "<script type=\"text/javascript\">"
    append s "jQuery($j_elemId).val('$value');"
    # don`t use jQuery - the dirty flag will not be recognized
    append s "document.getElementById($elemId)\[$value\].defaultSelected = true;"
  append s "</script>"
  return $s
}

proc getTimeUnit10ms_100ms_1s_10s {param value chn prn special_input_id {extraparam ""}} {
  set param [trimParam $param]
  set elemId 'separate_$special_input_id\_$prn'
  set j_elemId '#separate_$special_input_id\_$prn'

  set s "<tr id=\"timeBase_$chn\_$prn\" class=\"hidden\">"
    append s "<td>\${[getDescription $param $extraparam]}</td>"
    append s "<td>"
      append s "<select id=$elemId name=$param>"
        append s "<option value='0'>\${optionUnit10MS}</option>"
        append s "<option value='1'>\${optionUnit100MS}</option>"
        append s "<option value='2'>\${optionUnitS}</option>"
        append s "<option value='3'>\${optionUnit10S}</option>"
      append s "</select>"
    append s "</td>"
  append s "</tr>"
  append s "<script type=\"text/javascript\">"
    append s "jQuery($j_elemId).val('$value');"
    # don`t use jQuery - the dirty flag will not be recognized
    append s "document.getElementById($elemId)\[$value\].defaultSelected = true;"
  append s "</script>"
  return $s
}

proc getDescription {param {extraparam ""}} {
  set result $param
  set desc(REPEATED_LONG_PRESS_TIMEOUT_UNIT) "stringTableKeyLongPressTimeOutUnit"
  set desc(EVENT_DELAY_UNIT) "stringTableEventDelayUnit"
  set desc(EVENT_RANDOMTIME_UNIT) "stringTableEventRandomTimeUnit"
  set desc(POWER_OFFDELAY_UNIT) "stringTableOffDelayUnit"
  set desc(POWERUP_ONDELAY_UNIT) "stringTableOnDelayUnit"
  set desc(POWERUP_OFFDELAY_UNIT) "stringTableOffDelayUnit"
  set desc(POWERUP_ONTIME_UNIT) "stringTableOnTimeUnit"
  set desc(POWERUP_OFFTIME_UNIT) "stringTableOffTimeUnit"
  set desc(ON_TIME_BASE) "stringTableOnTimeUnit"

  set desc(OFFDELAY_TIME_BASE) "stringTableOffDelayUnit"
  set desc(ONDELAY_TIME_BASE) "stringTableOnDelayUnit"

  set desc(SWITCHING_INTERVAL_BASE) "stringTableSwitchingIntervalBase"
  set desc(TX_MINDELAY_UNIT) "stringTableTxMinDelayUnit"
  set desc(REFERENCE_RUNNING_TIME_BOTTOM_TOP_UNIT) "stringTableTimeBottomTopUnit"
  set desc(REFERENCE_RUNNING_TIME_TOP_BOTTOM_UNIT) "stringTableTimeTopBottomUnit"
  set desc(REFERENCE_RUNNING_TIME_SLATS_UNIT) "stringTableTimeSlatsUnit"
  set desc(BLOCKING_PERIOD_UNIT) "stringTableBlockingPeriodUnit"
  set desc(EVENT_FILTER_NUMBER) "stringTableEventFilterNumber"
  set desc(EVENT_FILTER_NUMBER_A) "stringTableEventFilterNumberA"
  set desc(INTERVAL_UNIT) "stringTableCalibrationIntervalUnit"

  # Special handling of parameters
  if {[string equal $extraparam 'rainDrop'] != 1} {
    set desc(EVENT_BLINDTIME_BASE) "stringTableEventBlindTimeBase"
  } else {
    # special for rain recognition
    set desc(EVENT_BLINDTIME_BASE) "eventTimeoutBaseRainDrop"
  }

  if {[string equal $extraparam 'rainCounter'] != 1} {
    set desc(EVENT_TIMEOUT_BASE) "stringTableEventTimeoutBase"
  } else {
    # special for rain counter
    set desc(EVENT_TIMEOUT_BASE) "eventTimeoutBaseRainCounter"
  }

  if {[catch {set result $desc($param)}]} {
   return $result
  }
  return $result
}

proc getMaintenanceAddress {channelAddress} {
  set parentAddress [lindex [split $channelAddress :] 0]
  return "$parentAddress:0"
}

proc getChannel {special_input_id} {
  return [lindex [split $special_input_id _] 1]
}

proc getSpecialID {special_input_id} {
    return "[lindex [split $special_input_id _] 0]"
}

proc isLongKeypressAvailable {sender sender_address url} {

  # Here we check for certain device types without a long keypress.
  set devWithoutLongKeyPress {
    HmIP-ASIR
  }

  foreach item $devWithoutLongKeyPress {
    if {$item == $sender} {return false}
  }

  # Here we test for all devices with a long keypress available, if the config parameter LONG_PRESS_TIME is set to a value == 0.
  # If true, the long keypress doesn't work and should not be available for easymode profiles.
  set result true
  catch {
    array set sender_ch_ps [xmlrpc $url getParamset $sender_address MASTER]
    if {$sender_ch_ps(LONG_PRESS_TIME) == 0.000000} {
      set result false
    }
  }
  return $result
}

proc devIsPowerMeter {devType} {
  # puts "devType: $devType<br/>"

  switch [string tolower $devType] {
    hmip-bsm  {return true}
    hmip-fsm  {return true}
    hmip-fsm16  {return true}
    hmip-psm  {return true}
    hmip-psm-2  {return true}
    "hmip-psm-2 qhj"  {return true}
    hmip-usbsm  {return true}
    default {return false}
  }
}

proc getDevFirmware {} {
  global dev_descr
  return $dev_descr(FIRMWARE)
}

proc getDevFwMajorMinorPatch {} {
  global dev_descr

  # Firmware = x.y.z
  set firmWare $dev_descr(FIRMWARE)
  set fwMajorMinorPatch [split $firmWare .]

  set fw {}

  lappend fw [expr [lindex $fwMajorMinorPatch 0] * 1]
  lappend fw [expr [lindex $fwMajorMinorPatch 1] * 1]
  lappend fw [expr [lindex $fwMajorMinorPatch 2] * 1]

  return $fw
}

proc getReceiverFw {} {
  global url receiver_address dev_descr_receiver
  array set dev_descr [xmlrpc $url getDeviceDescription $dev_descr_receiver(PARENT)]

  # Firmware (wthFw) = x.y.z
  set wthFw $dev_descr(FIRMWARE)
  set fwMajorMinorPatch [split $wthFw .]

  set fw {}

  lappend fw [expr [lindex $fwMajorMinorPatch 0] * 1]
  lappend fw [expr [lindex $fwMajorMinorPatch 1] * 1]
  lappend fw [expr [lindex $fwMajorMinorPatch 2] * 1]

  return $fw
}


# This can be used to return the original parameter name of a translation key
proc extractParamFromTranslationKey {key} {

  # A parameter key looks like ${thisIsTheKey}
  # Here we remove the leading '${' and the trailing '}' so that we have the clean key
  set key [string trim [string trim $key "\$\{"] "\}"]

  set ret ""
  switch $key {
    "channelModeTactileSwitch" {set ret TACTILE_SWITCH_INPUT}
  }
  return $ret
}

# Some wall thermostats don't have a humidity sensor.
# We have to consider this in some easymodes.
# With this function you can maintain a list of such devices.
proc hasSenderHumiditySensor {} {
  global dev_descr_sender
  set senderType $dev_descr_sender(PARENT_TYPE)
  set result true

  # List with thermostats without a humidity sensor
  set devHasNoHumiditySensor {ALPHA-IP-RBGa}

  foreach val $devHasNoHumiditySensor {
    if {$val == $senderType} {
      set result false
    }
  }
  return $result
}