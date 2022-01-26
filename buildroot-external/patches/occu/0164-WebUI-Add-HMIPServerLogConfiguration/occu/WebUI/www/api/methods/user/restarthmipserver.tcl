##
# User.restartHmIPServer
# Restartet den HMIPServer
#
# Parameter:
#   keine
#
# Rückgabewert: true

#exec /etc/init.d/S62HMServer start &
exec monit restart HMIPServer >/dev/null &
jsonrpc_response true
