##
# User.createCertificate
# Erstellt ein neues Zertifikat unter /etc/config/server.pem
#
# Parameter:
#   country  : [string] Landeskuerzel (z.B. DE)
#   hostname : [string] Der CN Hostname der eintragen werden soll
#   email    : [string] EMail-Adresse die eingetragen werden soll
#   serial   : [string] Die Seriennummer der CCU
##

if { $args(hostname) != "" } then {
  # Zertifikat erzeugen
  exec /usr/bin/openssl req -new -x509 -nodes -keyout /etc/config/server.pem \
                                              -out /etc/config/server.pem \
                                              -days 3650 \
                                              -subj "/C=$args(country)/emailAddress=$args(email)/O=HomeMatic/OU=$args(serial)/CN=$args(hostname)" 2>/dev/null >/dev/null

  jsonrpc_response true
} else {
  jsonrpc_response false
}
