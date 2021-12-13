##
# CCU.hideStickyUnreach
# Aktiviert oder. deaktiviert die Sichtbarkeit der STICKY-UNREACH Servicemeldungen
#
# Parameter:
#  mode: [bool]   Hide (true) Show (false)
#
# Rückgabewert: kein
##

set hide $args(mode);

if {$hide == "true"} {
  catch {exec touch /etc/config/hideStickyUnreach}
} else {
  catch {exec rm /etc/config/hideStickyUnreach}
}

jsonrpc_response ""
