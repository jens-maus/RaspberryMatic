##
# CCU.systemLanguageConfigured
#Legt die Datei /etc/config/systemLanguageConfigured an
#
# Parameter:
#  lang
#
# Rückgabewert: immer true
##

catch {exec echo $args(lang) > /etc/config/systemLanguageConfigured}

jsonrpc_response true


