##
# User.restartLighttpd
# Restartet den Lighttpd Webserver
#
# Parameter:
#   keine
#
# Rückgabewert: true


exec /etc/init.d/S50lighttpd reload &

jsonrpc_response true