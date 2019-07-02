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

# Default timeZone
set timeZone CET/CEST

catch {set timeZone [read_var /etc/config/time.conf TIMEZONE]}

set script {
  ! system.TimeZoneOffset() doesn't contain the DST offset
  ! Write("['Longitude:"#system.Longitude()#"','Latitude:"#system.Latitude()#"','TimeZone:"#system.TimeZoneOffset()#"' ]");
  Write("['Longitude:"#system.Longitude()#"','Latitude:"#system.Latitude()#"'");
}

set posData [hmscript $script]
append posData ",'TimeZone:$timeZone']"

jsonrpc_response $posData