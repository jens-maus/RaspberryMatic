##
# CCU.setSSHPassword
# Ändert das Passwort des SSH-Zugangs
#
# Parameter:
#  passwd         : [string] Passwort
#
# Rückgabewert: "noError" oder sed-Fehlermeldung
##

  set digest [exec mkpasswd -m sha512 "$args(passwd)"]
  set command "s%^root:\\(\[^:\]*:\\)%root:$digest:%"
  set rc [catch {exec sed -i "$command" /etc/config/shadow} msg]

  if {$msg == ""} {
   set msg "noError"
  }

  set result "\{\"msg\" : [json_toString $msg]\}"

  jsonrpc_response $result
