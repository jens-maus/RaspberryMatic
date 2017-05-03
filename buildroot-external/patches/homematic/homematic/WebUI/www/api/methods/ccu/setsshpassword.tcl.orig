##
# CCU.setSSHPassword
# Ändert das Passwort des SSH-Zugangs
#
# Parameter:
#  passwd         : [string] Passwort
#
# Rückgabewert: "noError" oder sed-Fehlermeldung
##


  package require md5crypt

  set digest [md5crypt::md5crypt $args(passwd) [md5crypt::salt]]
  set command "s%^root:\\(\[^:\]*:\\)%root:$digest:%"
  set rc [catch {exec sed -i "$command" /etc/config/shadow} msg]

  if {$msg == ""} {
   set msg "noError"
  }

  set result "\{\"msg\" : [json_toString $msg]\}"

  jsonrpc_response $result
