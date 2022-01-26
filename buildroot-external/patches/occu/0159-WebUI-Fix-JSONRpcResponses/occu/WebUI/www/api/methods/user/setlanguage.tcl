##
# User.setLanguage
# Speichert die vom User gewählte Sprache
#
# Parameter:
#   userName: [string] userName des Anwenders
#
# Rückgabewert: kein
##

set userName $args(userName)
set userName [string map {"\." "."} $userName]
set userName [string map {"\/" "/"} $userName]
set userName [string map {"../" ""} $userName]
exec echo $args(userLang) > /etc/config/userprofiles/$userName.lang

jsonrpc_response ""
