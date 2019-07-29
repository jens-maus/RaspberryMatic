##
# Session.close
# Schließt eine Sitzung
#
# Parameter:
#   _session_id_: [string] Id des Session
#
# Rückgabewert: [bool]
#   true
##

hmscript {system.ClearSession(_session_id_);} args

jsonrpc_response true
