##
# User.stopHmIPServer
# Stoppt den HMIPServer
#
# Parameter:
#   keine
#
# Rückgabewert: true

exec monit stop HMIPServer >/dev/null &
jsonrpc_response true
