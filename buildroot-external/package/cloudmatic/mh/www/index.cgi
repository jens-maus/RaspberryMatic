#!/bin/tclsh

package require HomeMatic

set serial unknown
catch { set serial [::HomeMatic::GetSerialNumber] }

set bidcos unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/ids"]
catch { [regexp -line {BidCoS-Address=(.*)} $content dummy bidcos] }

set user_has_account unknown
set base_url "meine-homematic.de"
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/mhcfg"]
catch { [regexp -line {user_has_account=(.*)} $content dummy user_has_account] }
catch { [regexp -line {base_url=(.*)} $content dummy base_url] }

set register_pending unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/register_pending"]
catch { [regexp -line {status=(.*)} $content dummy register_pending] }

puts {
<!DOCTYPE html>
<html>
  <head>
    <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection">
    <link type="text/css" rel="stylesheet" href="css/cloudmatic.css"  media="screen,projection">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>CloudMatic</title>
  </head>
<body>
<script>
  var heute = new Date();
  var jahr = heute.getYear()+1900;
  var monat = heute.getMonth()+1;
  var tag = heute.getDate();
}
  puts "var base_url = '$base_url';"
  puts "</script>"

if {$user_has_account == 0} {
  if {$register_pending == 1} {
puts {
<div class="navbar-fixed">
  <nav class="white" role="navigation">
    <div class="nav-wrapper container">
      <a id="logo-container" href="/addons/mh/index.cgi" class="brand-logo grey-text text-darken-2"><img src="img/CloudMaticLogo.png" alt="CloudMatic"></a>
      <ul class="right hide-on-med-and-down" style="padding-top:6px;">
        <li class="active"><a href="index.cgi" class="cm-nav" data-content="start">Start</a></li>
        <li><a href="#!" class="cm-nav" data-content="support">Support</a></li>
      </ul>
      <ul id="nav-mobile" class="side-nav">
        <li class="active"><a href="index.cgi" class="cm-nav" data-content="start">Start</a></li>
        <li><a href="#!" class="cm-nav" data-content="support">Support</a></li>
      </ul>
      <a href="#" data-activates="nav-mobile" class="button-collapse"><i class="material-icons">menu</i></a>
    </div>
  </nav>
</div>
<!-- /Navigation -->
<main>
<div class="container">
<div id="start" class="cm-content">
  <div class="row">
    <div class="col s12">
      <h4>CloudMatic | Steuern Sie Ihr Haus doch einfach EASY.</h4>
      Sicherer Fernzugriff auf Ihre SmartHome Zentrale
    </div>
  </div>
  <div class="row">
    <div class="col s12">
      <h6>Sie haben sich bereits registriert, bitte haben Sie ein paar Minuten Geduld.</h6>
      <p>
        Ihr CloudMatic Konto wird aktiviert und der Schl&uuml;ssel automatisch auf die Zentrale &uuml;bertragen. Nach erfolgreicher
        Aktivierung und &Uuml;bertragung haben Sie hier einen zentralen &Uuml;berblick auf Ihre pers&ouml;nlichen Daten und Zug&auml;nge.<br><br><br>
      </p>
      <a href="index.cgi" class="waves-effect waves-light btn blue"><i class="material-icons left">loop</i>Seite neu laden</a>
          <br>
          <br>
          <br>
          Wenn Sie innerhalb von 30 Minuten noch keinen Schl&uuml;ssel erhalten haben, k&ouml;nnen Sie die Registrierung abbrechen und neu starten.<br>
          <br>
          <a href="cancelregister.cgi" class="waves-effect waves-light btn blue cancelregister" data-type="cancelregister"><i class="material-icons left">check_box</i>Registrierung abbrechen</a>
    </div>
  </div>
</div>
}
  } else {
  
puts {
<!-- Navigation -->
<div class="navbar-fixed">
  <nav class="white" role="navigation">
    <div class="nav-wrapper container">
      <a id="logo-container" href="/addons/mh/index.cgi" class="brand-logo grey-text text-darken-2"><img src="img/CloudMaticLogo.png" alt="CloudMatic"></a>
      <ul class="right hide-on-med-and-down" style="padding-top:6px;">
        <li class="active"><a href="index.cgi" class="cm-nav" data-content="start">Start</a></li>
        <li><a href="clregister.cgi" data-content="register">Registrieren</a></li>
        <li><a href="#!" class="cm-nav" data-content="support">Support</a></li>
      </ul>
      <ul id="nav-mobile" class="side-nav">
        <li class="active"><a href="index.cgi" class="cm-nav" data-content="start">Start</a></li>
        <li><a href="clregister.cgi" data-content="register">Registrieren</a></li>
        <li><a href="#!" class="cm-nav" data-content="support">Support</a></li>
      </ul>
      <a href="#" data-activates="nav-mobile" class="button-collapse"><i class="material-icons">menu</i></a>
    </div>
  </nav>
</div>
<!-- /Navigation -->
<main>
<div class="container">
<div id="start" class="cm-content">
  <div class="row">
    <div class="col s12">
      <h4>CloudMatic | Steuern Sie Ihr Haus doch einfach EASY.</h4>
      Sicherer Fernzugriff auf Ihre SmartHome Zentrale
    </div>
  </div>
  <div class="row">
    <div class="col s12">
      Sie haben noch kein CloudMatic connect Konto aktiviert. Testen Sie alle CloudMatic Dienste 30 Tage lang ganz unverbindlich und kostenlos!<br><br>
      <a href="clregister.cgi" class="waves-effect waves-light btn blue"><i class="material-icons left">mode_edit</i>Jetzt Testen</a> 
    </div>
  </div>
  <div class="divider"></div>
  <div class="row">
    <div class="col s12">
      <div class="row">
        <div class="col s4">
          <img src="img/cmvpn.png" alt="CloudMatic connect" class="responsive-img">
        </div>
        <div class="col s8">
          <h4>CloudMatic connect - sicherer Fernzugriff auf Ihre Haussteuerung</h4>
          <p>
            <h6>Weltweiter Zugriff - per APP und Webbrowser</h6>
            Sie m&ouml;chten von &uuml;berall auf Ihre Haussteuerung zugreifen k&ouml;nnen? Sicher und komfortabel? Nutzen Sie CloudMatic connect!
            &Uuml;ber die sichere Anbindung von CloudMatic connect greifen Sie &uuml;ber das Internet auf Ihre HomeMatic Haussteuerung zu.
          </p> 
        </div>
        <div class="col s12">
          <h6>So funktioniert es:</h6>
          <ul>
            <li>Sie melden sich von Ihrer HomeMatic Zentrale zu unserem Dienst an</li>
            <li>Sie erhalten einen pers&ouml;nlichen Schl&uuml;ssel, der nur f&uuml;r Sie gilt. Dieser wird auf Ihrer HomeMatic Zentrale eingespielt.</li>
            <li>Ihre Zentrale baut nun einen sicheren Tunnel zu unserem Portal auf. Nat&uuml;rlich AES 256bit verschl&uuml;sselt und &uuml;ber digitale Zertifikate authentisiert - was dem aktuellen Stand der Technik entspricht. F&uuml;r Sie passiert das alles vollkommen transparent im Hintergrund!</li>
            <li>Sie k&ouml;nnen nun &uuml;ber unser Portal auf Ihre CCU zugreifen. Klicken Sie einfach auf den Link im Portal - schon werden Sie auf Ihre Haussteuerung geleitet.</li>
            <li>Sicherheit geht vor: Damit kein Dritter Zugriff auf Ihre Zentrale hat, sichern wir Ihre CCU &uuml;ber unsere Webfirewall. Erst nach Authentisierung mit Benutzername und Passwort ist ein Zugriff auf Ihre Haussteuerung m&ouml;glich.</li>
          </ul>
          <a href="clregister.cgi" class="waves-effect waves-light btn blue"><i class="material-icons left">mode_edit</i>Jetzt testen</a> 
        </div>
      </div>
    </div>
  </div>
  <div class="divider"></div>
  <div class="row">
    <div class="col s12">
      <div class="row">
        <div class="col s4">
          <img src="img/cmsmarthome.png" alt="CloudMatic SmartHome" class="responsive-img">
        </div>
        <div class="col s8">
          <h4>CloudMatic SmartHome - die komfortable Bedienoberfl&auml;che f&uuml;r aktuelle Endger&auml;te</h4>
          <p>
            <h6>Die innovative Bedienoberfl&auml;che</h6>
            Mit dem CloudMatic SmartHome Webinterface steht Ihnen eine komfortable Bedienoberfl&auml;che f&uuml;r Ihre HomeMatic Haussteuerung zur 
            Verf&uuml;gung. Hiermit brauchen Sie Ihre Haussteuerung nicht mehr &uuml;ber die Oberfl&auml;che der Zentrale bedienen, sondern nutzen 
            unsere Cloud-basierte L&ouml;sung - von &uuml;berall und mit jedem Endger&auml;t ... auch per Smartphone/Tablet! 
          </p> 
        </div>
        <div class="col s12">
          <h6>Mit CloudMatic SmartHome k&ouml;nnen Sie:</h6>
          <ul>
            <li>Ihre HomeMatic Zentrale vom SmartPhone, Tablet oder PC aus bedienen, lokal und per Internet.</li>
            <li>Eine beliebige Zahl individuelle Ansichten erstellen, die eine schnelle Status-&Uuml;bersicht und eine einfache Bedienung erlauben.</li>
            <li>Den Zugriff f&uuml;r unterschiedliche Benutzer einschr&auml;nken.</li>
            <li>Auf weitere Ger&auml;te wie Webcams durch den CloudMatic connect Tunnel zugreifen.</li>
            <li>Mehrere Zentralen &uuml;ber eine Oberfl&auml;che verwalten.</li>
          </ul>
          <a href="clregister.cgi" class="waves-effect waves-light btn blue"><i class="material-icons left">mode_edit</i>Jetzt testen</a> 
        </div>
      </div>
    </div>
  </div>
  <div class="divider"></div>
  <div class="row">
    <div class="col s12">
      <div class="row">
        <div class="col s4">
          <img src="img/cmsms.png" alt="CloudMatic notify me" class="responsive-img">
        </div>
        <div class="col s8">
          <h4>CloudMatic notify me - Schnell informiert dank SMS, Pushnachrichten und Mail</h4>
          <p>
            <h6>Versenden Sie SMS direkt von Ihrer HomeMatic Zentrale!</h6>
            SMS k&ouml;nnen ganz einfach per Skript von der Zentrale versendet werden. Der SMS Versand kann als zus&auml;tzliche Aktion bei einem 
            Ereignis hinterlegt werden. Es ist ein nationaler und ein internationaler Versand m&ouml;glich, die Kosten einer SMS liegen unter 
            denen vieler Mobilfunkanbieter.  
          </p> 
        </div>
        <div class="col s12">
          <h6>Push Nachrichten direkt auf Ihr Smartphone*</h6>
          Sie m&ouml;chten zus&auml;tzlich Pushnachrichten auf Ihr Smartphone erhalten? Mit CloudMatic notify me kein Problem.
          Einfach Premium-Guthaben buchen, ggf. die ben&ouml;tigte App auf Ihr Smartphone installieren und ein Script auf Ihrer Zentrale erstellen!
          <br><br>
          <a href="clregister.cgi" class="waves-effect waves-light btn blue"><i class="material-icons left">mode_edit</i>Jetzt testen</a>
          <br><br>
          <sup>* Unterst&uuml;tzte Betriebssysteme: iOS/Android. F&uuml;r den Versand von Pushnachrichten per iPad/iPhone/Android sind Apps von Fremdanbietern Voraussetzung durch die ggf. weitere Kosten entstehen.</sup> 
        </div>
      </div>
    </div>
  </div>
  <div class="divider"></div>
  <div class="row">
    <div class="col s12">
      <div class="row">
        <div class="col s4">
          <img src="img/zufrieden.jpg" alt="CloudMatic notify me" class="responsive-img">
        </div>
        <div class="col s8">
          <h4>Alle Funktionen 30 Tage kostenlos und unverbindlich testen</h4>
          <p>
            Wer kauft schon gerne die Katze im Sack? Sie k&ouml;nnen alle CloudMatic Dienste inkl. VPN Zugang 30 Tage kostenlos und 
            unverbindlich testen. Melden Sie sich am CloudMatic Portal an und &uuml;berzeugen sich von der Qualit&auml;t des Services.  
          </p> 
        </div>
        <div class="col s12">
          <a href="clregister.cgi" class="waves-effect waves-light btn blue"><i class="material-icons left">mode_edit</i>Jetzt testen</a>
        </div>
      </div>
    </div>
  </div>
</div>
}
}
}

if {$user_has_account == 1} {
  if {$register_pending == 1} {
    exec /bin/rm /etc/config/addons/mh/register_pending
  }
	set premiumjahr unknown
	set premiummonat unknown
	set premiumtag unknown
	set userid unknown
	set userkey unknown
  set standardsms 0
  set premiumsms 0
	set smarthomeliz 0
	set smarthometype "Werbefinanzierte Testversion"
	set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/mhcfg"]
	catch { [regexp -line {premiumjahr=(.*)} $content dummy premiumjahr] }
	catch { [regexp -line {premiummonat=(.*)} $content dummy premiummonat] }
	catch { [regexp -line {premiumtag=(.*)} $content dummy premiumtag] }
	catch { [regexp -line {userid=(.*)} $content dummy userid] }
	catch { [regexp -line {userkennung=(.*)} $content dummy username] }
	catch { [regexp -line {userkey=(.*)} $content dummy userkey] }
	catch { exec /bin/sh /etc/config/addons/mh/csmsg.sh $userid $userkey }  
	set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/smsguthaben"]
	catch { [regexp -line {Standard=(.*)} $content dummy standardsms] }
	catch { [regexp -line {Premium=(.*)} $content dummy premiumsms] }
	catch { [regexp -line {Lizenz=(.*)} $content dummy smarthomeliz] }
	catch { [regexp -line {Typ=(.*)} $content dummy smarthometype] }

  puts {
<!-- Navigation -->
<div class="navbar-fixed">
  <nav class="white" role="navigation">
    <div class="nav-wrapper container">
      <a id="logo-container" href="/addons/mh/index.cgi" class="brand-logo grey-text text-darken-2"><img src="img/CloudMaticLogo.png" alt="CloudMatic"></a>
      <a href="#" data-activates="nav-mobile" class="button-collapse"><i class="material-icons">menu</i></a>
      <ul class="right hide-on-med-and-down" style="padding-top:6px;">
        <li class="active"><a href="#!" class="cm-nav" data-content="status">Status</a></li>
        <li><a href="#!" class="cm-nav" data-content="balance">Kontostand</a></li>
        <li><a href="#!" class="cm-nav" data-content="services">Dienste</a></li>
        <li><a href="#!" class="cm-nav" data-content="check">Funktionspr&uuml;fung</a></li>
        <li><a href="#!" class="cm-nav" data-content="update">Updates</a></li>
        <li><a href="#!" class="cm-nav" data-content="remove">Entfernen</a></li>
        <li><a href="#!" class="cm-nav" data-content="support">Support</a></li>
      </ul>
      <ul id="nav-mobile" class="side-nav">
        <li class="active"><a href="#!" class="cm-nav side-nav-link" data-content="status">Status</a></li>
        <li><a href="#!" class="cm-nav side-nav-link" data-content="balance">Kontostand</a></li>
        <li><a href="#!" class="cm-nav side-nav-link" data-content="services">Dienste</a></li>
        <li><a href="#!" class="cm-nav side-nav-link" data-content="check">Funktionspr&uuml;fung</a></li>
        <li><a href="#!" class="cm-nav side-nav-link" data-content="update">Updates</a></li>
        <li><a href="#!" class="cm-nav side-nav-link" data-content="remove">Entfernen</a></li>
        <li><a href="#!" class="cm-nav side-nav-link" data-content="support">Support</a></li>
      </ul>
    </div>
  </nav>
</div>
<!-- /Navigation -->
<main>
<div class="container">
  }
  puts "<script>"
  puts "var userid = '$userid';"
  puts "var username = '$username';"
  puts "var yyyy = '$premiumjahr';"
  puts "var mm = '$premiummonat';"
  puts "var dd = '$premiumtag';"
  puts "var ssms = '$standardsms';"
  puts "var psms = '$premiumsms';"
  puts "</script>"

	puts {
    <div id="status" class="cm-content" style="display:none;">
      <!-- Headline -->
      <div class="row">
        <div class="col s12"><h4>CloudMatic Dashboard</h4>Hier haben Sie einen zentralen &Uuml;berblick auf Ihre pers&ouml;nlichen Daten und Zug&auml;nge. </div>
      </div>
      <!-- /Headline -->
      <!-- Status Cards -->
      <div class="row">
        <!-- Account Data -->
        <div class="col s12 m6">
          <div class="card white">
            <div class="card-content black-text">
              <span class="card-title">Ihre Daten</span>
              <p>
                Ihre CloudMatic-ID: <script>document.write(userid);</script><br>
                Ihr Benutzername: <script>document.write(username);</script><br>
                <br>
              </p>
            </div>
            <div class="card-action">
              <script>document.write('<a href="https://www.'+base_url+'" target="_blank" class="waves-effect waves-light btn blue">');</script><i class="material-icons left">mode_edit</i>Daten bearbeiten</a>
            </div>
          </div>
        </div>
        <!-- /Account Data -->
        <!-- CloudMatic connect -->
        <div class="col s12 m6">
          <div class="card white">
            <div class="card-content black-text">
              <span class="card-title">CloudMatic connect</span>
              <p>
                Unverschl&uuml;sselt: <script>document.write('<a href="http://'+userid+'.'+base_url+'" target="_blank">');</script>http://<script>document.write(userid);</script>.<script>document.write(base_url);</script></a><br>
                Verschl&uuml;sselt: <script>document.write('<a href="https://'+userid+'.'+base_url+'" target="_blank">');</script>https://<script>document.write(userid);</script>.<script>document.write(base_url);</script></a><br>
                Laufzeit des Schl&uuml;ssels: <script>document.write(dd+"."+mm+"."+yyyy)</script><br>
              </p>
            </div>
            <div class="card-action">
              <script>document.write('<a href="https://link.'+base_url+'/order-cloudmatic-connect" target="_blank" class="waves-effect waves-light btn blue">');</script><i class="material-icons left">shopping_cart</i>Zugang buchen</a>
            </div>
          </div>
        </div>
        <!-- /CloudMatic connect -->
        <!-- CloudMatic SmartHome -->
  }
if {$smarthomeliz != "Fehler beim Pr&uuml;fen der Lizenz oder keine Lizenz gebucht"} {
  puts {
        <div class="col s12 m6">
          <div class="card white">
            <div class="card-content black-text">
              <span class="card-title">CloudMatic SmartHome</span>
              <p>
                Unverschl&uuml;sselt: <script>document.write('<a href="http://'+userid+'.cloud-matic.net" target="_blank">');</script>http://<script>document.write(userid);</script>.cloud-matic.net</a><br>
                Verschl&uuml;sselt: <script>document.write('<a href="https://'+userid+'.cloud-matic.net" target="_blank">');</script>https://<script>document.write(userid);</script>.cloud-matic.net</a><br>
                Laufzeit: 
  }
  puts "$smarthomeliz"
  puts {
              </p>
            </div>
            <div class="card-action">
              <script>document.write('<a href="https://link.'+base_url+'/order-cloudmatic-smarthome" target="_blank" class="waves-effect waves-light btn blue">');</script><i class="material-icons left">shopping_cart</i>Zugang buchen</a>
            </div>
          </div>
        </div>
  }
} else {
  puts {
        <div class="col s12 m6">
          <div class="card white">
            <div class="card-content black-text">
              <span class="card-title">CloudMatic SmartHome</span>
              <p>
  }
  puts "$smarthomeliz"
  puts {
                <br><br>
              </p>
            </div>
            <div class="card-action">
              <script>document.write('<a href="https://link.'+base_url+'/order-cloudmatic-smarthome" target="_blank" class="waves-effect waves-light btn blue">');</script><i class="material-icons left">shopping_cart</i>Zugang buchen</a>
            </div>
          </div>
        </div>
  }
}
  puts {
        <!-- /CloudMatic SmartHome -->
        <!-- CloudMatic notify me -->
        <div class="col s12 m6">
          <div class="card white">
            <div class="card-content black-text">
              <span class="card-title">Ihr Guthaben</span>
              <p>
                Guthaben Standard SMS: <script>document.write(ssms);</script><br>
                Guthaben Premium SMS: <script>document.write(psms);</script><br>
                <br>
              </p>
            </div>
            <div class="card-action">
              <script>document.write('<a href="https://link.'+base_url+'/order-cloudmatic-notifyme" target="_blank" class="waves-effect waves-light btn blue">');</script><i class="material-icons left">shopping_cart</i>Guthaben buchen</a>
            </div>
          </div>
        </div>
        <!-- /CloudMatic notify me -->

      </div>
      <!-- /Status Cards -->
    </div>
	}
	#<!-- Ende Tab 1 -->
	#<!-- Ende User hat Konto -->
puts {
  <div id="check" class="cm-content" style="display:none;">
    <div class="row">
      <div class="col s12">
        <h4>Funktionspr&uuml;fung</h4>
        Hier haben Sie die M&ouml;glichkeit eine Funktionspr&uuml;fung der CloudMatic Installation / Dienste durchzuf&uuml;hren.
      </div>
    </div>
    <div class="row">
      <div class="col s12">
        <p>
          <a href="dotest.cgi" target="_blank" class="waves-effect waves-light btn blue"><i class="material-icons left">build</i>Diagnose starten</a><br><br>
          <a href="dotest2.cgi" target="_blank" class="waves-effect waves-light btn blue"><i class="material-icons left">build</i>erweiterte Diagnose starten</a>
        </p>
      </div>
    </div>
  </div>
}


#<!-- Beginn Tab 3 -->
	
set dienst unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/dienst"]
catch { [regexp -line {(.*)} $content dummy dienst] }
set dienstngx unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/dienstngx"]
catch { [regexp -line {(.*)} $content dummy dienstngx] }
set dienstzbx unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/dienstzbx"]
catch { [regexp -line {(.*)} $content dummy dienstzbx] }

puts {
  <div class="cm-content" id="services" style="display:none;">
    <div class="row">
      <div class="col s12">
        <h4>Dienststatus</h4>Hier haben Sie einen &Uuml;berblick auf die CloudMatic Dienste der CCU.
      </div>
    </div>
    <div class="row">
      <div class="col s12">
        <div class="row">
          <div class="col s4">
            <img src="img/cmvpn.png" alt="CloudMatic connect" class="responsive-img">
          </div>
          <div class="col s8">
            <h6>CloudMatic connect - Premium VPN Zugang</h6>
}
if {$dienst == 0} {
  puts {
          Der VPN Dienst ist nicht gestartet, <br>VPN Zugang "CloudMatic connect" ist nicht aktiv<br>
          <br>
          <a href="dienstan.cgi" class="waves-effect waves-light btn blue startservice" data-type="vpn"><i class="material-icons left">check_box</i>Dienst starten</a>
  }
} else {
  puts {
          Der VPN Dienst ist gestartet, <br>VPN Zugang "CloudMatic connect" kann genutzt werden<br>
          <br>
          <a href="dienstaus.cgi" class="waves-effect waves-light btn blue stopservice" data-type="vpn"><i class="material-icons left">cancel</i>Dienst beenden</a>
  }
}
puts {
          </div>
        </div>
      </div>
    </div>
    <div class="divider"></div>
    <div class="row">
      <div class="col s12">
        <h4>Zusatzdienste</h4>
      </div>
    </div>
    <div class="row">
      <div class="col s12">
        <h6>Reverse Proxy</h6>
}
if {$dienstngx == 0} {
  puts {
        Der Reverse Proxy Dienst ist nicht gestartet, erweiterte CloudMatic Dienste sind nicht aktiv.<br><br>
        <a href="dienstanngx.cgi" class="waves-effect waves-light btn blue startservice" data-type="nginx"><i class="material-icons left">check_box</i>Dienst starten</a>
  }
} else {
  puts {
        Der Reverse proxy Dienst ist gestartet, erweiterte CloudMatic Dienste k&ouml;nnen genutzt werden.<br><br>
        <a href="dienstausngx.cgi" class="waves-effect waves-light btn blue stopservice" data-type="nginx"><i class="material-icons left">cancel</i>Dienst beenden</a>
  }
}
puts {
      </div>
    </div>
    <div class="divider"></div>
    <div class="row">
      <div class="col s12">
        <h6>CloudMatic monitoring</h6>
}
if {$dienstzbx == 0} {
  puts {
        Der CloudMatic monitoring Dienst ist nicht gestartet, System&uuml;berwachung aus der Cloud ist nicht aktiv.<br><br>
       <a href="dienstanzbx.cgi" class="waves-effect waves-light btn blue startservice" data-type="zbx"><i class="material-icons left">check_box</i>Dienst starten</a>
  }
} else {
  puts {
        Der CloudMatic monitoring Dienst ist gestartet, System&uuml;berwachung aus der Cloud kann genutzt werden.<br><br>
        <a href="dienstauszbx.cgi" class="waves-effect waves-light btn blue stopservice" data-type="zbx"><i class="material-icons left">cancel</i>Dienst beenden</a>
  }
}
puts {
      </div>
    </div>
  </div>
}

#<!-- Beginn Tab 4 -->
puts {
  <div class="cm-content" id="balance" style="display:none;">
    <div class="row">
      <div class="col s12">
        <h4>Kontostand</h4>Hier haben Sie einen &Uuml;berblick auf Ihre Laufzeiten und Guthaben.
      </div>
    </div>
}
puts {
    <!-- CloudMatic connect -->
    <script>
      var valid = 0;
	  var heutestring = jahr.toString() + "/" + monat.toString() + "/" + tag.toString() + " 00:00:00";
	  var heute = (new Date(heutestring).getTime()/1000)
	  var keystring = yyyy.toString() + "/" + mm.toString() + "/" + dd.toString() + " 00:00:00";
	  var keylaufzeit = (new Date(keystring).getTime()/1000);
      if ( (keylaufzeit >= heute) ) { valid = 1; }
    </script>
    <div class="row">
      <div class="col s12">
        <div class="row">
          <div class="col s4">
            <img src="img/cmvpn.png" alt="CloudMatic connect" class="responsive-img">
          </div>
          <div class="col s8">
            <h6>CloudMatic connect - Premium VPN Zugang</h6>
            <script>
              if (valid == 1) {
                document.write("Ein pers&ouml;nlicher Schl&uuml;ssel wurde gefunden.<br>Der installierte Schl&uuml;ssel ist g&uuml;ltig bis zum: "+dd+"."+mm+"."+yyyy+".");
              } else {
                document.write("Ihr pers&ouml;nlicher Schl&uuml;ssel ist UNG&Uuml;LTIG.");
              }
            </script>
          </div>
        </div>
        <div class="row">
          <div class="col s12">
            <p>
              Der CloudMatic connect Zugang erm&ouml;glicht Ihnen einen einfachen, VPN gesicherten Zugriff auf Ihre HomeMatic Zentrale - aus 
              der Cloud, per Webbrowser und per APP. Ihre Zentrale wird dabei durch eine Webfirewall gesch&uuml;tzt. Ein Schutz, den Sie 
              bei Portfreigaben auf Ihrem Internetrouter nicht haben. Der gesicherte Zugriff steht ohne Einrichtungsaufwand an weiteren 
              Komponenten schnell bereit. Sie brauchen kein technisches Know-How zur Einrichtung.
            </p>
          </div>
        </div>
      </div>
    </div>
    <!-- /CloudMatic connect -->
    <div class="divider"></div>
}
puts {
    <!-- CloudMatic SmartHome -->
    <div class="row">
      <div class="col s12">
        <div class="row">
          <div class="col s4">
            <img src="img/cmsmarthome.png" alt="CloudMatic SmartHome" class="responsive-img">
          </div>
          <div class="col s8">
            <h6>CloudMatic SmartHome</h6>
}
puts "Laufzeit: $smarthomeliz<br>Lizenztyp: $smarthometype"
puts {
          </div>
        </div>
        <div class="row">
          <div class="col s12">
            <p>
              Mit CloudMatic SmartHome steht Ihnen eine komfortable Bedienoberfl&auml;che f&uuml;r aktuelle Endger&auml;te zur Verf&uuml;gung. 
              Mit CloudMatic SmartHome k&ouml;nnen Sie
  		        <ul>
  		          <li>Ihre HomeMatic vom SmartPhone, Tablet oder PC aus bedienen, lokal und per Internet</li>
  		          <li>Individuelle Ansichten erstellen, die eine schnelle Status-&Uuml;bersicht und eine einfache Bedienung erlauben</li>
  		          <li>Den Zugriff f&uuml;r unterschiedliche Benutzer einschr&auml;nken</li>
  		          <li>Mehrere Zentralen &uuml;ber eine Oberfl&auml;che verwalten</li>
  		        </ul>
            </p>
          </div>
        </div>
      </div>
    </div>
    <!-- /CloudMatic SmartHome -->
    <div class="divider"></div>
}
puts {
  <!-- CloudMatic notify me -->
    <div class="row">
      <div class="col s12">
        <div class="row">
          <div class="col s4">
            <img src="img/cmsms.png" alt="CloudMatic SmartHome" class="responsive-img">
          </div>
          <div class="col s8">
            <h6>CloudMatic notify me - Nachrichten von der Zentrale per SMS versenden</h6>
}
puts "$premiumsms Premium SMS<br>$standardsms Standard SMS."
puts {
          </div>
        </div>
        <div class="row">
          <div class="col s12">
            <p>
              Der CloudMatic notify me Dienst erm&ouml;glicht einen SMS Versand von Meldungen Ihrer HomeMatic Zentrale.<br>
  		        Lassen Sie sich Systemmeldungen wie anschlagende Rauch- oder Bewegungsmelder, au&szlig;ergew&ouml;hnliche Klimadaten 
              (z. B. Heizungsausfall, &uuml;berhitzung) oder Systemzust&auml;nde per SMS schicken. Dazu ben&ouml;tigen Sie 
              lediglich ein SMS-Guthaben, das Sie &uuml;ber das Portal jederzeit ohne irgendeine Vertragsbindung aufladen und 
              nach Bedarf benutzen k&ouml;nnen. Es verf&auml;llt auch bei l&auml;ngerer Nichtnutzung nicht. Die Einrichtung 
              ist einfach. Ein Assistent auf der CloudMatic Portalseite erm&ouml;glicht die Auswahl Ihrer Komponenten, 
              bei denen eine Benachrichtigung erfolgen soll. Sie legen die Zielrufnummer und den zu &uuml;bermittelnden Text 
              fest. Das Portal erstellt f&uuml;r Sie ein passendes Programm und installiert es auf Ihrer CCU. Anpassungen sind 
              einfach m&ouml;glich.
            </p>
            <p> 
  		        Zur Nutzung wird <b>KEIN</b> CloudMatic connect VPN Zugang ben&ouml;tigt!		
            </p>
          </div>
        </div>
      </div>
    </div>
  <!-- /CloudMatic notify me -->
}
puts "</div>"
#<!-- Ende Tab 4 -->

#<!-- Beginn Tab 6 -->
set autoupdate unknown
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/autoupdate"]
catch { [regexp -line {(.*)} $content dummy autoupdate] }
puts {
  <div id="update" class="cm-content" style="display:none;">
    <div class="row">
      <div class="col s12">
        <h4>Updates</h4>
      </div>
    </div>
    <div class="row">
      <div class="col s12">
	      <h6>Status automatische Updates</h6>
}
if {$autoupdate == 0} {
	puts {
		    Automatische Updates sind nicht aktiviert. Updates m&uuml;ssen manuell eingespielt werden.<br><br>
		    <a href="autoupdatean.cgi" class="waves-effect waves-light btn blue startupdate"><i class="material-icons left">check_box</i>Automatische Updates aktivieren</a>
	}
} else {
	puts {
		    Automatische Updates sind aktiv, die Pr&uuml;fung erfolgt mehrmals t&auml;glich.<br><br>
		    <a href="autoupdateaus.cgi" class="waves-effect waves-light btn blue stopupdate"><i class="material-icons left">cancel</i>Automatische Updates deakivieren</a>
	}
}
puts {
      </div>
    </div>
    <div class="row">
      <div class="col s12">
			  <h6>Manuelles Update</h6>
			  <a href="doupdate.cgi" class="waves-effect waves-light btn blue manualupdate"><i class="material-icons left">update</i>Manuelles Update starten</a>
      </div>
    </div>
  </div>
}
#<!-- Ende Tab 6 -->

#<!-- Beginn Tab 7 -->
puts {
  <div id="remove" class="cm-content" style="display:none;">
    <div class="row">
      <div class="col s12">
        <h4>Pers&ouml;nliche Daten l&ouml;schen</h4>
        Hier k&ouml;nnen Sie die pers&ouml;nlichen Daten der CloudMatic Installation l&ouml;schen.
      </div>
    </div>
    <div class="row">
      <div class="col s12">
        <p>
		      Sie m&ouml;chten Ihre CCU einschicken oder verkaufen und deshalb Ihre pers&ouml;nlichen CloudMatic Daten l&ouml;schen?<br>
          Oder Sie haben sich gegen eine weitere Nutzung der Vorteile von CloudMatic entschieden?
        </p>
        <p>
          Sie haben hier die M&ouml;glichkeit alle personifizierten Daten von der CCU zu l&ouml;schen. Die Daten k&ouml;nnen bei einem 
          bestehenden CloudMatic Konto mittels Key-Update wiederhergestellt werden.
        </p>
			  <a href="#!" class="waves-effect waves-light btn blue" id="delete"><i class="material-icons left">delete_forever</i>Daten l&ouml;schen</a>
		  </div>
    </div>
  </div>
}
#<!-- Ende Tab 7 -->
}	
#<!-- Beginn Tab 8 -->
puts {
  <div id="support" class="cm-content" style="display:none;">
    <div class="row">
      <div class="col s12">
        <h4>Support</h4>
        Hier erhalten Sie Informationen zum Support.
      </div>
    </div>
    <div class="row">
      <div class="col s12">
        <div class="row">
          <div class="col s4">
            <img src="img/cmservice.png" alt="CloudMatic Service Partner" class="responsive-img">
          </div>
          <div class="col s8">
            <h6>Service Partner Netzwerk</h6>
            <p>
              Sie haben ein technisches Problem und kommen nicht weiter? Sie br&auml;uchten jemanden, der sich damit auskennt? Den gibt es! 
              Die CloudMatic Service Partner bieten Ihnen Service rund um Ihre HomeMatic Installation!
              <ul>
                <li>Unterst&uuml;tzung bei der Planung Ihrer HomeMatic Installation</li>
                <li>Einrichtung von Komponenten, Programmen und Skripten per Fernwartung</li>
                <li>Hilfe bei der Einrichtung von CloudMatic und diverser Zusatzsoftware</li>
                <li>Fachkompetente Beratung bei Problemstellungen, optional auch bei Ihnen vor Ort</li>
              </ul>
              Unsere Service Partner kennen sich aus - mit Hausautomatisation, IT, CloudMatic und HomeMatic Produkten. Informieren Sie 
              sich auf unserer Homepage &uuml;ber das Leistungsangebot des CloudMatic Service Partner Netzwerks.<br>
              <script>document.write('<a href="http://link.'+base_url+'/servicepartner" target="_blank">');</script>Jetzt &uuml;ber das Service - Angebot informieren</a>
            </p>
          </div>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="col s12">
        <h6>Anleitungen</h6>
        <p>
          Aktuelle Anleitungen, Beispiele & Scripte rund um CloudMatic finden Sie in unserer Knowlede Base unter
          <a href="http://kb.easy-smarthome.de/cloudmatic" target="_blank">http://kb.easy-smarthome.de/cloudmatic</a>
        </p>
        <h6>Fehlersuche</h6>
        <p>
          Bitte nutzen Sie zuerst die Funktionspr&uuml;fung zur Eingrenzung m&ouml;glicher Fehler. Weitere Hinweise zur
          Fehlersuche finden Sie <script>document.write('<a href="http://link.'+base_url+'/fehlersuche" target="_blank">');</script>hier</a>.
          Sollte sich das Problem so nicht l&ouml;sen lassen, erstellen Sie bitte ein Support-Ticket in unserem
          <script>document.write('<a href="http://link.'+base_url+'/support" target="_blank">');</script>Ticket System</a>.
        </p>
      </div>
    </div>
  </div>
}

#<!-- Ende Tab 8 -->

#<!-- Ende Dokument -->
puts {
	</div>
  </div>
</main>
<footer class="page-footer light-blue darken-4">
  <div class="container">
    <div class="row">
      <div class="col l4 s12">
        <h5 class="white-text">Kontakt</h5>
        <p class="grey-text text-lighten-4">
          EASY SmartHome GmbH<br>
          Mozartweg 9<br>
          59505 Bad Sassendorf<br>
          Fon: +49 2921 3274020<br>
          (Mo.-Fr. 10:00-17:00 Uhr)<br>
          <a href="mailto:office@easy-smarthome.de" class="grey-text text-lighten-4">office@easy-smarthome.de</a>
        </p>
      </div>
      <div class="col l8 s12">
        <h5 class="white-text">CloudMatic <sup>by EASY SmartHome GmbH</sup></h5>
        <p class="grey-text text-lighten-4">
          &Uuml;ber CloudMatic erhalten Sie einen sicheren Fernzugriff auf Ihre Haussteuerung.
          Greifen Sie &uuml;ber das Internet auf Ihre Haussteuerung zu - ganz ohne Portweiterleitungen, Firewallfreischaltungen, DynDNS Einrichtungen. etc.
        </p>
      </div>
    </div>
  </div>
  <div class="footer-copyright">
    <div class="container">
    Copyright &copy; <script>document.write(jahr);</script> by <a href="http://www.easy-smarthome.de" target="_blank" class="white-text">EASY SmartHome GmbH</a>
    </div>
  </div>
</footer>
<div id="service_modal" class="modal">
  <div class="modal-content">
    <span id="service_modal_headline"></span>
    <span id="serviceresult" style="display:none;"></span>
    <div class="center-align" id="spinner">
      <div class="preloader-wrapper big active">
        <div class="spinner-layer spinner-blue-only">
          <div class="circle-clipper left">
            <div class="circle"></div>
          </div><div class="gap-patch">
            <div class="circle"></div>
          </div><div class="circle-clipper right">
            <div class="circle"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="modal-footer">
    <a href="" class="modal-submit modal-action modal-close waves-effect waves-blue btn-flat">Ok</a>
  </div>
</div>
<div id="delete_modal" class="modal">
  <div id="predelete">
    <div class="modal-content">
      <h6>Sind Sie sicher?</h6>
      Nach dem Entfernen der personifizierten Daten werden s&auml;mtliche CloudMatic Dienste deaktiviert und k&ouml;nnen
      nicht mehr Verwendet werden.
    </div>
    <div class="modal-footer">
      <a href="#!" class="modal-submit modal-action waves-effect waves-blue btn-flat" id="dodelete">Daten wirklich l&ouml;schen</a>
      &nbsp;&nbsp;&nbsp;
      <a href="#!" class="modal-submit modal-action modal-close waves-effect waves-blue btn-flat">Abbrechen</a>
    </div>
  </div>
  <div id="postdelete" style="display:none;">
    <div class="modal-content">
      <h6>Daten werden gel&ouml;scht</h6>
      Bitte haben Sie einen Moment Geduld ...
      <span id="deleteresult"></span>
      <div class="center-align" id="deletespinner">
        <div class="preloader-wrapper big active">
          <div class="spinner-layer spinner-blue-only">
            <div class="circle-clipper left">
              <div class="circle"></div>
            </div><div class="gap-patch">
              <div class="circle"></div>
            </div><div class="circle-clipper right">
              <div class="circle"></div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="modal-footer">
      <a href="index.cgi" class="modal-submit modal-action modal-close waves-effect waves-blue btn-flat postdelete" style="display:none";>Ok</a>
      &nbsp;
    </div>
  </div>
</div>
<script type="text/javascript" src="js/jquery-2.2.1.min.js"></script>
<script type="text/javascript" src="js/materialize.min.js"></script>
<script type="text/javascript" src="js/cloudmatic.js"></script>
</body>
</html>
}




