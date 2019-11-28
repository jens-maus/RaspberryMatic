##
# system.getPositionData
# Gibt die gespreicherten Positionsdaten Longitude und Latitude zurück
#
# Parameter:
#   keine
#
# Rückgabewert: [array]
#  Die einzelnen Elemente sind Zeichenketten, welche die Longitude, Latitude, TimeZone enthalten
#
##

proc read_var {filename varname} {
    set fd [open $filename r]
    set var ""
    if { $fd >=0 } {
        while { [gets $fd buf] >=0 } {
          if [regexp "^ *$varname *= *(.*)$" $buf dummy var] break
        }
      close $fd
    }
    return $var
}

set script {
  Write("['Longitude:"#system.Longitude()#"','Latitude:"#system.Latitude()#"'");
}

set posData [hmscript $script]

# get utcOffset and utcOffsetDST using clock command
proc tz2offset {tstr} {
  regsub {^(\+|-)0*(.*)} [string range $tstr 0 2] {\1} sign
  regsub {^(\+|-)0*(.*)} [string range $tstr 0 2] {\2} hour
  regsub {^0?(.*)} [string range $tstr 3 4] {\1} min
  set h [expr $hour * 60]
  set m [expr $min * 1]
  set time [expr $sign ($h + $m)]
  return $time
}
set utcOffset [tz2offset [clock format [clock scan "01 Jan"] -format "%z"]]
set utcOffsetDST [tz2offset [clock format [clock scan "01 Jul"] -format "%z"]]

# append the utcOffset and utcOffsetDST
append posData ",'utcOffset:$utcOffset','utcOffsetDST:$utcOffsetDST']"

jsonrpc_response $posData
