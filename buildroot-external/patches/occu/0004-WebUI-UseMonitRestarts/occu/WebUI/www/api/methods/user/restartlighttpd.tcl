##
# User.restartLighttpd
# Restartet den Lighttpd Webserver
#
# Parameter:
#   keine
#
# Rückgabewert: true

exec /usr/bin/monit restart lighttpd

jsonrpc_response true
