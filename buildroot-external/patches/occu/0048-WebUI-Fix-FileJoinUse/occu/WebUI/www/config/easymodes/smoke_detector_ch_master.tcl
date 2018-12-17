#!/bin/tclsh
#Kanal-EasyMode!
source [file join $env(DOCUMENT_ROOT) config/easymodes/em_common.tcl]

# set PROFILE_PNAME(Team) "Zu welcher Gruppe geh&ouml;rt der Rauchmelder?"
set PROFILE_PNAME(Team) "\${SD_QuestionGroup}"

set PROFILES_MAP(0)	"Experte"
set PROFILES_MAP(1)	"TheOneAndOnlyEasyMode"

proc getDeviceName {address} {
  global ise_CHANNELNAMES

  set result ""

  foreach val [array names ise_CHANNELNAMES] {
    set chAdr [lindex [split $val ";"] 1]
    set devAdr [lindex [split $chAdr ":"] 0]
    # puts "$chAdr - $devAdr - $address<br/>"

    if {$chAdr == $address} {
      if {$devAdr == $chAdr} {
        # puts "($devAdr - $chAdr) ----> val: $ise_CHANNELNAMES($val)"
        set result $ise_CHANNELNAMES($val);
        break;
      }
    }
  }
  return $result
}

proc set_htmlParams {iface address pps pps_descr special_input_id peer_type} {

	global iface_url ise_CHANNELNAMES  
	upvar HTML_PARAMS   HTML_PARAMS
	upvar PROFILE_PNAME PROFILE_PNAME
	
	set url $iface_url($iface)
	
	array set dev_descr [xmlrpc $url getDeviceDescription [list string $address]]

  set parentType "$dev_descr(PARENT_TYPE)-Team"

	puts "<script type=\"text/javascript\">getLangInfo_Special('SMOKE_DETECTOR.txt');</script>"

	append HTML_PARAMS(separate_1) "<table class=\"ProfileTbl\"><tr><td>"
	# append HTML_PARAMS(separate_1) $PROFILE_PNAME(Team)
	append HTML_PARAMS(separate_1) "<div id=\"param_1\"><textarea id=\"profile_1\" style=\"display:none\" >$PROFILE_PNAME(Team)<br/><br/>"

	append HTML_PARAMS(separate_1) "</td></tr><tr></tr>"


	if { [info exist dev_descr(TEAM)] } {
		set teamlist [xmlrpc $url listTeams ]
	
		append HTML_PARAMS(separate_1) "<tr><td><select name=\"TEAM\" id=\"separate_${special_input_id}_1\">"
		
		foreach team $teamlist {
			array_clear team_descr
			array set team_descr $team
      set className "CLASS20300"
			set not_ready ""
			
			if { "$team_descr(PARENT)" == "" } {
			  set deviceName [getDeviceName $team_descr(ADDRESS)]
			  continue
			}
			if { ! [info exist team_descr(TEAM_TAG)] } continue
			if { "$team_descr(TEAM_TAG)" != "$dev_descr(TEAM_TAG)" } continue
			if { ![ metadata_getReadyConfig $iface $team_descr(ADDRESS) ] } {
				set className "CLASS20100"
				#set not_ready " siehe Posteingang"
				set not_ready "\${SD_HintMailbox}"
			}

      if { "$team_descr(PARENT_TYPE)" == $parentType } {
        if { "$team_descr(ADDRESS)" == "$dev_descr(TEAM)" } {
          # append HTML_PARAMS(separate_1) "<option class=\"$className\" selected value=$team_descr(ADDRESS)>[cgi_quote_html $ise_CHANNELNAMES($iface;$team_descr(ADDRESS))] $not_ready</option>"
          append HTML_PARAMS(separate_1) "<option class=\"$className\" selected value=$team_descr(ADDRESS)>$deviceName $not_ready</option>"
        } else {
          # append HTML_PARAMS(separate_1) "<option class=\"$className\" value=$team_descr(ADDRESS)>[cgi_quote_html $ise_CHANNELNAMES($iface;$team_descr(ADDRESS))] $not_ready</option>"
          append HTML_PARAMS(separate_1) "<option class=\"$className\" value=$team_descr(ADDRESS)>$deviceName $not_ready</option>"
        }
      }
		}
		#append HTML_PARAMS(separate_1) "<option value=\"_RESET_\">Grundeinstellung</option>"
		append HTML_PARAMS(separate_1) "<option value=\"_RESET_\">\${SD_Reset}</option>"
		append HTML_PARAMS(separate_1) "</select></td></tr>"
	}
	
	append HTML_PARAMS(separate_1) "</table></textarea></div>"
  puts "<script type=\"text/javascript\">translate('1', '$special_input_id');</script>"

}

constructor
