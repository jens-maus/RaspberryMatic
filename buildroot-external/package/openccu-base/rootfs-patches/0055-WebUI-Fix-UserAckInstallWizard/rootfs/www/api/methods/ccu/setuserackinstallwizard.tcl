##
# CCU.setUserAckInstallWizard
# Legt die Datei/etc/config/userprofiles/userAckInstallWizard_USERNAME an
#
# Parameter:
#  userName
#
# Rückgabewert: immer true
##

set userName [string map {
                " " ";"
                "/" ""
                "Ä" "AE"
                "Ü" "UE"
                "Ö" "OE"
                "ä" "ae"
                "ü" "ue"
                "ö" "oe"
                "ß" "ss"
             } $args(userName)]

regsub -all {[^\u0020-\u007e]+} $userName "" userName

catch {exec touch /etc/config/userprofiles/userAckInstallWizard_$userName}

jsonrpc_response true
