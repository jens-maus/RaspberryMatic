#!/bin/tclsh

proc getWeeklyProgram {address p} {

  upvar $p ps

    global iface
    set html ""

    puts "<script type=\"text/javascript\">load_JSFunc('/config/easymodes/js/CC.js');load_JSFunc('/config/easymodes/MASTER_LANG/HEATINGTHERMOSTATE_2ND_GEN.js');</script>"

    append html "<div id=\"Timeouts_Area\" style=\"display:none\">"
    #Die DIV - Tags müssen schon existieren, wenn man in die Funktion tom.setTemp geht
    foreach day {SATURDAY SUNDAY MONDAY TUESDAY WEDNESDAY THURSDAY FRIDAY} {
      append html "<div id=\"temp_prof_$day\"></div>"
    }
    append html "</div>"

    append html "<script type=\"text/javascript\">"
    append html "P1_tomHmIP = new TimeoutManagerHmIPOnOff('$iface', '$address', false, 'P1_');"

    foreach day {SATURDAY SUNDAY MONDAY TUESDAY WEDNESDAY THURSDAY FRIDAY} {

      for {set i 1} {$i <= 11} {incr i} {

        set timeoutHour     $ps(P1_HOUR_${day}_$i)
        set timeoutMinute   $ps(P1_MINUTE_${day}_$i)
        set level $ps(P1_LEVEL_${day}_$i)

        set timeout [expr ($timeoutHour * 60) + $timeoutMinute]

        #puts "$day --- timeout: $timeout >>  $timeoutHour - $timeoutMinute - $level<br/>"


        append html "P1_tomHmIP.setValue('$day', $timeout, $level);"

        if {$timeout == 1440} then {
          break;
        }
      }

      append html "P1_tomHmIP.setDivname('$day', 'temp_prof_$day');"
      append html "P1_tomHmIP.writeDayHmIPWeekProgramOnOff('$day');"
    }

    # TODO - Set the weekly program only visible while certain modes are active.
    # This has to be clarified with the developer of the device
    append html  "jQuery('#Timeouts_Area').show();"

    append html "</script>"

    return $html
}