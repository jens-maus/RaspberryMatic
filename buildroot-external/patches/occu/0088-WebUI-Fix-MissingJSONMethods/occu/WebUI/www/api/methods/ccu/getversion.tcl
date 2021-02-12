##
# CCU.getVersion
# Liefert die Firmware-Version der HomeMatic Zentrale
#
# Parameter: <keine>
#
# Rückgabewert: [string]
#  Firmware-Version der HomeMatic Zentrale
##

proc read_var { filename varname} {
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

proc get_version { } {
    return [read_var /VERSION VERSION]
}

jsonrpc_response [json_toString [get_version]]
