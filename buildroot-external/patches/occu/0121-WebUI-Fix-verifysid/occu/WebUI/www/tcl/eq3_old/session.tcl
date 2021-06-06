#!/bin/tclsh
source once.tcl
sourceOnce cgi.tcl
sourceOnce user.tcl
loadOnce tclrega.so

set sidname "icsessionid"

set SESSIONS_FILE "/var/SESSIONS.dat"

#Nur für Entwicklung auf 6000 gesetzt.
set session_timeout 6000
#set session_timeout 600

set sid_length 10
set MAX_SESSIONS 10

array set sessions_uid ""
array set sessions_lastactivity ""
array set sessions_redirect ""

#=======================================================================
#Funktionen dieses Moduls (nicht vollständige Liste)
#=======================================================================
#proc session_requestisvalid {needed_upl} {
#proc session_upl {} {
#proc session_putsessiontimedout {url} {
#proc session_putinsufficientrights {url} {
#proc session_puttoomuchsessions {} {
#proc session_appendsid2url {url sid} {
#proc session_geturlnewsid {newsid} {
#proc session_geturlwithoutsid {} {
#proc session_deletetimedoutsessions {} {
#proc session_generatesession {{uid 0} {redirect ""}} {
#proc session_generatesid {length} {
#proc session_isvalid {} {
#proc session_ResetTimeOut {} {
#proc session_ResetTimeOut_sid {sid} {
#proc session_isTimedOut {} {
#proc session_urlsidexists {} {
#proc session_urlsid {} {
#proc session_setuid {uid} {
#proc session_setuid_sid {uid sid} {
#proc session_uid {} {
#proc session_uid_sid {sid} {
#proc session_getcurURL {} {
#proc session_setURLredirect {} {
#proc session_setredirect {redirect} {
#proc session_setredirect_sid {redirect sid} {
#proc session_redirecturl {redirecturl} {
#proc session_redirecturl_sid {redirecturl sid} {
#proc write_sessions {} {
#proc read_sessions {} {
#=======================================================================

proc read_sessions {} {
    global SESSIONS_FILE sessions_uid sessions_lastactivity sessions_redirect

	if { ! [catch {open $SESSIONS_FILE RDONLY} f] } then {
	
		set count 0
		while {1} {
		
			gets $f zeile
			incr count

			if { [eof $f] || [string equal $zeile "<."] } break

			if { $count > 1 } then {
			
				if { [regexp {^(@[A-Za-z0-9]*@);([0-9]*);([0-9]*);(.*)$} $zeile dummy sid uid lastactivity redirect] } then {

					array set sessions_uid          [list $sid $uid]
					array set sessions_lastactivity [list $sid $lastactivity]
					array set sessions_redirect     [list $sid $redirect]
				}
			}
		}

		close $f

	} else {

		#puts $f
		#puts "Could not open sessions file for reading, so i will create a basic sessions file."
		write_sessions
	}
}

proc write_sessions {} {
	
    global SESSIONS_FILE sessions_uid sessions_lastactivity sessions_redirect

	session_deletetimedoutsessions

	if { ! [catch {open $SESSIONS_FILE w} f] } then {
	
		puts $f "SID;UID;LastActivity;RedirectURL"
		
		foreach key [array names sessions_uid] {
		
			set uid       $sessions_uid($key)
			set lactivity $sessions_lastactivity($key)
			set redirect  $sessions_redirect($key)
			
			puts $f "$key;$uid;$lactivity;$redirect"
		}
		
		puts $f "<."

		close $f

	} else {

		#puts "Could not open sessions file for writing."
		#puts $f
	}
}

#-1: keine sid in der URL übergeben
# 1: redirect gesetzt
proc session_redirecturl_sid {redirecturl sid} {

	global sessions_redirect
	upvar $redirecturl redirect
	
	set ret -1
	set redirect ""
	
	if { ! [catch { set redirect $sessions_redirect($sid)  }]   } then {
		set ret 1
	}

	return $ret
}

#-1: keine sid in der URL übergeben
# 1: redirect gesetzt
proc session_redirecturl {redirecturl} {

	global sessions_redirect
	upvar $redirecturl redirect
	set sid [session_urlsid]

	if { [string equal $sid ""] } then {
		return -1
	}
	
	set redirect ""
	catch { [set redirect $sessions_redirect($sid) ] }

	return 1
}

proc session_setredirect_sid {redirect sid} {

	global sessions_redirect
	set ret -1
	
	if { ![catch {set test $sessions_redirect($sid)} ] } then {

		set sessions_redirect($sid) $redirect
		set ret 1
	}

	return $ret
}

#<0: Rückgabe wie proc session_isvalid
# 1: redirect gesetzt
proc session_setredirect {redirect} {

	global sessions_redirect

	set s_ok [session_isvalid]
	set ret $s_ok
	set sid [session_urlsid]

	if {$s_ok >= 0} then {
		set sessions_redirect($sid) $redirect
		set ret 1
	}

	return $ret
}

proc session_setURLredirect {} {

	set url [session_getcurURL]
	set ret [session_setredirect $url]
}

proc session_getcurURL {} {

	global env

	set params ""
	catch { set params "?$env(QUERY_STRING)" }
	
	return "http://$env(HTTP_HOST)$env(SCRIPT_NAME)$params"
}

#-2: keine sid übergeben
#-1: keine uid in der Session vorhanden oder session nicht existent (Fehler)
# 0: keine uid in der session vergeben
#>0: uid der session
proc session_uid_sid {sid} {

	global sessions_uid

	if { [string equal $sid ""] } then {
		return -2
	}
	
	set uid ""
	catch { [set uid $sessions_uid($sid) ] }

	if { [string equal "" $uid] } then {
		return -1
	}

	return $uid
}

#-2: keine sid in der URL übergeben
#-1: keine uid in der Session vorhanden oder session nicht existent (Fehler)
# 0: keine uid in der session vergeben
#>0: uid der session
proc session_uid {} {

	global sessions_uid

	set sid [session_urlsid]

	if { [string equal $sid ""] } then {
		return -2
	}
	
	set uid ""
	catch { [set uid $sessions_uid($sid) ] }

	if { [string equal "" $uid] } then {
		return -1
	}

	return $uid
}

#-1: session nicht existent. uid nicht gesetzt
# 1: UID erfolgreich gesetzt
proc session_setuid_sid {uid sid} {

	global sessions_uid
	set ret -1
	
	if { ![catch {set test $sessions_uid($sid)} ] } then {

		set sessions_uid($sid) $uid
		set ret 1
	}

	return $ret
}

#-1: Fehler durch proc session_isvalid
# 0: UID ist schon gesetzt
# 1: UID erfolgreich gesetzt
proc session_setuid {uid} {

	global sessions_uid

	set s_ok [session_isvalid]
	set sid [session_urlsid]
	set ret 0

	if {$s_ok < 0} then {
		set ret -1
	} elseif {$s_ok > 0} then {
		set ret 0
	} else {
		set sessions_uid($sid) $uid
		set ret 1
	}

	return $ret
}

#== "" wenn keine (gültige) sid in der URL
#!= "" sid der URL
proc session_urlsid { {p_tmp_sidname ""} } {

	global env sidname

	set queryparams ""
	catch { set queryparams $env(QUERY_STRING) }
	set queryparams [cgi_unquote_input $queryparams]

	if {$queryparams == ""} then { return "" }

	#Austausch gegen übergebenen Namen?
	set oldsid ""
	if {$p_tmp_sidname != ""} then {
		#Sichern:
		set oldsid $sidname
		#Überschreiben
		set sidname $p_tmp_sidname
	}
	#-----

	set querysid ""
	if { ![regexp "$sidname=(@\[A-Za-z0-9\]*@)" $queryparams dummy querysid] } then {

		#sid konnte nicht aus der URL extrahiert werden.
		#Versuche sid aus den POST-Parametern zu bestimmen.
		set sid ""
		catch { import_as $sidname sid }
		set querysid $sid
	}

	#Rücktausch nötig?
	if {$oldsid != ""} then {
		#Wiederherstellen
		set sidname $oldsid
	}
	#-----

	return $querysid
}

#Diese Funktion liefert eine sid ohne die umschließende @-Zeichen
#== "" wenn keine (gültige) sid in der URL
#!= "" sid der URL
proc session_urlsid_short {} {

	set sid [session_urlsid]
	set mod_sid ""

	regexp {^@([a-zA-Z0-9]*)@$} $sid dummy mod_sid

	return $mod_sid
}

#urlsid existiert in der Sessionliste?
#0: urlsid not exists
#1: urlsid exists
proc session_urlsidexists {} {

	global sessions_uid
	set sid [session_urlsid]
	set ret 0
	

	if { [string equal $sid ""] } then {
		return 0
	}
	
	set uid ""
	catch { [set uid $sessions_uid($sid) ] }

	if { ![string equal "" $uid] } then {
		set ret 1
	}

	return $ret
}

#1: session timed out oder session not available
#0: not timed out
proc session_isTimedOut {} {

	global sessions_lastactivity session_timeout
	set ret 1
	set lactivity 0
	set sid [session_urlsid]

	catch { [set lactivity $sessions_lastactivity($sid)] }

	set now [clock format [clock sec] -format "%s"]

	if { $lactivity > 0 && [expr $now - $lactivity <= $session_timeout] } then {
		set ret 0
	}

	return $ret
}

#-1: session zu der sid nicht gefunden
# 1: timeout erfolgreich reseted
proc session_ResetTimeOut_sid {sid} {

	global sessions_lastactivity
	set ret -1

	if { ! [catch { set lactivity $sessions_lastactivity($sid)  }]   } then {
	
		set now [clock format [clock sec] -format "%s"]
		set sessions_lastactivity($sid) $now
		set ret 1
	}

	return $ret
}

#<= -2: Bedeutung wie proc session_isvalid
#    1: aktuelle Zeit gesetzt
proc session_ResetTimeOut {} {

	global sessions_lastactivity

	set s_ok [session_isvalid]

	if {$s_ok <= -2} then {
		return $s_ok
	}

	set now [clock format [clock sec] -format "%s"]
	set sid [session_urlsid]
	set sessions_lastactivity($sid) $now

	return 1
}

#-3: keine (gültige) sid in der url übergeben
#-2: Session ist nicht existent
#-1: Session timed out
# 0: User nicht gesetzt, aber Session gültig
#>0: Session gültig. Rückgabe ist die UID der Session
proc session_isvalid {} {

	if { [string equal "" [session_urlsid]] } then {
		return -3
	}
	
	if {[session_urlsidexists] == 0} then {
		return -2
	}

	if {[session_isTimedOut] == 1} then {
		return -1
	}

	set uid [session_uid]

	return $uid
}

proc session_generatesid {length} {
                           
	set sid ""
	set coding_chars [list "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" \
    	"Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z" "0" "1"  "2" "3" "4" "5" "6" "7" "8" "9" \
    	"a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" "u" \
    	"v" "w" "x" "y" "z"]
	
	for {set i 0} {$i < $length} {incr i} {

		#rNum [0;62]
		set r [expr rand()]
		set rNum [expr int($r * 61)]
		set sid $sid[lindex $coding_chars $rNum]
	}

	set sid "@$sid@"

	return $sid
}

#return: -2:    session konnte nicht übergebener sid nicht angelegt werden, weil sid schon vorhanden
#return: -1:    zu viele Sessions
#        sonst: neue sid
proc session_generatesession {{uid 0} {redirect ""} {sid ""}} {

	global sessions_uid sessions_lastactivity sessions_redirect sid_length MAX_SESSIONS

	if {[array size sessions_uid] >= $MAX_SESSIONS} then {
		return "-1"
	}

	if {$sid == ""} then {
		set sid [session_generatesid $sid_length]

		while { ! [ catch {info exists $sessions_uid($sid) } ] } {
			#sid schon existent! Andere sid ziehen:
			set sid [session_generatesid $sid_length]
		}
	} elseif { ! [ catch {info exists $sessions_uid($sid) } ] } {
		#sid schon existent! Session braucht nicht neu angelegt werden, sondern nur aktualisiert.
		return -2
	}
	
	set now [clock format [clock sec] -format "%s"]

	array set sessions_uid          [list $sid $uid]
	array set sessions_lastactivity [list $sid $now]
	array set sessions_redirect     [list $sid $redirect]

	return $sid
}

#return: number of deleted sessions
proc session_deletetimedoutsessions {} {

	global sessions_uid sessions_lastactivity session_timeout sessions_redirect

	set now [clock format [clock sec] -format "%s"]
	set count 0

	foreach key [array names sessions_uid] {
		
		set lactivity $sessions_lastactivity($key)

		if { [expr $now - $lactivity > $session_timeout] } then {

			unset sessions_uid($key)
			unset sessions_lastactivity($key)
			unset sessions_redirect($key)
			incr count
		}
	}

	return $count
}

proc session_geturlwithoutsid {} {

	global env sidname

	set queryparams ""
	catch { set queryparams $env(QUERY_STRING) }
	set queryparams [cgi_unquote_input $queryparams]
	set querylen [string length $queryparams]

	if {$querylen == 0} then {
	
		return "http://$env(HTTP_HOST)$env(SCRIPT_NAME)"
	}

	if { [string index $queryparams end] == "&" || [string index $queryparams end] == "?" } then {

		decr querylen
		set queryparams [string range $queryparams 0 $querylen]
	}

	if { [regexp {(.*)(icsessionid=@[A-Za-z0-9]*@)(.*)} $queryparams dummy prev sid post] || [regexp {(.*)(sid=@[A-Za-z0-9]*@)(.*)} $queryparams dummy prev sid post] } then {

		set prevlen [string length $prev]
		set postlen [string length $post]

		if {$prevlen > 0} then {
			
			if {[string index $prev end] == "&"} then {

				decr prevlen 2
				set prev [string range $prev 0 $prevlen]

				incr prevlen
			}
		}

		if {$postlen > 0} then {

			if {[string index $post 0] == "&"} then {

				set post [string range $post 1 end]
				decr postlen
			}
		}
		
		if { $prevlen > 0 && $postlen > 0 } then {
			set queryparams $prev&$post
		} else {
			set queryparams $prev$post
		}

		set querylen [string length $queryparams]
	}

	if {$querylen > 0} then {
		set url "http://$env(HTTP_HOST)$env(SCRIPT_NAME)?$queryparams"
	} else {
		#params bestanden nur aus der sid, die nun wegfällt.
		set url "http://$env(HTTP_HOST)$env(SCRIPT_NAME)"
	}

	return [cgi_quote_html $url]
}

proc session_geturlnewsid {newsid} {

	global sidname

	set url [session_geturlwithoutsid]
	set separator "?"
	
	#'?' enthalten? Ja: es gibt es schon Parameter 
	#und die sid wird mit einem '&' angehängt
	if {[string first "?" $url] > -1} then {
		set separator "&"
	}

	set sidstr "$sidname=$newsid"
	set url $url$separator$sidstr

	return $url
}

proc session_appendsid2url {url sid} {

	global sidname

	set url [cgi_unquote_input $url]
	set urllen [string length $url]

	if { [string index $url end] == "&" || [string index $url end] == "?" } then {

		decr urllen 2
		set url [string range $url 0 $urllen]
		incr urllen
	}

	set separator "?"

	#'?' enthalten? Ja: es gibt es schon Parameter 
	#und die sid wird mit einem '&' angehängt
	if {[string first "?" $url] > -1} then {
		set separator "&"
	}

	set sidstr "$sidname=$sid"
	set url $url$separator$sidstr

	return $url
}

proc session_puttoomuchsessions {} {

	html {
		head {
			title "eQ-3 HomeMatic Konfiguration - Anmeldung"
    		puts "<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">"
		}
		body {
			h2 "Zu viele gleichzeitige Verbindungen!"
        	h2 [url "Zurück" "javascript:history.back()"]
		}
	}
}

proc session_putinsufficientrights {url} {

	html {
		head {
			title "eQ-3 HomeMatic Konfiguration - Anmeldung"
    		puts "<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">"
		}
		body {
			h2 "Sie haben zu wenig Rechte für diese Operation!"
        	h2 [url "Benutzer wechseln" $url]
        	h2 [url "Zurück" "javascript:history.back()"]
		}
	}
}

proc session_putsessiontimedout {url} {

	html {
		head {
			title "eQ-3 HomeMatic Konfiguration - Anmeldung"
    		puts "<link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\">"
		}
		body {
			h2 "Sitzung ung&uuml;ltig oder abgelaufen!"
#        	h2 [url "Weiter" $url]
			puts "<div class=\"CLASS10600\"><a href=\"#\" onclick=\"javascript:reloadPage();\">Weiter</a></div>"
		}
	}
}

#   -2: uid konnte nicht bestimmt werden zur aktuellen Session
#   -1: upl nicht gefunden
#>=  0: upl des users
proc session_upl {} {

	set uid [session_uid]
	set upl -2

	if {$uid > 0} then {
	
		set upl [user_upl $uid]
	}

	return $upl
}

#return: -4: user hat nicht genügend UPL (Rechte)
#sonst:      siehe session_isvalid
#
#Eingabeparameter needed_upl: Benötigte upl für 
#diese Aktion (0: jeder hat Zugriff)
proc session_requestisvalid {needed_upl} {

	global sidname sid

	if {$sidname == "sid" && $sid != ""} then {
		return [session_requestisvalid_ise $needed_upl]
	}
	
	set uid [session_isvalid]
	set upl [session_upl]

	if {$uid == -3 || $uid == -2 || $uid == -1 || $uid == 0} then {
		#-3: "keine sid in der url"
		#-2: "session ist nicht existent"
		#-1: "session timed out"
		# 0: "user nicht gesetzt"
	
		set url [session_geturlwithoutsid]

		session_putsessiontimedout $url
	
	} elseif {$upl < 0 || $upl < $needed_upl} then {
		#upl<0: "User nicht bekannt"
		#sonst: "UPL des Users reicht nicht für diese Operation aus."

		set uid -4
		set url [session_geturlwithoutsid]
		
		session_ResetTimeOut
		write_sessions

		session_putinsufficientrights $url

	} else {
		#Session gültig. User hat genug Rechte. Content laden!

		session_setURLredirect
		session_ResetTimeOut
		write_sessions
	}

	return $uid
}

read_sessions

#Um was für einen Aufruf handelt es sich? Ist der URL-Parameter "sid" in der URL,
#dann kommt der Aufruf von ise und es soll die Sessionverwaltung von ise benutzt werden.
#if { [string first "sid=" [session_getcurURL]] > -1 || ![catch {import_as "sid" s}] } then {
#if { ![catch {import_as "sid" s}] } then {
if {[session_urlsid "sid"] != "" || ![catch {import_as "sid" s}] || [string first "sid=" [session_getcurURL]] > -1 } then {
	set sidname "sid"
} else {
	set sidname "icsessionid"
}

set sid [session_urlsid]
set urlsid $sidname=$sid

#puts $urlsid

#puts [session_appendsid2url "http://127.0.0.1/devconfig.cgi" "@78d9f0@"]
#puts [session_appendsid2url "http://127.0.0.1/devconfig.cgi?" "@78d9f0@"]
#puts [session_appendsid2url "http://127.0.0.1/devconfig.cgi&" "@78d9f0@"]
#puts [session_appendsid2url "http://127.0.0.1/devconfig.cgi?param=44" "@78d9f0@"]
#puts [session_appendsid2url "http://127.0.0.1/devconfig.cgi?param2=34&dfak=4" "@78d9f0@"]

#session_geturlwithoutsid

#puts [session_setuid_sid 4711  "@tSnsOXIvUA@"]
#puts [session_setuid_sid 4711  "@tSnsOIvUA@"]

#puts [session_ResetTimeOut_sid "@dasf3@"]
#puts [session_ResetTimeOut_sid "@tSnsOXIvUA@"]

#puts [session_redirecturl_sid redirect "@tSnXIvUA@"]
#puts [session_redirecturl_sid redirect "@tSnsOXIvUA@"]

#puts $redirect

#puts [session_geturlnewsid "@7dfa8c@"]

#puts [session_setredirect "http://www.elv.de"]
#puts [session_urlsid]

#session_generatesession
#session_ResetTimeOut

#write_sessions
#}

#======================================================================
#======================================================================
#======================================================================
#Funktionen fürs ise ReGa
#======================================================================
#======================================================================
#======================================================================

#-2: ise-Session existiert nicht
#-1: Fehler im Format der ise-Rückgabe
# 1: ok
proc session_getsessiondata_ise {} {

	global REGA_SESSION

	array set result [rega_script "string sd = system.GetSessionVarStr(\"$REGA_SESSION(REGASID)\");"]

	set data $result(sd)

	if {$data == ""} then {return -2}

	#                uid      upl      user-   first-  last-name
	if { ! [regexp {^([0-9]*);([0-9])*;([^;]*);([^;]*);([^;]*);$} $data dummy uid upl username firstname lastname] } then {
		return -1
	}

	set REGA_SESSION(UID)       $uid
	set REGA_SESSION(UPL)       $upl
	set REGA_SESSION(USERNAME)  $username
	set REGA_SESSION(FIRSTNAME) $firstname
	set REGA_SESSION(LASTNAME)  $lastname
	set REGA_SESSION(EXPERT)    [user_isExpert_ise $uid]

	session_generatesession $REGA_SESSION(UID) "" $REGA_SESSION(SID)
	session_setURLredirect
	session_ResetTimeOut
	write_sessions

	return 1
}

#-3: keine (gültige) ReGa-sid in der url übergeben
#-2: Session existiert im Programm ise ReGa nicht
#>0: Session gültig. Rückgabe ist die UID der Session
proc session_isvalid_ise {} {

	global REGA_SESSION

	if { [string equal "" $REGA_SESSION(SID)] } then {
		return -3
	}

	set iseret [session_getsessiondata_ise]

	if {$iseret < 0} then {
		return -2
	}

	return $REGA_SESSION(UID)
}

#return: -4: user hat nicht genügend UPL (Rechte)
#sonst:      siehe session_isvalid
#
#Eingabeparameter needed_upl: Benötigte upl für 
#diese Aktion (0: jeder hat Zugriff)
proc session_requestisvalid_ise {needed_upl} {

	global REGA_SESSION

	set uid [session_isvalid_ise]
	set upl $REGA_SESSION(UPL)

	if {$uid == -3} then {
		#"keine sid in der url"
		html { puts "<div class=\"CLASS10600\"><a href=\"#\" onclick=\"javascript:reloadPage();\">Weiter</a></div>" }
	} elseif {$uid <= 0} then {
		#-2: "Session existiert nicht"
		html { puts "<div class=\"CLASS10600\"><a href=\"#\" onclick=\"javascript:reloadPage();\">Weiter</a></div>" }
	} elseif {$upl < 0 || $upl < $needed_upl} then {
		#-4: "UPL des Users reicht nicht für diese Operation aus."
		html { puts "<div class=\"CLASS10600\"><a href=\"#\" onclick=\"javascript:reloadPage();\">Weiter</a></div>" }
		set uid -4
	} else {
		#>0: Session gültig. User hat genug Rechte. Content laden!
	}

	return $uid
}

#
#Liefert zurück, ob der Expertenmodus für den aktuellen User aktiviert ist
#
proc session_is_expert {} {
    global REGA_SESSION
    return $REGA_SESSION(EXPERT)
}

set REGA_SESSION(SID)       $sid
set REGA_SESSION(REGASID)   [session_urlsid_short]
set REGA_SESSION(UID)       ""
set REGA_SESSION(UPL)       ""
set REGA_SESSION(USERNAME)  ""
set REGA_SESSION(FIRSTNAME) ""
set REGA_SESSION(LASTNAME)  ""
set REGA_SESSION(EXPERT)    ""

#======================================================================
#======================================================================
#======================================================================
