#!/bin/tclsh

package require HomeMatic

set serial invalid
set content [::HomeMatic::Util::LoadFile "/etc/config/addons/mh/ids"]
catch { [regexp -line {SerialNumber=(.*)} $content dummy serial] }

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
    <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,600,800' rel='stylesheet' type='text/css'>
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
</script>
<!-- Navigation -->
<div class="navbar-fixed">
  <nav class="white" role="navigation">
    <div class="nav-wrapper container">
      <a id="logo-container" href="/addons/mh/index.cgi" class="brand-logo grey-text text-darken-2"><img src="img/CloudMaticLogo.png" alt="CloudMatic"></a>
      <ul class="right hide-on-med-and-down" style="padding-top:6px;">
        <li><a href="index.cgi" class="cm-nav" data-content="start">Start</a></li>
        <li class="active"><a href="#!" class="cm-nav" data-content="register">Registrieren</a></li>
        <li><a href="index.cgi?s=support" class="cm-nav" data-content="support">Support</a></li>
      </ul>
      <ul id="nav-mobile" class="side-nav">
        <li><a href="#tabs-1">Start</a></li>
        <li><a href="#tabs-2">Registrieren</a></li>
        <li><a href="#tabs-8">Support</a></li>
      </ul>
      <a href="#" data-activates="nav-mobile" class="button-collapse"><i class="material-icons">menu</i></a>
    </div>
  </nav>
</div>
<!-- /Navigation -->
<main>
<div class="container">
}

if {$user_has_account == 0} {
puts {
  <div class="row">
    <div class="col s12">
      <h4>CloudMatic Registrierung</h4>
      Jetzt kostenlos und unverbindlich 30 Tage lang testen!
    </div>
  </div>
  <div class="row">
    <div class="col s12">
      Zur Nutzung m&uuml;ssen Sie sich im CloudMatic Portal als Benutzer registrieren. Es wird automatisch ein Testzugang erstellt, mit dem alle 
      Funktionen uneingeschr&auml;nkt und kostenfrei f&uuml;r 30 Tage genutzt werden k&ouml;nnen. Sie schlie&szligen hierbei <b>kein</b> Abo ab und 
      m&uuml;ssen nichts k&uuml;ndigen. Es wird ein digitaler, pers&ouml;nlicher Schl&uuml;ssel auf Ihre HomeMatic Zentrale &uuml;bertragen, 
      der die Kommunikation mit dem CloudMatic Portal absichert.
      <p>
        Nach Ablauf des Testzeitraums werden die Premium Funktionen (sicherer Fernzugriff, SmartHome Fernbedienung) automatisch deaktiviert. 
        Mail, Push und SMS k&ouml;nnen weiter genutzt werden. Sie k&ouml;nnen die erweiterten Funktionen jederzeit online frei schalten. 
        Die passende Lizenz erhalten Sie bei einem EASY SmartHome Partner oder direkt online im CloudMatic Portal.
      </p>
    </div>
  </div>
  <div class="row">
    <div class="col s12">
      <form action="doclregister.cgi" method="GET" name="registerform" id="registerform">
}
    puts "<input name=\"cb_snr\" type=\"hidden\" id=\"cb_snr\" value=\"$serial\" />"
    puts "<input name=\"cb_tkey\" type=\"hidden\" id=\"cb_tkey\" value=\"$bidcos\" />"
puts {
        <div class="row">
          <div class="col s12">
            Bitte f&uuml;llen Sie das Formular aus. Alle mit einem "*" versehenen Felder sind Pflichtfelder.
          </div>
        </div>
        <div class="row">
          <div class="input-field col m6 s12">
            <input id="FNAME" name="FNAME" type="text" class="validate" required>
            <label for="FNAME">Vorname *</label>
          </div>
          <div class="input-field col m6 s12">
            <input id="LNAME" name="LNAME" type="text" class="validate" required>
            <label for="LNAME">Nachname *</label>
          </div>
        </div>
        <div class="row">
          <div class="input-field col m6 s12">
            <input id="MAIL" name="MAIL" type="text" class="validate" required>
            <label for="MAIL">E-Mail Adresse *</label>
          </div>
          <div class="input-field col m6 s12">
            <input id="FIRMA" name="FIRMA" type="text" class="validate">
            <label for="FIRMA">Firmenname</label>
          </div>
        </div>
        <div class="row">
          <div class="input-field col m6 s12">
            <input id="STRASSE" name="STRASSE" type="text" class="validate" required>
            <label for="STRASSE">Stra&szlig;e *</label>
          </div>
        </div>
        <div class="row">
          <div class="input-field col m6 s12">
            <input id="PLZ" name="PLZ" type="text" class="validate" required>
            <label for="PLZ">Postleitzahl *</label>
          </div>
          <div class="input-field col m6 s12">
            <input id="ORT" name="ORT" type="text" class="validate" required>
            <label for="ORT">Ort *</label>
          </div>
        </div>
        <div class="row">
          <div class="input-field col m6 s12">
            <select id="LAND" name="LAND" required>
            	<option value="">Bitte w&auml;hlen Sie Ihr Land *</option>
            	<option value="Deutschland" id="cbf27">Deutschland</option>
            	<option value="Belgien" id="cbf29">Belgien</option>
            	<option value="Bulgarien" id="cbf30">Bulgarien</option>
            	<option value="D&auml;nemark" id="cbf32">D&auml;nemark</option>
            	<option value="Estland" id="cbf33">Estland</option>
            	<option value="Finnland" id="cbf34">Finnland</option>
            	<option value="Frankreich" id="cbf35">Frankreich</option>
            	<option value="Griechenland" id="cbf36">Griechenland</option>
            	<option value="Irland" id="cbf37">Irland</option>
            	<option value="Italien" id="cbf38">Italien</option>
            	<option value="Kroatien" id="cbf39">Kroatien</option>
            	<option value="Lettland" id="cbf40">Lettland</option>
            	<option value="Litauen" id="cbf41">Litauen</option>
            	<option value="Luxemburg" id="cbf42">Luxemburg</option>
            	<option value="Malta" id="cbf43">Malta</option>
            	<option value="Niederlande" id="cbf44">Niederlande</option>
            	<option value="Polen" id="cbf45">Polen</option>
            	<option value="Portugal" id="cbf46">Portugal</option>
            	<option value="Rumänien" id="cbf47">Rumänien</option>
            	<option value="Schweiz" id="cbf55">Schweiz</option>
            	<option value="Schweden" id="cbf48">Schweden</option>
            	<option value="Slowakei" id="cbf49">Slowakei</option>
            	<option value="Slowenien" id="cbf50">Slowenien</option>
            	<option value="Spanien" id="cbf51">Spanien</option>
            	<option value="Tschechische Republik" id="cbf52">Tschechische Republik</option>
            	<option value="Ungarn" id="cbf53">Ungarn</option>
            	<option value="Vereinigtes Königreich" id="cbf54">Vereinigtes Königreich</option>
            	<option value="Zypern" id="cbf31">Zypern</option>
            	<option value="&Ouml;sterreich" id="cbf28">&Ouml;sterreich</option>
            </select>
          </div>
          <div class="input-field col m6 s12">
            <input id="USTID" name="USTID" type="text" class="validate">
            <label for="USTID">VAT ID (f&uuml;r Firmenkunden aus dem EU Ausland)</label>
          </div>
        </div>
        <div class="row">
          <div class="col s12">
            <a class="waves-effect waves-light btn blue" id="registerbutton"><i class="material-icons left">save</i>Jetzt registrieren</a>
          </div>
        </div>
      </form>
    </div>
  </div>
  <div class="row">
    <div class="col s12">
      <h6>Technischer Hinweis:</h6>
      <p>
        Um CloudMatic SmartHome zur Fernsteuerung oder CloudMatic notify me f&uuml;r SMS, Push oder Mail nutzen zu k&ouml;nnen, m&uuml;ssen 
        Sie sich f&uuml;r ein CloudMatic Konto registrieren, auch wenn Sie die Premium VPN Dienste CloudMatic connect nicht nutzen m&ouml;chten.
      </p>
      <p>
        CloudMatic wird betrieben von der EASY SmartHome GmbH, <a href="https://www.easy-smarthome.de" target="_blank">www.easy-smarthome.de</a>
      </p>
      <p>
        <b>CloudMatic connect</b> ist der neue Produktname f&uuml;r den "meine-homematic.de Premium VPN Zugang".
      </p>
    </div>
  </div>
}
}

if {$user_has_account == 1} {
puts {
  <div class="row">
    <div class="col s12">
      <h4>CloudMatic Registrierung</h4>
      Sie haben sich bereits registriert.
    </div>
  </div>
  <div class="row">
    <div class="col s12">
      Sollten Sie die Registrierung eben erst vorgenommen haben, haben Sie bitte noch einen
      Moment Gedult bis die notwendigen Daten auf die Zentrale &uuml;bertragen worden sind.
      <p>
        Sollte die Registrierung schon l&auml;nger her sein, wenden Sie sich bitte an unseren Support.
      </p>
      </p>
    </div>
  </div>
}
}
puts {
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
<div id="error_modal" class="modal">
  <div class="modal-content">
    <h5>Bitte &uuml;berpr&uuml;fen Sie Ihre Eingaben</h5>
    <p><span id="validation_error"></span</p>
  </div>
  <div class="modal-footer">
    <a href="#!" class=" modal-action modal-close waves-effect waves-blue btn-flat">Ok</a>
  </div>
</div>
<div id="reg_modal" class="modal">
  <div class="modal-content">
    <h6>Registrierung wird durchgef&uuml;hrt</h6>
    Ihre Registrierung wird durchgef&uuml;hrt, bitte haben Sie einen Moment Geduld ...
    <span id="registerresult"></span>
    <div class="center-align" id="regspinner">
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
    <a href="index.cgi" class="modal-submit modal-action modal-close waves-effect waves-blue btn-flat postregister" style="display:none";>Ok</a>
  </div>
</div>
<script type="text/javascript" src="js/jquery-2.2.1.min.js"></script>
<script type="text/javascript" src="js/jquery.validate.min.js"></script>
<script type="text/javascript" src="js/materialize.min.js"></script>
<script type="text/javascript" src="js/cloudmatic.js"></script>
<script>
$(document).ready(function() {
  $("#LAND").material_select();
  $("#registerbutton").click(function() {
    if (!$("#registerform").valid()) { $("#error_modal").openModal(); } else {
      $("#reg_modal").openModal();
      $.get("doclregister.cgi", $("#registerform").serialize(), function(data) {
        $("#regspinner").hide();
        $("#registerresult").html(data);
        $(".postregister").show();
      });
    }
  }); 
  $("#registerform").validate({
    rules: {
      MAIL: { email: true }
    },
    messages: {
      FNAME: { required: "Bitte geben Sie Ihren Vornamen an" },
      LNAME: { required: "Bitte geben Sie Ihren Nachnamen an" },
      MAIL: { required: "Bitte geben Sie Ihre E-Mail Adresse an", email: "Bitte geben Sie eine g&uuml;ltige E-Mail Adresse an" },
      STRASSE: { required: "Bitte geben Sie Ihre Stra&szlig;e an" },
      PLZ: { required: "Bitte geben Sie Ihre Postleitzahl an" },
      ORT: { required: "Bitte geben Sie Ihren Ort an" },
      LAND: { required: "Bitte geben Sie Ihr Land an" }
    },
    showErrors: function(errorMap, errorList) {
      console.log(this);
      var errors = '';
      $("#validation_error").html();
      $.each(errorList, function() { errors += " * " + this.message + "<br>"; });
      $("#validation_error").html(errors);
    }
  });
});
</script>
</body>
</html>
}