##
# User.startHmIPServer
# Startet den HMIPServer
#
# Parameter:
#   keine
#
# Rückgabewert: true

exec monit start HMIPServer >/dev/null &
jsonrpc_response true
