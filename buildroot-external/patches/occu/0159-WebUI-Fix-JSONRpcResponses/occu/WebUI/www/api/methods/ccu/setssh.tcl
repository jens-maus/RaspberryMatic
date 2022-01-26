##
# CCU.setSSH
# Aktiviert oder. deaktiviert den SSH-Zugang der HomeMatic Zentrale
#
# Parameter:
#  mode         : [bool]   aktivieren (true) bzw. deaktivieren (false)
#
# Rückgabewert: kein
##

set activate $args(mode);

if {$activate == "true"} {
  catch {exec touch /etc/config/sshEnabled}
} else {
  catch {exec rm /etc/config/sshEnabled}
}

source "/bin/setfirewall.tcl"

jsonrpc_response ""
