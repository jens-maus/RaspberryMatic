#!/bin/tclsh

package require HomeMatic

set serial unknown
catch { set serial [::HomeMatic::GetSerialNumber] }

set bidcos unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/ids"]
catch { [regexp -line {BidCoS-Address=(.*)} $content dummy bidcos] }

set user_has_account unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/mhcfg"]
catch { [regexp -line {user_has_account=(.*)} $content dummy user_has_account] }



puts {
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>CloudMatic Diagnose</title>
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
</head>
<body text="#000000" link="#000000">
}


if {$user_has_account == 0} {
	set premiumjahr unknown
	set premiummonat unknown
	set premiumtag unknown
	set userid unknown
	set userkey unknown
	set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/mhcfg"]
	catch { [regexp -line {premiumjahr=(.*)} $content dummy premiumjahr] }
	catch { [regexp -line {premiummonat=(.*)} $content dummy premiummonat] }
	catch { [regexp -line {premiumtag=(.*)} $content dummy premiumtag] }
	catch { [regexp -line {userid=(.*)} $content dummy userid] }
	catch { [regexp -line {userkey=(.*)} $content dummy userkey] }

	puts {
 	   <h3>Status: KEIN g&uuml;ltiges CloudMatic Konto gefunden.</h3>
	}

}

if {$user_has_account == 1} {
	set premiumjahr unknown
	set premiummonat unknown
	set premiumtag unknown
	set userid unknown
	set userkey unknown
	set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/mhcfg"]
	catch { [regexp -line {premiumjahr=(.*)} $content dummy premiumjahr] }
	catch { [regexp -line {premiummonat=(.*)} $content dummy premiummonat] }
	catch { [regexp -line {premiumtag=(.*)} $content dummy premiumtag] }
	catch { [regexp -line {userid=(.*)} $content dummy userid] }
	catch { [regexp -line {userkey=(.*)} $content dummy userkey] }


	puts {
 	   <h3>Status: G&uuml;ltiges CloudMatic Konto gefunden.</h3>
User ID:		
	}
	if {$userid > 799} {
		puts "$userid<br>"
       } else {
		puts "$userid<br>"
	}	
}	

	set standardsms 0
	set premiumsms 0

	catch { exec /bin/sh /etc/config/addons/mh/csmsg.sh $userid $userkey }  
	set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/smsguthaben"]
	catch { [regexp -line {Standard=(.*)} $content dummy standardsms] }
	catch { [regexp -line {Premium=(.*)} $content dummy premiumsms] }
	puts "<p>Aktuelles SMS Guthaben: $premiumsms Premium SMS, $standardsms Standard SMS.</p>"
puts {
<br>
<H1>Starte jetzt System - Tests</H1><br>
Bitte bis zu 2 Minuten warten...<br><br>
}

if {[catch {exec /bin/sh /etc/config/addons/mh/dotest.sh $serial $bidcos } result]} {
  # non-zero exit status, get it:
  set status [lindex $errorCode 2]
} else {
  # exit status was 0
  # result contains the result of your command
  set status 0
}

set user_has_account unknown
set content unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/result.txt"]

set mycontent [string map [list "\n" "<br>"] $content]
puts $mycontent

set dienst unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/dienst"]
catch { [regexp -line {(.*)} $content dummy dienst] }

	if {$dienst == 0} {
		puts {
			<h3>Dienste Status</h3>
			<p>Der VPN Dienst ist nicht gestartet, Premium Zugang nicht aktiv<br><br></p>
		}
	} else {
		puts {
			<h3>Dienste Status</h3>
			<p>Der VPN Dienst ist in der Konfiguration aktiv, Premium Zugang kann genutzt werden<br><br></p>
		}
	}

	puts {
		<h3>Sicherer Fernzugriff auf Ihre HomeMatic CCU</h3>
		<p>Status des Premium Zugangs:

		<script type="text/javascript">
		var heute = new Date();
		var jahr = heute.getYear();
		var monat = heute.getMonth()+1;
		var tag = heute.getDate();
	}

		puts "var certjahr = $premiumjahr;"
		puts "var certmonat = $premiummonat;"
		puts "var certtag = $premiumtag;"

		puts {
		if (certjahr > jahr) {
			document.write("Ein pers&ouml;nlicher Schl&uuml;ssel wurde gefunden");
			document.write("<br><br>Der installierte Schl&uuml;ssel ist g&uuml;ltig bis zum: "+certtag+"."+certmonat+"."+certjahr);
		} else {
			if ((certjahr == jahr) && (certmonat > monat)) {
				//G�ltig
				document.write("Ein pers&ouml;nlicher Schl&uuml;ssel wurde gefunden");
				document.write("<br><br>Der installierte Schl&uuml;ssel ist g&uuml;ltig bis zum: "+certtag+"."+certmonat+"."+certjahr);
			} else {
				if ((certjahr == jahr) && (certmonat == monat) && (certtag > tag)) {
					//G�ltig
					document.write("Ein pers&ouml;nlicher Schl&uuml;ssel wurde gefunden");
					document.write("<br><br>Der installierte Schl&uuml;ssel ist g&uuml;ltig bis zum: "+certtag+"."+certmonat+"."+certjahr);
				} 
				if ((certjahr == jahr) && (certmonat == monat) && (certtag == tag)) {
					//G�ltig
					document.write("Ein pers&ouml;nlicher Schl&uuml;ssel wurde gefunden");
					document.write("<br><br>Der installierte Schl&uuml;ssel ist g&uuml;ltig bis zum: "+certtag+"."+certmonat+"."+certjahr);
				} 
				else 
				{
					//Ung�ltig
					document.write("Ihr pers&ouml;nlicher Schl&uuml;ssel ist UNG&Uuml;LTIG");
				}
			}
		}
		</script>
		<p>&nbsp;</p>
		<p>&nbsp;</p>
		}

set autoupdate unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/autoupdate"]
catch { [regexp -line {(.*)} $content dummy autoupdate] }

	if {$autoupdate == 0} {
		puts {
			<h3>Status automatische Updates</h3>
			<p>Automatische Updates sind nicht aktiviert. Updates m&uuml;ssen manuell eingespielt werden. Eine Fern-Aktivierung Ihres VPN Tunnels ist so nicht m&ouml;glich!<br><br></p>
		}
	} else {
		puts {
			<h3>Status automatische Updates</h3>
			<p>Automatische Updates sind aktiv, die Pr&uuml;fung erfolgt 2x / Tag<br><br></p>
		}
	}



puts {
<br>
<br>
Test beendet<br><br>
}

puts {
  </body>
  </html>
}