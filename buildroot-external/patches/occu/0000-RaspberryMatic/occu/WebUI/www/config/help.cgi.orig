#!/bin/tclsh
source cgi.tcl

load tclrega.so

set PRODUCT_NAME "HomeMatic Zentrale"
set PRODUCT_ID "HM-CCU"
set HOMEMATIC_URL "http://www.homematic.com"
set HELP_URL "$HOMEMATIC_URL/help/index.php"
set LANGUAGE "de"

proc action_put_page {} {
    global PRODUCT_NAME PRODUCT_ID HOMEMATIC_URL HELP_URL LANGUAGE env
    
    set SERIAL [read_var /var/ids SerialNumber]
    set VERSION [read_var /boot/VERSION VERSION]
 
    set sid ""
    catch {import sid}
		set from ""
		catch {import from}
    
		puts "<link rel=\"stylesheet\" type=\"text/css\" href=\"/ise/ise/style/nfs_datepicker.css\">"
		
    #<%
    #  system.SetSessionVar("sessionTAB", "help");
    #%>
    		
		if { "$from" == "internal" } {
        puts {
            <script type="text/javascript">
                setPath(translateKey('dialogHelpPath'));
            </script>
        }
    }

    puts {
        <table id="overviewHelpPage" width="100%" class="CLASS21300" cellspacing="20" style="display:none">
        <colgroup>
        <col width="25%" />
        <col width="25%" />
        <col width="25%" />
        <col width="25%" />
        </colgroup>
          <tr>
            <td id="tdOnline" class="CLASS21301"">
            <div onclick="loadExtHelp()" class="StdTableBtn">${dialogHelpBtnOnlineHelp}</div>
            <table class="CLASS21304">
                <tr>
                  <td class="CLASS21306">1.</td>
    }
    #puts "<td>Zugriff auf die HomeMatic Support Homepage <a target='_blank' href=\"$HELP_URL?lang=$LANGUAGE&vers=$VERSION&serial=$SERIAL\">$HELP_URL</a> mit einer ausf&uuml;hrlichen Hilfefunktion.</td>"
    puts "<td>\${dialogHelpLinkOnlineHelpA} <a target='_blank' href=\"$HELP_URL?lang=$LANGUAGE&vers=$VERSION&serial=$SERIAL\">$HELP_URL</a> \${dialogHelpLinkOnlineHelpB}</td>"

    puts {
      </tr>

      <tr>
        <td class="CLASS21306">2.</td>
        <td><a target='_blank' href="/licenseinfo.htm">${lblLicenseInformation}</a></td>
      </tr>

      </table>
      <td id="tdInfo" class="CLASS21305" >
        <div class="CLASS21302">${dialogHelpInfoTitle}</div>
        <table class="CLASS21303" >
    }
    puts "              <tr><td>$PRODUCT_NAME</td></tr>"
    puts "              <tr><td>$PRODUCT_ID</td></tr>"
    puts "              <tr><td>\${dialogHelpInfoLblSN} $SERIAL</td></tr>"
    puts "              <tr><td>\${dialogHelpInfoLblVersion} $VERSION</td></tr>"
#    puts "              <tr><td>DOM [rega dom.BuildLabel()]</td></tr>"
    puts {
                  <tr><td>${dialogHelpInfoLblCopyright} &copy; 2007 - 2012</td></tr>
                  <tr><td>eQ-3 AG</td></tr>
                  <tr><td>26789 Leer</td></tr>
                  <tr><td>Germany</td></tr>
    }
    puts "              <tr><td><a target='_blank' href=\"$HOMEMATIC_URL\">$HOMEMATIC_URL</a></td></tr>"
    puts {
                  <tr><td><img src="/ise/img/homematic_logo_small_gray.jpg" /></td></tr>
              </table>
            </td>
            <td>
            </td>
          </tr>
        </table>
    }
    
    cgi_javascript {
			if { "$from" == "internal" } {
				set href ""
				puts "setFooter('');"
			} else {
				if { "$from" != "login" } {
					set href "/pages/index.htm?NoAutoLogin=true"
				} else {
					set href "/"
					set queryparams ""
					set queryparams [cgi_unquote_input $env(QUERY_STRING)]
					set querysid ""
					if { [regexp "sid=(@\[A-Za-z0-9\]*@)" $queryparams dummy querysid] } then {
						set href "login.htm?sid=$querysid"
					}
				}
				
				puts "var s = \"\";"
				puts "s += \"<table cellspacing='8' >\";"
				puts "s += \"<tbody>\";"
				puts "s += \"<tr>\";"
				puts "s += \"<td valign='middle' allign='center'>\";"
				puts "s += \"<div class='FooterButton' onclick='goStart()' align='center'>Zur&uuml;ck\";"				
				puts "s += \"</div>\";"
				puts "s += \"</td>\";"
				puts "s += \"</tr>\";"
				puts "s += \"</tbody>\";"
				puts "s += \"</table>\";"
				puts "\$(\"footer\").innerHTML = s;"
			}
				
			puts "goStart = function() \{"
			puts "window.location.href=\"$href\";"
			puts "\}"
				
			puts "loadExtHelp = function()\{"
			puts "  wndHelp = window.open(\"$HELP_URL?lang=$LANGUAGE&vers=$VERSION&serial=$SERIAL\", \"Hilfe\", \"toolbar=yes,menubar=yes,location=yes,scrollbars=yes,resizable=yes,width=800,height=600\");"
			puts "\}"

			puts "translatePage('#overviewHelpPage');"
			puts "jQuery('#overviewHelpPage').css('display', 'table');"
		}
}				


proc read_var { filename varname} {
    set fd [open $filename r]
    set var ""
    if { $fd >=0 } {
        while { [gets $fd buf] >=0 } {
	        if [regexp "^ *$varname *= *(.*)$" $buf dummy var] break
        }
	    close $fd
    }
    return $var
}

cgi_eval {
#cgi_debug -on
cgi_input
catch {
    import debug
    cgi_debug -on
}

set action "put_page"

http_head

catch { import action }
action_$action
}
