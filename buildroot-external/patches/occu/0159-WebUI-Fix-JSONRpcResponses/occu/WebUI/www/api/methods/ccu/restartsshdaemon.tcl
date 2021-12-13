##
# CCU.restartSSHDaemon
# Restartet den SSH-Daemon
#
# Parameter: kein
#
# Rückgabewert: kein
##

catch {exec /etc/init.d/S50sshd restart}

jsonrpc_response ""
