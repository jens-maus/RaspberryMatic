#!/bin/tclsh
source cgi.tcl
source common.tcl
load tclrega.so

set PRODUCT_NAME "Zentrale"
set PRODUCT_ID "CCU[getProduct]"
set HOMEMATIC_URL "http://www.homematic.com"
set HOMEMATIC_IP_URL "https://www.homematic-ip.com"


set HELP_URL "$HOMEMATIC_URL/hilfe.html"

set HELP_IP_URL "$HOMEMATIC_IP_URL/service.html"
set LANGUAGE "de"
set CUR_YEAR [clock format [clock seconds] -format %Y]

proc action_put_page {} {
  global PRODUCT_NAME PRODUCT_ID HOMEMATIC_URL HOMEMATIC_IP_URL HELP_URL HELP_IP_URL LANGUAGE CUR_YEAR env

  set SERIAL [read_var /var/ids SerialNumber]
  set VERSION [read_var /boot/VERSION VERSION]
  set HELP_ARGUMENTS "lang=$LANGUAGE&vers=$VERSION&serial=$SERIAL"


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
  puts "<style>li {margin: 5px 0}</style>"

  puts "<table id='overviewHelpPage' width='100%' class='CLASS21300' cellspacing='20' style='display:none'>"
    puts "<colgroup>"
    puts "<col width='25%' />"
    puts "<col width='25%' />"
    puts "<col width='25%' />"
    puts "<col width='25%' />"
    puts "</colgroup>"
    puts "<tr>"
      puts "<td id='tdOnline' class='CLASS21301' align='center'>"
              # puts "<div onclick='loadExtHelp()' class='StdTableBtn'>\${dialogHelpBtnOnlineHelp}</div>"
              puts "<ul style='list-style:none; padding-right:12%'>"
                puts "<li><h1 class='helpTitle'><u>\${menuHelpPage}</u></h1></li>"
                puts "<li><a target='_blank' href=\'$HELP_URL\'>\${dialogHelpLinkOnlineHelpA}</a></li>"
                puts "<li><a target='_blank' href=\'$HELP_IP_URL\'>\${dialogHelpLinkOnlineHelpB}</a></li>"
                puts "<li><a target='_blank' href='/licenseinfo.htm'>\${lblLicenseInformation}</a></li>"
              puts "</ul>"
      puts "</td>"

      puts "<td id='tdInfo' class='CLASS21305' >"
        puts "<ul style='list-style:none; padding-right:12%'>"
          puts "<li><h1><u>\${dialogHelpInfoTitle}</u></h1></li>"
          puts "<li>$PRODUCT_NAME $PRODUCT_ID</li>"
          # puts "<li>$PRODUCT_ID</li>"
          puts "<li>\${dialogHelpInfoLblSN} $SERIAL</li>"
          puts "<li>\${dialogHelpInfoLblVersion} $VERSION</li>"
          puts "<li>\${dialogHelpInfoLblCopyright} &copy; 2007 - $CUR_YEAR</li>"
          puts "<li>eQ-3 AG</li>"
          puts "<li>26789 Leer</li>"
          puts "<li>Germany</li>"
          # puts "<li>DOM [rega dom.BuildLabel()]</li>"
          puts "<li><a target='_blank' href=\"$HOMEMATIC_URL\">\${homepage} \${LabelHomeMatic}</a></li>"
          puts "<li><a target='_blank' href=\"$HOMEMATIC_IP_URL/start.html\">\${homepage} \${dialogHelpLinkOnlineHelpB}</a></li>"
          puts "<li><br/>Menu icons made by <a target='_blank' href=\"https://icons8.com/license/\">Icons8</a><br/></li>"
          puts "<li style='padding-top:25px;'><img src='/ise/img/homematic_logo_small.png'/></li>"
        puts "</ul>"

      puts "</td>"

      puts "<td></td>"
      puts "<td></td>"

  puts "</table>"


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
      puts "jQuery(\"#footer\").html(s);"
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
