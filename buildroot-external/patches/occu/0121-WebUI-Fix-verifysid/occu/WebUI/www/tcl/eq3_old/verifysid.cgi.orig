#!/bin/tclsh
source once.tcl
sourceOnce cgi.tcl
sourceOnce session.tcl

cgi_eval {

	#cgi_debug -on
	cgi_input
	catch {
	    import debug
    	#cgi_debug -on
	}

	set sid ""
	set tbUsername ""
	set tbPassword ""
	catch { import_as $sidname sid }
	catch { import tbUsername }
	catch { import tbPassword }

	if {$sidname == "sid"} then {
		set tbUid [user_uid_ise $tbUsername]
	} else {
		#uid des Benutzers oder negativ:
		set tbUid [user_verify $tbUsername $tbPassword]
	}

	#uid der gewünschten Session:
	set s_uid [session_uid_sid $sid]

	if {$tbUid > 0 && ($s_uid == 0 || ($tbUid == $s_uid))} then {
		session_setuid_sid $tbUid $sid
		session_ResetTimeOut_sid $sid
		write_sessions

		#Hole redirect mit sid
		session_redirecturl_sid redirect $sid
		redirect $redirect
			
	} else {

		session_putloginpage $sid "Anmeldung abgewiesen."
	}	

	#title "Params"
	#body {
		#puts "sid:$sid"
		#puts "user:$tbUsername"
		#puts "pwd:$tbPassword"
		#puts "tbUid:$tbUid"
		#puts "s_uid:$s_uid"
	#}
}
