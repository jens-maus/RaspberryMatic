##
# CCU.setFirewallConfigured
#Legt die Datei /etc/config/firewallConfigured an
#
# Parameter:
#  userName
#
# Rückgabewert: immer true
##

catch {exec touch /etc/config/systemLanguageConfigured}

jsonrpc_response true


