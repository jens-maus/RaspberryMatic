#!/bin/tclsh

package require HomeMatic
package require http

load tclrega.so


set serial invalid
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/ids"]
catch { [regexp -line {SerialNumber=(.*)} $content dummy serial] }

set bidcos unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/ids"]
catch { [regexp -line {BidCoS-Address=(.*)} $content dummy bidcos] }

set user_has_account unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/mhcfg"]
catch { [regexp -line {user_has_account=(.*)} $content dummy user_has_account] }


if {$bidcos == "Did not get an answer from coprocessor"} {
	if {[catch {exec /bin/sh /etc/config/addons/mh/fixids.sh } result]} {
	  # non-zero exit status, get it:
	  set status [lindex $errorCode 2]
	} else {
	  # exit status was 0
	  # result contains the result of your command
	  set status 0
	}
	set bidcos serial
	set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/ids"]
	catch { [regexp -line {SerialNumber=(.*)} $content dummy serial] }

	set bidcos unknown
	set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/ids"]
	catch { [regexp -line {BidCoS-Address=(.*)} $content dummy bidcos] }
}

if {$bidcos == ""} {
	if {[catch {exec /bin/sh /etc/config/addons/mh/fixids.sh } result]} {
	  # non-zero exit status, get it:
	  set status [lindex $errorCode 2]
	} else {
	  # exit status was 0
	  # result contains the result of your command
	  set status 0
	}
	set bidcos serial
	set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/ids"]
	catch { [regexp -line {SerialNumber=(.*)} $content dummy serial] }

	set bidcos unknown
	set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/ids"]
	catch { [regexp -line {BidCoS-Address=(.*)} $content dummy bidcos] }
}


if { [info exists env(QUERY_STRING)] } {
  regsub -all {[&=]} $env(QUERY_STRING) { } query_str
  regsub -all {  } $query_str { {} } query_str
  foreach {key val} $query_str {
    set query($key) $val
    ## puts "Parameter processing"
    ## puts "$key - $val"
  }
  set registerurl "https://www.meine-homematic.de/userapi.php?AUTHKEY=EZ37wshg37DH228shSHq&$env(QUERY_STRING)"
  
	if {[catch {exec /usr/bin/wget -q --no-check-certificate -O /tmp/result $registerurl } result]} {
		# non-zero exit status, get it:
		set status [lindex $errorCode 2]
	} else {
		# exit status was 0
		# result contains the result of your command
		set status 0
	}

  set webcode [::HomeMatic::Util::LoadFile "/tmp/result"]
  puts "<br>$webcode<br>"
  
  
  #catch { [regexp -line {Status:(.*)} $webcode dummy registersuccess] }
  #if {$registersuccess == "OK<br>"} {
	if {[catch {exec /bin/cp /etc/config/addons/mh/keytransferan /etc/config/addons/mh/keytransfer & } result]} {
		# non-zero exit status, get it:
		set status [lindex $errorCode 2]
	} else {
		# exit status was 0
		# result contains the result of your command
		set status 0
		if {[catch {exec /bin/sh /etc/config/addons/mh/dienstan.sh & } result]} {
			# non-zero exit status, get it:
			set status [lindex $errorCode 2]
		} else {
			# exit status was 0
			# result contains the result of your command
      exec /bin/echo status=1 >/etc/config/addons/mh/register_pending
			set status 0
			puts "Ihr Schl&uuml;ssel wird nun innerhalb der n&auml;chsten 10 Minuten automatisch &uuml;bertragen.<br>"
		}
	}
  #}
  
}
