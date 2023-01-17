##
# Session.renew
# Erneuert die Sitzung
#
# Parameter:
#   _session_id_: [string] Id der Sitzung
#
# Rückgabewert:
#   true
##

package require http

set sid $args(_session_id_)
set url "127.0.0.1/pages/index.htm?sid=@$sid@"

::http::cleanup [::http::geturl $url]

jsonrpc_response true
