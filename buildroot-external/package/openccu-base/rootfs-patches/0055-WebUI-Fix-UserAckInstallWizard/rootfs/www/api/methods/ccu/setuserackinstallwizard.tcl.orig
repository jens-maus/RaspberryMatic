##
# CCU.setUserAckInstallWizard
# Legt die Datei/etc/config/userprofiles/userAckInstallWizard_USERNAME an
#
# Parameter:
#  userName
#
# Rückgabewert: immer true
##

catch {exec touch /etc/config/userprofiles/userAckInstallWizard_[string map {{ } ;} $args(userName)]}

jsonrpc_response true


