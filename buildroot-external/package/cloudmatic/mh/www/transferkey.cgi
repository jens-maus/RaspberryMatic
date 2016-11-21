#!/bin/tclsh

package require HomeMatic

set bidcos serial
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/ids"]
catch { [regexp -line {SerialNumber=(.*)} $content dummy serial] }

set bidcos unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/ids"]
catch { [regexp -line {BidCoS-Address=(.*)} $content dummy bidcos] }

set user_has_account unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/mhcfg"]
catch { [regexp -line {user_has_account=(.*)} $content dummy user_has_account] }



puts {
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>meine-homematic.de Mehrwert Dienste</title>
<style type="text/css">
<style type="text/css">
<!--
body,td,th {
	color: #000000;
	font-family: Arial, Helvetica, sans-serif;
}
body {
	background-color: #ffffff;
}
a:link {
	color: #000000;
}
a:visited {
	color: #000000;
}
-->
</style>

</style></head>
<body text="#000000" link="#000000">
}

if {$user_has_account == 0} {
   puts "Auf der lokalen CCU liegen noch keine Schl&uuml;sseldaten vor.<br>"
   puts "Schl&uuml;ssel f&uuml;r Ihre Zentrale wird &uuml;bertragen...<br>"

if {[catch {exec /bin/sh /etc/config/addons/mh/trans.sh $serial $bidcos } result]} {
  # non-zero exit status, get it:
  set status [lindex $errorCode 2]
} else {
  # exit status was 0
  # result contains the result of your command
  set status 0
}


set user_has_account unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/mhcfg"]
catch { [regexp -line {user_has_account=(.*)} $content dummy user_has_account] }

if {$user_has_account == 1} {
  puts "Schl&uuml;ssel wurde &uuml;betragen, wird jetzt entpackt.<br>"


	if {[catch {exec /bin/sh /etc/config/addons/mh/dienstan.sh & } result]} {
		# non-zero exit status, get it:
		set status [lindex $errorCode 2]
	} else {
		# exit status was 0
		# result contains the result of your command
		set status 0
	}

	puts {
		<p>Dienst wurde aktiviert<br><br></p>
	}		


	if {[catch {exec /bin/sh /etc/config/addons/mh/autoupdatean.sh & } result]} {
		# non-zero exit status, get it:
		set status [lindex $errorCode 2]
	} else {
		# exit status was 0
		# result contains the result of your command
		set status 0
	}

	puts {
		<p>Automatische Updates wurden aktiviert<br><br></p>
	}		




  puts "Schl&uuml;ssel wurde installiert, das Browser Fenster kann nun geschlossen werden.<br>"
  set user_has_account 0
} else {
  puts "Fehler beim &uuml;betragen festgestellt, bitte in 5 Min. erneut versuchen.<br>"
  puts "Das Browser Fenster kann nun geschlossen werden.<br>"
}


}

if {$user_has_account == 1} {
   puts "Die Daten f&uuml;r diese HomeMatic CCU wurden bereits &uuml;bertragen."
}

puts {
  </body>
  </html>
}