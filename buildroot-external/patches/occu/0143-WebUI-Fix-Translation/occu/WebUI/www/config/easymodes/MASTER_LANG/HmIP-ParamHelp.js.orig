jQuery.extend(true,langJSON, {
  "de" : {
    "HelpTitle" : "Hilfe",
    "noHelpAvailable" : "Es steht keine Hilfe zur Ver%FCgung",
    "ROUTER_MODULE_ENABLED" : "<b>Ger%E4t dient als Router</b><br/><br/>Durch diese Option kann das Ger%E4t Homematic IP Funkbefehle weiterleiten. Es dient somit als Reichweitenverl%E4ngerung f%FCr abgesetzte Komponenten.",
    "ENABLE_ROUTING" : "<b>Routing aktiv</b><br/><br/>Durch diese Option versucht das Ger%E4t %FCber einen Homematic IP Router zu kommunizieren, sobald es den Empf%E4nger nicht direkt erreichen kann.",
    "BLIND_REFERENCE_RUNNING_TIME" : "Nachdem Sie den Wert der Fahrzeit per Hand ge%E4ndert haben, ist der CCU die Position der Jalousie/Rolllade nicht mehr bekannt. Daher sollten sie anschlie%DFend eine Kalibrierfahrt (einmal ganz hoch oder herunter) durchf&uuml;hren. Dadurch stellen sie sicher, dass der CCU die genaue Position der Jalousie/Rolllade wieder bekannt ist.<br/><br/>" +
      "Das gilt auch f%FCr Ger%E4te mit automatischer Kalibrierfahrt, wenn Sie sich entschlie%DFen, den Wert der Fahrzeit per Hand zu %E4ndern.",
    "BLIND_AUTOCALIBRATION" : "Die automatische Kalibrierfahrt ermittelt die Fahrzeit f%FCr die Behangh%F6he. Die Lamellenverstellzeit ist davon nicht betroffen und muss von Hand eingetragen werden.",

    "BLOCKING_PERIOD" :
      "Die Bewegungs-/Pr%E4senzerkennung kann f%FCr die hier gew%E4hlte Zeit deaktiviert werden, indem ein Taster o. %E4. mit diesem Kanal verkn%FCpft wird. " +
      "Sobald der Kanal einen Schaltbefehl empf%E4ngt, wird die Erkennung f%FCr die gew%E4hlte Zeit unterdr%FCckt. Nach Ablauf der Zeit, arbeitet der Bewegungs-/Pr%E4senzmelder wieder wie gewohnt.",

    "PERMANENT_FULL_RX" :
      "Um den Stromverbrauch batteriebetriebener Ger%E4te m%F6glichst gering zu halten, sind diese Ger%E4te per default nicht in st%E4ndiger H%F6rbereitschaft. " +
      "%C4nderungen, die Sie z. B. auf dieser Kanalkonfigurationsseite vornehmen, werden dadurch erst dann %FCbertragen, wenn das Ger%E4t bet%E4tigt wird oder seinen Status sendet.<br/><br/>" +
      "Mit diesem Parameter k%F6nnen Sie dieses Verhalten auf Kosten der Batterielebensdauer %E4ndern, so dass sich das Ger%E4t in st%E4ndiger H%F6rbereitschaft befindet und %C4nderungen unverz%FCglich %FCbernommen werden.",

    "COND_TX_DECISION_ABOVE_BELOW" :
      "%C4ndern Sie diesen Parameter nur, wenn es wirklich notwendig ist. Eine %C4nderung dieses Wertes kann dazu f%FChren, " +
      "dass Verkn%FCpfungen mit diesem Kanal nicht mehr erwartungsgem%E4%DF arbeiten.",

    "DELAY_COMPENSATION" : "Es gibt Motoren, die nach dem Einschalten mit einer gewissen Verz%F6gerung loslaufen. Dieser Parameter bietet Ihnen die M%F6glichkeit, den Wert der Verz%F6gerung einzustellen.",

    "SPDR_CHANNEL_MODE" :
      "<ul>" +
        "<li class='diagramHelpCustomModeLi1'>" +
          "<b>1 - \${optionInactiv}</b><br/>" +
          "Z%E4hlabh%E4ngiges Schalten des Sensors deaktiviert."+
        "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          "<b>2 - \${optionPassageCounterDetectionLR}</b><br/>" +
          "Ist die Anzahl der gew%FCnschten Durchg%E4nge erreicht, wird der gew%E4hlte Entscheidungswert gesendet "+
          "und direkte Verkn%FCpfungen, die auf diesen Wert reagieren, getriggert.<br/><br/>" +
          "In diesem Modus reagiert der Sensor auf Durchg%E4nge aus beiden Richtungen." +
        "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          "<b>3 - \${optionPassageCounterDetectionL}</b><br/>" +
          "Hier gilt das Gleiche, wie unter Punkt 2. Der Sensor reagiert aber nur noch auf Durchg%E4nge von Rechts nach Links."+
         "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          "<b>4 - \${optionPassageCounterDetectionR}</b><br/>" +
          "Auch hier gilt das Gleiche, wie unter Punkt 2. Der Sensor reagiert aber nur noch auf Durchg%E4nge von Links nach Rechts."+
         "</li>" +

        // "<li class='diagramHelpCustomModeLi1'>" +
        //   "<b>5 - \${optionPassageCounterDeltaLR}</b><br/>" +
        //   " not in use "+
        // "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          //"<b>5 - \${optionPassageCounterDeltaL}</b><br/>" +
          "<b>5 -Differenz der Durchg%E4nge - Links </b><br/>" +
            "In diesem Modus wird eine interne Z%E4hlervariable bei erkanntem Durchgang nach LINKS um 1 erh%F6ht und bei " +
            "erkanntem Durchgang nach RECHTS um 1 verringert. Der Minimalwert der internen Z%E4hlervariablen ist NULL der Maximalwert ist 1000.<br/><br/>" +
            "Mit dem einstellbaren oberen und unteren Differenzwert wird eine Hysterese erzeugt. Erreicht der interne Z%E4hler den " +
            "oberen Differenzwert, wird ein Schaltbefehl mit dem eingestellten oberen Entscheidungswert an den/die " +
            "Verkn%FCpfungspartner gesendet. Durchg%E4nge dar%FCber hinaus werden bis zum Maximalwert weitergez%E4hlt, f%FChren aber " +
            "zu keinem weiteren Schaltbefehl. Erst mit erreichen des unteren Differenzwertes, wird ein Schaltbefehl mit dem " +
            "unteren Entscheidungswert an den/die Verkn%FCpfungspartner gesendet." +
         "</li>" +

        "<li class='diagramHelpCustomModeLi1'>" +
          //"<b>6 - \${optionPassageCounterDeltaR}</b><br/>" +
          "<b>6 -Differenz der Durchg%E4nge - Rechts </b><br/>" +
            "In diesem Modus wird eine interne Z%E4hlervariable bei erkanntem Durchgang nach RECHTS um 1 erh%F6ht und bei " +
            "erkanntem Durchgang nach LINKS um 1 verringert. Der Minimalwert der internen Z%E4hlervariablen ist NULL der Maximalwert ist 1000.<br/><br/>" +
            "Mit dem einstellbaren oberen und unteren Differenzwert wird eine Hysterese erzeugt. Erreicht der interne Z%E4hler den " +
            "oberen Differenzwert, wird ein Schaltbefehl mit dem eingestellten oberen Entscheidungswert an den/die " +
            "Verkn%FCpfungspartner gesendet. Durchg%E4nge dar%FCber hinaus werden bis zum Maximalwert weitergez%E4hlt, f%FChren aber " +
            "zu keinem weiteren Schaltbefehl. Erst mit erreichen des unteren Differenzwertes, wird ein Schaltbefehl mit dem " +
            "unteren Entscheidungswert an den/die Verkn%FCpfungspartner gesendet." +
             "</li>" +
      "</ul>",

    "hintPERMANENT_FULL_RX" :
      "<b><u>Bitte beachten Sie:</u></b><br/>"+
      "Im Batteriebetrieb ist dieses Ger%E4t nicht in st%E4ndiger H%F6rbereitschaft. In diesem Fall kann die Unterdr%FCckung der Bewegungserkennung (Empfangskanal) " +
      "nicht in einer Verkn%FCpfung verwendet werden. Im Batteriebetrieb ist dieses nur mit den ger%E4teeigenen Tasten des HmIP-SMI55 m%F6glich. "+
      "Gleiches gilt in Programmen f%FCr das Ein-/Ausschalten der Bewegungserkennung.",

    "EVENT_FILTER_NUMBER_motionDetect":
      "Hier k%F6nnen Sie die Empfindlichkeit der Bewegungserkennung einstellen. Dabei bedeutet ein hoher Wert eine h%F6here Empfindlichkeit.",

    "ALARM_MODE_ZONE_1 - currently not in use" :
      "F%FCr den Fall, dass die "+ HMIdentifier.de.CCUShortName + " aus irgendwelchen Gr%FCnden nicht erreichbar ist, k%F6nnen Sie hier die Zonen w%E4hlen, " +
      "die dann ............",
    "MIN_INTERVAL" :
      "Der Bewegungsmelder meldet die erste erkannte Bewegung sofort, weitere Bewegungen dann erneut wieder nach der hier gew%E4hlten Zeit.",
    "MIN_INTERVAL_PRESENCE" :
      "Der Pr%E4senzmelder meldet die erste erkannte Bewegung sofort, weitere Bewegungen dann erneut wieder nach der hier gew%E4hlten Zeit.",

    "LOCAL_RESET_DISABLED" : "Bitte beachten Sie, dass dieses Ger%E4t nach Aktivierung dieser Funktion nicht mehr %FCber die Ger%E4tetaste zur%FCckgesetzt werden kann. " +
    "Ein Zur%FCcksetzen des Ger%E4tes ist in diesem Fall nur noch %FCber die Zentrale m%F6glich.<br/><br/>" +
    "<b>Bitte erstellen Sie vor Aktivierung der Funktion ein Backup Ihrer Zentrale, in dem dieses Ger%E4t bereits enthalten ist.</b>",

    "BRIGHTNESS_FILTER" : "Der Helligkeitsfilter im Bewegungsmelder misst etwa alle 6 Minuten einen Helligkeitswert. %DCber den Dropdown-Button bestimmen Sie, wie viele dieser Werte gespeichert werden. Der niedrigste der gespeicherten Werten wird f%FCr die Auswertung verwendet.",

    "CONTACT_BOOST" : "Um dem Korrodieren und m%F6glichen Funktionseinschr%E4nkungen der Taster bzw. Schalter vorzubeugen, kann der 'Korrosionsschutz' aktiviert werden. " +
    "Dieser sorgt daf%FCr, dass kurzzeitig ein erh%F6hter Strom durch einen angeschlossenen Taster oder Schalter flie%DFt, wenn er bet%E4tigt wird. Der Stromimpuls wirkt der Korrosion entgegen.<br/><br/>" +
    "Diese Funktion sollte nur bei Netzspannungs-Tastern und Schaltern aktiviert werden und keinesfalls bei Mikrotastern oder anderen Kontakten mit geringem Schaltverm%F6gen.",

    "repetitionOffTimeSound" : "W%E4hlen Sie mit der Ausschaltdauer die Pause zwischen den Wiederholungen. Wird eine dauerhafte Ausschaltdauer gew%E4hlt, wird der Parameter Wiederholungen ignoriert.",
    "repetitionOffTimeDimmer" : "W%E4hlen Sie mit der Ausschaltdauer die Pause zwischen den Wiederholungen. Wird eine dauerhafte Einschaltdauer oder Ausschaltdauer gew%E4hlt, wird der Parameter Wiederholungen ignoriert.",

    "comment" : "text changed - see sphm-542",
    "CYCLIC_INFO_MSG" : 
    "Jedes Ger%E4t sendet seinen Status mindestens einmal am Tag. " +

     "Ist der Parameter <b>${stringTableCyclicInfoMsg}</b> aktiviert, wird der Status <u>zus%E4tzlich</u> in einem Zeitraster nach folgender Formel gesendet:<br/><br/> " +
    "<div style=\"margin-left:20px\">" +
      "<u>Zeit f%FCr eine Statusmeldung, wenn sich der Status %E4ndert:</u><br>" +
      "<b>(A+1) x C Sekunden</b><br/><br/>" +
      "In diesem Intervall werden Werte %FCbertragen, die sich nur langsam %E4ndern, z. B. Temperatur. Einstellungen einzelner Ger%E4te-Kan%E4le zum Senden von Messwerten haben Vorrang.<br/></br>"+

      "<u>Zeit f%FCr eine Statusmeldung, wenn sich der Status nicht %E4ndert:</u><br/>" +
      "<b>(A+1) x (B+1) x C Sekunden</b><br/><br/>" +
      "In diesem Intervall werden Statusmeldungen gesendet, auch wenn sich der Status seit der letzten Sendung nicht ver%E4ndert hat. " +
      "Damit kann gepr%FCft werden, ob das Ger%E4t in Reichweite / in Betrieb ist.<br/><br/>" +
    "</div>" +
    "Dabei gilt:<br/><br/>"+
    "<b>A = ${stringTableCyclicInfoMsgDis}</br><br/>" +
    "B = ${stringTableCyclicInfoMsgDisUnChangedwoBR}</br><br/>" +
    "C = Zuf%E4llige Zeit zwischen 120 und 184 Sekunden</b></br><br/>",

    "OPTIMUM_START_STOP" : "Die Optimum-Start-/Stopp-Funktion berechnet automatisch die ben%F6tigte Vorlaufzeit, um eine gew%FCnschte Temperatur zum eingestellten Zeitpunkt im Heizprofil bereits erreicht zu haben. Das Heizprofil wird dabei vorausschauend betrachtet.",

    "EVENT_FILTER_TIME" :
    "Bei der Verwendung von passiven Glasbruchmeldern ist eine Event-Filterzeit von mindestens 60 Sekunden zu w%E4hlen.",

    "EVENT_FILTER_PERIOD" :
      "Die Filterzeit des Sensors wird durch die Multiplikation der Werte <b>Filterzeitz%E4hler</b> und <b>Filterbasis</b> bestimmt.<br/><br/>" +
      "Das Ergebnis ergibt die Event-Filterzeit in Sekunden. Dabei bedeutet ein hoher Wert eine l%E4ngere Filterzeit.",

    "helpBrightnessLux" : "F%FCr die Funktionalit%E4t dieser Verkn%FCpfung muss der vom Sensor ermittelte Helligkeitswert, der sehr hohe Werte annehmen kann, "+
      "in einen Wert von 0 - 255 konvertiert werden. Geben Sie hier den von Ihnen gew%FCnschten Helligkeitswert ein, wird der konvertierte Wert im Feld Helligkeitsschwelle eingetragen.",

    "COND_TX_FALLING" :
      "Damit Verkn%FCpfungen mit diesem Kanal funktionieren, muss dieser Parameter aktiviert werden.<br/><br/>" +
      "Bei Unterschreitung des unteren Grenzwertes, wird der entsprechende Entscheidungswert gesendet, <u>wenn vorher der obere Grenzwert %FCberschritten wurde.</u><br/><br/>" +
      "Der Entscheidungswert wird nur einmal gesendet. Soll er in regelm%E4%DFigen Abst%E4nden gesendet werden, aktivieren Sie zus%E4tzlich den n%E4chsten Parameter 'Entscheidungswert zyklisch senden.'",

    "COND_TX_FALLING_Temp" :
      "Damit Verkn%FCpfungen mit diesem Kanal funktionieren, muss dieser Parameter aktiviert werden.<br/><br/>" +
      "Bei Unterschreitung der unteren Temperturschwelle, wird der entsprechende Schaltbefehl gesendet, <u>wenn vorher die obere Temperaturschwelle %FCberschritten wurde.</u><br/><br/>" +
      "Der Schaltbefehl wird nur einmal gesendet. Soll er in regelm%E4%DFigen Abst%E4nden gesendet werden, aktivieren Sie zus%E4tzlich den n%E4chsten Parameter 'Schaltbefehl zyklisch senden.'",


    "COND_TX_RISING" :
      "Damit Verkn%FCpfungen mit diesem Kanal funktionieren, muss dieser Parameter aktiviert werden.<br/><br/>" +
      "Bei %DCberschreitung des oberen Grenzwertes, wird der entsprechende Entscheidungswert gesendet, <u>wenn vorher der untere Grenzwert unterschritten wurde.</u><br/><br/>" +
      "Der Entscheidungswert wird nur einmal gesendet. Soll er in regelm%E4%DFigen Abst%E4nden gesendet werden, aktivieren Sie zus%E4tzlich den n%E4chsten Parameter 'Entscheidungswert zyklisch senden.'",

    "COND_TX_RISING_Temp" :
      "Damit Verkn%FCpfungen mit diesem Kanal funktionieren, muss dieser Parameter aktiviert werden.<br/><br/>" +
      "Bei %DCberschreitung der oberen Temperaturschwelle, wird der entsprechende Schaltbefehl gesendet, <u>wenn vorher die untere Temperaturschwelle unterschritten wurde.</u><br/><br/>" +
      "Der Schaltbefehl wird nur einmal gesendet. Soll er in regelm%E4%DFigen Abst%E4nden gesendet werden, aktivieren Sie zus%E4tzlich den n%E4chsten Parameter 'Schaltbefehl zyklisch senden.'",


      "FILTER_SIZE_ANALOG_INPUT_TRANSMITTER" :
        "Die H%F6he der anliegende Eingangsspannung wird alle 100 ms gepr%FCft. D. h., es werden 10 Messungen/Sekunde durchgef%FChrt.<br/><br/> " +
        "Dieser Parameter bestimmt, wieviele Messungen f%FCr den Mittelwert des auszugebenen Spannungswertes verwendet werden. " +
        "Bei einem Wert von z. B. 2, werden entsprechend 2 Werte verwendet. Beispiel:<br/><br/>" +
        "&nbsp;&nbsp;&nbsp;Wert 1: 5.4V, Wert 2: 5.6V - Der Mittelwert betr%E4gt (5.4V+5.6V) / 2 = 5.5V<br/><br/>" +
        "Der Status, d. h. der Mittelwert der kurz vor der %DCbertragung anliegenden Eingangsspannung, wird in einem bestimmten Intervall gesendet. " +
        "Dieses Intervall k%F6nnen Sie durch den Parameter 'Zyklische Statusmeldung' des Kanal 0 beeinflussen. Lesen Sie dazu bitte die dazugeh%F6rige Hilfe.<br/><br/>" +
        "",

    "PWM_AT_LOW_VALVE_POSITION" :
      "Der Parameter sollte aktiviert werden, wenn sich in einem Raum mit mehreren Heizkreisen, bei kleiner Ventilposition (< 15%) unterschiedliche Temperaturen auf der Oberfl%E4che des Fu%DFbodens einstellen.<br/><br/>" +
      "Des Weiteren kann der Parameter aktiviert werden, wenn es bei kleinen Ventilpositionen zu Ger%E4uschentwicklungen am Heizkreisverteiler kommt. In diesem Fall ist zus%E4tzlich ein Wert bei " +
      "Parameter 'Ventilpositionen Umschaltwert' auszuw%E4hlen.",

    "ON_MIN_LEVEL" : 
      "Wurde der Parameter 'Automatische Umschaltung von Stetig auf PWM' aktiviert, kann durch eine Eingabe des Umschaltwertes die automatische Umschaltung von Stetig auf PWM f%FCr kleine " +
      "Ventilpositionen f%FCr alle Kan%E4le aktiviert werden.",

    "ABORT_EVENT_SENDING_CHANNELS" :
      "Damit das Ger%E4t unverz%FCglich auf einen neuen Tastendruck reagiert, kann der noch laufende Sendevorgang eines alten Tastendruckes abgebrochen werden. " +
      "Bei Tastenpaaren, z. B. f%FCr Hochfahren und Runterfahren, sollten dazu jeweils beide Auswahlfelder an beiden Tastenkan%E4len aktiviert werden.<br/><br/>" +
      "Bei Verwendung als Einzeltaste sollte jeweils nur das Auswahlfeld mit der Nummer des eigenen Tastenkanals ausgew%E4hlt werden.",

    "ABORT_EVENT_SENDING_CHANNELS_ACCESS_TRANSCEIVER" :
      "Damit das Ger%E4t unverz%FCglich auf einen g%FCltig empfangenden Code reagieren kann, " +
      "kann ein noch laufender Sendevorgang eines vorhergehenden Code abgebrochen werden.<br/><br/>" +
      "Ist ein Code f%FCr mehr als einen Kanal g%FCltig, sollten dazu jeweils die Auswahlfelder der Kan%E4le ausgew%E4hlt werden. " +
      "Wird der Code nur f%FCr einen Kanal genutzt, sollte jeweils nur das Auswahlfeld mit der Nummer des genutzten Kanals ausgew%E4hlt werden.",


    "POSITION_SAVE_TIME" :
    "Zeit, nach der die aktuelle Position als 'alter Wert' gewertet wird.",

    "SENSOR_SENSITIVITY" : "Bei Verwendung als Ersch%FCtterungssensor, erm%F6glicht dieser Parameter die Einstellung der Empflindlichkeit des Sensors. Dabei gilt:<br/><br/>" +
    "16G = sehr unempfindlich<br/>" +
    "8G<br/>" +
    "4G<br/>" +
    "2G<br/>" +
    "2G+<br/>" +
    "2G++ = sehr empfindlich",

    "SENSOR_SENSITIVITY_rain" :
    "Hier k%F6nnen Sie die Empfindlichkeit des Regensensors einstellen. Dabei bedeutet ein hoher Wert eine h%F6here Empfindlichkeit.<br/><br/>"  +
    "Einstellung 0%:   Es muss nahezu die ganze Sensorfl%E4che mit Regenwasser bedeckt sein, damit der Sensor ausl%F6st.<br/><br/>" +
    "Einstellung 100%: Es reicht ein kleiner Tropfen ( von ca. 70mm&sup3; ) f%FCr ein Ausl%F6sen des Sensors aus ( je nach Region mehr oder weniger ).<br/><br/>" +
    "<b>Achtung:</b><br/>Wenn f%FCr einen Test des Sensors Trinkwasser verwendet wird, reduziert sich die Menge an notwendigem Wasser f%FCr eine Ausl%F6sung, da dessen Leitwert i.d.R. um mehrere 10er Potenzen h%F6her liegt.",

    "TRIGGER_ANGLE" : "Bei Verwendung als Lageerkennungssensor, bestimmt dieser Parameter, um wieviel Grad sich der Winkel der Ober-/Unterseite des Sensors in Bezug zur Waagerechten %E4ndern muss, " +
      "damit ein Event ausgel%F6st wird.",

    "TRIGGER_ANGLE_2" : "Bei Verwendung als Lageerkennungssensor, bestimmt dieser Parameter, um wie viel Grad sich der Winkel der Ober-/Unterseite des Sensors in Bezug zur Waagerechten %E4ndern muss, damit der senkrechte Zustand  erreicht wird.",

    "DIM_STEP" :
      "Dieser Parameter bestimmt die Anzahl der Stufen, um die Helligkeit von 0% - 100% hochzudimmen, bzw. von 100% - 0 % herunterzudimmen.<br/><br/>" +
      "<u>Beispiel:</u><br/>" +
      "Ein Wert von 4 sorgt daf%FCr, dass die Helligkeit in 25%-Stufen (100% / 4) gew%E4hlt werden kann. Wird nun eine Pegelbegrenzung von 50% eingestellt, dann wird dieser Wert in 2 Stufen erreicht.<br/><br/>" +
      "Ein Wert von 1 stellt die Helligkeit sofort auf den gew%FCnschten Wert.",

    "AUTO_SENSOR_CLEANING" :
      "Wenn sich der Sensor im Messmodus befindet, wird periodisch nach dem mit diesem Parameter definierten Reinigungsintervall eine automatische Reinigung des Str%F6mungpfades ausgel%F6st. " +
      "Dadurch wird der L%FCfter 10 Sekunden lang auf die maximale Drehzahl beschleunigt, um den im Inneren des L%FCfters angesammelten Staub auszublasen.<br/><br/>" +
      "  - Die Messwerte werden nicht aktualisiert, w%E4hrend die Ventilator-Reinigung l%E4uft.<br/>" +
      "  - Setzen Sie das Intervall auf 'Nicht aktiv', um die automatische Reinigung zu deaktivieren.",

    "AQI_MODE" :
      "Durch die nationalen Umweltschutzbeh%F6rden werden unterschiedliche Grenzwerte f%FCr die Feinstaubkonzentrationen festgelegt. " +
      "W%E4hlen Sie hier zwischen den nationalen Grenzwerten der EU oder den USA.",

    "TEMPERATURE_OFFSET_STE2" :
      "Die Temperatur wird an zwei separaten Sonden gemessen. Dadurch ergibt sich eine Abweichung in der ermittelten Temperatur. " +
      "Zum Ausgleich kann hier f%FCr die jeweilige Sonde ein Temperatur-Offset eingestellt werden. " +
      "Bringen Sie dazu die Sonden auf die gleiche Temperatur (gegebenenfalls einige Minuten warten) und lesen die erfassten Werte. " +
      "Die daraus ermittelte Differenz k%F6nnen Sie als positiven oder negativen Offset auf einem der Kan%E4le einstellen." ,

    "MULTICAST_ROUTER_MODULE_ENABLED" :
      "Durch die Funktion 'Multicast-Routing' kann das Verhalten des Ger%E4ts in seiner Rolle als Funk-Router zur Reichweitenverl%E4ngerung angepasst werden.  " +
      "Multicast-Funkbefehle steuern die Funkpartner parallel (also gleichzeitig) an. Auf diese Weise wird das gleichzeitige Einschalten, z. B. von mehreren Leuchten, erm%F6glicht. " +
      "Anschlie%DFend werden per Unicast-Funkbefehl alle Partner seriell (nacheinander) angefunkt. Daraus resultiert in einer Reichweitenverl%E4ngerung eine erh%F6hte Funklast beim Router, welche ggf. zu Funktionseinschr%E4nkungen f%FChren kann (Duty-Cycle).<br/><br/>" +
      "Ist der Parameter nicht aktiviert, werden die Empf%E4nger immer einzeln nacheinander angesprochen und dadurch das Funkaufkommen gering gehalten.<br/><br/>" +
      "Eine Besonderheit sind die Homematic IP Wandthermostate. Sind diese mit einem Schaltaktor verkn%FCpft, senden die Wandthermostate immer nur einen Multicast-Funkbefehl. "+
      "Damit ein Schaltaktor f%FCr die Heizungsregelung mit einem Funk-Router genutzt werden kann, muss diese Funktion also aktiv sein.<br/><br/>" +
      "Wir empfehlen die Einstellung mit deaktivierten Parameter, sofern dies nicht aus den oben genannten Gr%FCnden erforderlich ist.",

    "LED_DISABLE_CHANNELSTATE" : 
      "Durch Deaktivieren dieses Parameters ist die interne LED wie im Funktionstest bei jeder Bewegung aktiv.<br/><br/>" +
       "Achtung, dies hat deutlichen Einfluss auf die Batterielebensdauer. Nutzen Sie diese Funktion daher nur tempor%E4r, um den Erfassungsbereich zu optimieren.",

    "OUTPUT_SWAP" :
      "Dieser Parameter erm%F6glicht es, die Ausg%E4nge zu tauschen. AUF/ZU bzw. HOCH/RUNTER wird dann zu ZU/AUF bzw. RUNTER/HOCH.<br/><br/>" +
      "Dies kann z. B. dazu genutzt werden, um Fehler bei der Installation zu korrigieren.",

    "OUTPUT_SWAP_SERVO" :
      "Dieser Parameter erm%F6glicht das Tauschen der Drehrichtung.",

    "AUTO_HYDRAULIC_ADJUSTMENT" : "%DCber die Ventile wird ein hydraulischer Abgleich durchgef%FChrt, d.h. die Durchflussmenge an den Ventilen wird so eingestellt, dass sich alle R%E4ume mit der gleichen Geschwindigkeit erw%E4rmen.",

    "CALIBRATION_PPM" :
      "Bei der automatischen Kalibrierung des CO2-Sensors wird der niedrigste Messwert innerhalb vordefinierter Kalibrierintervalle als neue Referenz angenommen. " +
      "Frische Au%DFenluft hat einen typischen Wert von zirka 400 ppm. Bei normaler Innenraumnutzung wird angenommen, dass die Innenraumluft innerhalb eines Zeitraums von einer Woche mindestens einmal das Niveau von frischer Au%DFenluft erreicht. " +
      "<br/><br/>Die Kalibrierung ben%F6tig mindestens drei Kalibrierintervalle, um den Endwert sicher zu bestimmen." +
      "<br/><br/>F%FCr R%E4ume mit Dauerbelegung 24/7 muss diese Funktion deaktiviert werden. Eine Kalibrierung sollte in dem Fall alle 1-2 Jahre manuell durchgef%FChrt werden.",

    "MOUNTING_ORIENTATION" : "Dieser Parameter erm%FCglicht es, den Displayinhalt um 180 Grad zu drehen.",
    "MOUNTING_ORIENTATION_A" : "Dieser Parameter erm%F6glicht es, den Aktor im gew%FCnschten Winkel einzusetzen. ",

    "POWERUP_ONTIME_UNIT" :
      "W%E4hlen Sie die Wartezeit bis zum <i>Auto Relock</i>, nachdem das T%FCrschloss entriegelt oder ge%F6ffnet wurde.<br/><br/>" +
      "Um <i>Auto Relock</i> zu nutzen, muss au%DFerdem mindestens ein entsprechender Eintrag vom Typ 'Modus f%FCr den T%FCrschlossantrieb' im Wochenprogramm vorgenommen werden.",
    
    "DOOR_LOCK_DIRECTION" : "W%E4hlen Sie aus, auf welcher Seite sich das T%FCrschloss und der T%FCrschlossantrieb befinden, wenn Sie von innen auf die T%FCr schauen.",
    "DOOR_LOCK_DIRECTION_1" : "W%E4hlen Sie aus, auf welcher Seite sich das T%FCrschloss und der T%FCrschlosssensor befinden, wenn Sie von innen auf die T%FCr schauen.",
    "DOOR_LOCK_TURNS" : "W%E4hlen Sie aus, wieviele Umdrehungen notwendig sind, um die T%FCr vollst%E4ndig zu verriegeln.",
    "DOOR_LOCK_NEUTRAL_POS" : "Geben Sie die Position an, in welcher der Schl%FCssel eingesteckt bzw. herausgezogen werden kann, wenn der Zylinder nicht verriegelt ist.",

    "DOOR_LOCK_END_STOP_OFFSET_OPEN" : "Winkelbereich des mechanischen Endanschlags ausgehend von Neutralstellung Entriegelt in Richtung %D6ffnen f%FCr die Zustandserkennung",
    "DOOR_LOCK_END_STOP_OFFSET_LOCKED" : "Winkelbereich des mechanischen Endanschlags ausgehend von Neutralstellung Verriegelt in Richtung Endanschlag geschlossen f%FCr die Zustandserkennung",
    "DOOR_LOCK_HOLD_TIME" : "Haltezeit der Schlossfalle beim %D6ffnen",
    "DOOR_LOCK_DISABLE_ACOUSTIC_CHANNELSTATE" : "Deaktiviert die akustische R%FCckmeldung am Ende einer motorischen Fahrt. Das akustische Signal bei geringer Batteriespannung bleibt unver%E4ndert.",

    "DEVICE_SENSOR_SENSITIVITY" :
      "Mit der Sensor-Empfindlichkeit k%F6nnen Sie den Sensor auf die, f%FCr den jeweiligen Einsatzort passende, Empfindlichkeit einstellen.<br/><br/>" +
      "Abh%E4ngig von Material und St%E4rke der Sensorfl%E4che, muss die Empfindlichkeit entsprechend angepasst werden, um eine eindeutige Bet%E4tigung %FCber die Sensorfl%E4chen zu gew%E4hrleisten.<br/><br/>" +
      "Der Wert 1 entspricht der geringsten, w%E4hrend der Wert 5 der h%F6chsten Empfindlichkeit entspricht.",

    "PIR_SENSITIVITY" :
      "Mit diesem Parameter kann die Erfassungsdistanz und - empfindlichkeit f%FCr die Bewegungserkennung eingestellt werden. " +
      "Dabei enstpricht<br/>" +
      "<ul>" +
        "<li><pre>&nbsp;&nbsp;&nbsp;&nbsp;0% = Unempfindlich/Geringe Distanz</pre></li>" +
        "<li>100% = Hochempfindlich/Hohe Distanz<br/></li>" +
      "</ul>"+
      "<b><u>Achtung:</u></b><br/>" +
      "Unter bestimmten Umgebungsbedingungen kann eine hoch eingestellte Empfindlichkeit Fehlausl%F6sungen verursachen. " +
      "Passen Sie diese Einstellung bei Bedarf entsprechend an. " +
      "%DCber den Parameter 'Empfindlichkeit' kann eine geeignete Konfiguration vorgenommen werden.",

    "BLOCKING_ON_SABOTAGE" : "<b>Bei Sabotage sperren.</b><br/></br>" +
      "Solange %FCber den Sabotagekontakt Sabotage ausgel%F6st ist, werden eingehende Codes nicht akzeptiert",

    "BLOCKING_ON_SABOTAGE_FWI" : "<b>Bei Sabotage sperren.</b><br/></br>" +
      "Solange %FCber den Sabotagekontakt Sabotage ausgel%F6st ist, werden eingehende Wiegand-Codes nicht akzeptiert",

    "BLOCKING_PERMANENT" : "<b>Anzahl der Fehleingaben f%FCr vollst%E4ndiges Blockieren.</b><br/></br>" +
      "%DCber diesen Parameter kann festgelegt werden, nach wieviel fehlerhaften Codes das Ger%E4t vollst%E4ndig gesperrt wird, " +
      "also eingehende Befehle dauerhaft nicht akzeptiert werden.<br/></br>" +
      "Die erneute Freigabe ist manuell %DCber die Zentrale unter \'Status und Bedienung\' vorzunehmen.",

    "BLOCKING_PERMANENT_WKP" : "<b>Anzahl der weiteren Fehleingaben f%FCr permanente Eingabesperre nach tempor%E4rer Eingabesperre</b><br/></br>" +
      "Nachdem das Ger%E4t durch fehlerhafte Codes tempor%E4r gesperrt wurde, kann %DCber diesen Parameter festgelegt werden, nach wieviel weiteren fehlerhaften Codes das Ger%E4t permanent gesperrt, " +
      "also eingehende Befehle dauerhaft nicht akzeptiert werden.<br/></br>" +
      "Die erneute Freigabe ist manuell %FCber die Zentrale unter \'Status und Bedienung\' vorzunehmen.",

    "BLOCKING_TEMPORARY" : "<b>Anzahl fehlerhafter Codeeingaben f%FCr tempor%E4res Sperren.</b></br></br>" +
      "%DCber diesen Parameter kann festgelegt werden, nach wieviel fehlerhaften Codes das Ger%E4t tempor%E4r gesperrt wird. "+
      "D. h., eingehende Befehle werden eine Zeit lang akzeptiert.<br/><br/>" +
      "Wurde die tempor%E4re Sperrung aktiviert, f%FChrt jede weitere ung%FCltige Codeeingabe zur Verl%E4ngerung der zeitlichen Sperrung.",

    "BLOCKING_PERMANENT_FWI" : "<b>Anzahl fehlerhafter Wiegand-Codeeingaben f%FCr permanentes Sperren</b><br/></br>" +
      "%DCber diesen Parameter kann festgelegt werden, ab wann das Wiegand-Interface permanent sperrt, " +
      "also eingehende Wiegand-Codes dauerhaft nicht akzeptiert werden.<br/></br>" +
      "Die erneute Freigabe ist manuell %FCber die Zentrale unter \'Status und Bedienung\' vorzunehmen.",

    "BLOCKING_TEMPORARY_FWI" : "<b>Anzahl fehlerhafter Wiegand-Codeeingaben f%FCr tempor%E4res Sperren</b></br></br>" +
      "%DCber diesen Parameter kann festgelegt werden, ab wann das Wiegand-Interface tempor%E4r gesperrt wird. "+
      "D. h. eingehende Wiegand-Codes werden eine Zeit lang nicht akzeptiert.<br/><br/>" +
      "Wurde die tempor%E4re Sperre aktiviert, f%FChrt jede weitere ung%FCltige Codeeingabe zur Verl%E4ngerung der Sperrung.",

    "PSM_CHANNEL_OPERATION_MODE" :
      "<b>${optionModeConsumption}:</br> Misst angeschlossene Verbraucher" +
      "<b>${optionModeFeeding}:</br> Misst eingespeiste Leistung, z. B. f%FCr kleine PV-Anlagen.",

    "GROUP_SMOKE_DETECTOR" :
      "<div class='MultiChannelChooserRow'>" +
      "Ist keine Gruppe ausgew%E4hlt, ist die Alarmierung kompatibel mit allen Rauchwarnmeldern des gleichen Typs (HmIP-SWSD).<br/>" +
      "Bei Aktivierung einer oder mehrerer Gruppen, ist die Alarmierung nur bei Rauchwarnmeldern mit %FCbereinstimmender Gruppenauswahl aktiv.<br/>" +
      "</div>",

    "DISABLE_DEVICE_ALIVE_SIGNAL" : "Dieser Parameter erm%F6glicht, das rote Blinken der %DCberwachungs-LED alle 45 s im %DCberwachungszustand zu deaktivieren.",

    "REPEAT_ENABLE" :
    "Ist diese Checkbox aktiviert, arbeitet der Rauchwarnmelder als Repeater f%FCr Funk-Telegramme anderer Rauchwarnmelder innerhalb der Installation bzw. Gruppe, um die Alarmierungsreichweite zu erh%F6hen.<br/><br/>" +
    "Bereits wiederholte Telegramme werden nicht erneut wiederholt. Eine Verkettung von Repeatern ist also nicht m%F6glich.<br/><br/>" +
    "Diese Funktion ist nur f%FCr die Funk-Kommunikation von Rauchwarnmeldern untereinander vorgesehen, um auch bei Stromausfall noch eine zuverl%E4ssige Alarmierung abgelegener Rauchwarnmelder zu erm%F6glichen.",

    "VOLTAGE_0" :
      "Mit diesem Parameter k%F6nnen Sie die Ausgangsspannung beeinflussen.<br/><br/>" +
      "Beispiel: Wert der Ausgangsspannung im ausgeschaltetem Zustand (0 %):<br/><br/>" +
      "50 % -> 5 V oder 10 % -> 1 V",

    "VOLTAGE_100" :
      "Mit diesem Parameter k%F6nnen Sie die Ausgangsspannung beeinflussen.<br/><br/>" +
      "Beisplel: Wert der Ausgangsspannung im eingeschaltetem Zustand (100 %):<br/><br/>" +
      "100 % -> 10 V oder 50 % -> 5 V",

    "SAMPLE_INTERVAL" :
      "Dieser Wert definiert die Zeitspanne f%FCr die %DCberpr%FCfung von T%FCr- bzw. Fensterkontakten (T%FCr/Fenster ge%F6ffnet oder geschlossen).<br/><br/>" +
      "Die Batterielaufzeit des Ger%E4ts bezieht sich auf eine Abtastrate von 0,5 Sekunden. " +
      "Durch eine Verl%E4ngerung der Zeitspanne, z. B. durch Heraufsetzen der Abtastrate auf 1 Sekunde, kann die Batterielaufzeit deutlich erh%F6ht werden.<br/><br/>" +
      "Je nach Anwendungsfall, ist eine Verl%E4ngerung der Zeitspanne sinnvoll. W%E4hrend eine l%E4ngere Abtastrate bei einer Heizungsl%F6sung unkritisch ist, " +
      "sollte bei einer Sicherheitsl%F6sung zur Alarmmeldung die Abtastrate k%FCrzer eingestellt werden.",

    "SCREEN_MANAGEMENT" :
      "<b><u>Screen Management</u></b><br/>" +
      "W%E4hlen Sie hier die Reihenfolge, in der die m%F6glichen Screens des Displays durchgebl%E4ttert werden. " +
      "Nachdem Sie das Display an die CCU angelernt haben, steht zun%E4chst 1 Screen zur Verf%FCgung. Das ist Screen 1. "+
      "Um weitere Screens zu aktivieren, gehen Sie folgenderma%DFen vor: <br/><br/>" +
      "F%FCr jeden Screen gibt es 2 Auswahlboxen, mit denen Sie jeweils den linken und rechten Nachbarscreen w%E4hlen k%F6nnen. "+
      "Das wird durch die Sympole <b><</b> und <b>></b> gekennzeichnet. Um nun z. B. den zweiten Screen zu aktivieren, w%E4hlen Sie als rechten Nachbar " +
      "mit der Auswahlbox <b>></b> unter Screen 1 den Wert 2 aus. Um von Screen 2 wieder zur%FCck zu Screen 1 zu gelangen, aktivieren Sie in der Auswahlbox <b><</b> unter Screen 2 den Wert 1. ",

    "DEVICE_OPERATION_MODE_RGBW" :
      "Der HmIP-RGBW kann in vier verschiedenen Modi betrieben werden:<br/><br/>" +
      " - RGBW: Betrieb mit einem Rot, Gr%FCn, Blau, Wei%DF - Strip<br/>" +
      " - RGB: Betrieb mit einem Rot, Gr%FCn, Blau -Strip<br/>" +
      " - Tunable White: Betrieb mit bis zu zwei Tunable White Stips (bestehend aus Kaltwei%DF- und Warmwei%DF-LEDs)<br/>" +
      " - Einzelkan%E4le: Betrieb von bis zu vier einzelnen Ausgangskan%E4len.<br/></br>" +
      "Ge%E4ndert werden kann der Modus nur, wenn keine Verkn%FCpfungen oder Programme bestehen, die das Ger%E4t verwenden.",

    "POWERUP_JUMPTARGET_RGBW" :
      "Verhalten des Ausgangskanal nach Zufuhr der Versorgungsspannung.",

    "POWERUP_ON_HUE" :
      "Farbton nach Zufuhr der Versorgungsspannung.<br/><br/>" +
      "(360 = letzter 'Ein'-Wert; 361 = keine %C4nderung)",

    "POWERUP_ON_SATURATION":
      "Farbs%E4ttigung nach Zufuhr der Versorgungsspannung.<br/><br/>" +
      "(100.5 = letzter 'Ein'-Wert; 101 = keine %C4nderung)",

    "POWERUP_ON_COLOR_TEMPERATURE_RGBW":
      "Farbtemperatur nach Zufuhr der Versorgungsspannung",

    "EVENT_DELAY" :
      "Verz%F6gerungszeit, bis ein stabiler Kanalzustand der Zentrale %FCbermittelt wird.",

    "EVENT_RANDOMTIME" :
    "Maximal zuf%E4llige Zeit, die zur Eventverz%F6gerung addiert wird.",

    "ON_MIN_LEVEL_RGBW" :
      "Pegelsprung von OFF zu ON, um Bereiche ohne Leuchten des Leuchtmittels zu %FCberspringen.",

    "HARDWARE_COLOR_TEMPERATURE_WARM_WHITE" :
      "Farbtemperatur der warmwei%DFen LED des angeschlossenen Tunable-White-Strips.",

    "HARDWARE_COLOR_TEMPERATURE_COLD_WHITE" :
      "Farbtemperatur der kaltwei%DFen LED des angeschlossenen Tunable-White-Strips.",

    "CONTROL_REPRESENTATION" :
      "Mit der Representation kann f%FCr die Kachel ein weiterer Kanal zur direkten Ansteuerung eines Ziellevels %FCber zwei zus%E4tzliche Tasten auf der Kachel aktiviert werden.<br/><br/>" +
      "<b>Keine</b>: Zus%E4tzliche Levelansteuerung deaktiviert.<br/><br/>" +
      "<b>Dimmer</b>: %DCber die Tasten Plus und Minus kann ein Ziellevel eingestellt werden.<br/><br/>" +
      "<b>Rolladen/Jalousie</b>: %DCber Tasten Rauf und Runter kann ein Ziellevel eingestellt werden.<br/><br/>" +
      "<b>Schaltaktor</b>: %DCber die Tasten f%FCr Ein und Aus kann der Ziellevel 100% bzw 0% eingestellt werden.<br/><br/>",

    "DALI_GROUP" :
      "Hier%FCber kann das DALI-Ger%E4t bis zu 16 DALI-Gruppen zugeordnet werden. " +
      "Die DALI-Gruppen k%F6nnen wie einzelne Kan%E4le angesprochen werden.<br/><br/>" +
      "Zu beachten ist, dass die Funktionalit%E4t der DALI-Gruppe der Funktionalit%E4t der DALI-Leuchte entspricht, die der Gruppe zugeordnet ist und die niedrigste Kanalnummer hat.",

    "PYRO_CHANNEL_OPERATION_MODE" :
      "W%E4hlen Sie hier eine der drei m%F6glichen Erfassungszonen, die f%FCr diesen Kanal genutzt werden sollen.<br/><br/>" +

      "<u>Welche Zone befindet sich wo am Ger%E4t?</u><br/><br/>" +

      "Bei Frontalansicht auf das Ger%E4t ist<br/><br/>" +

      "<ul>" +
        "<li>Zone 1 = Der gesamte 90%B0-Winkelbereich links</li>" +
        "<li>Zone 2 = Der gesamte 90%B0-Winkelbereich rechts</li>" +
        "<li>Zone 3 = Der gesamte 360%B0-Winkelbereich unterhalb des Ger%E4tes</li>" +
      "</ul><br/><br/> " +

      "<b><u>Achtung</u></b><br/><br/>" +
      "Folgende Parameter der Kan%E4le 1 bis 3 beeinflussen die jeweilige Zone 1 - 3:<br><br/>" +

      "<ul>" +
        "<li>${stringTableSensivity}</li>" +
        "<li>${stringTableSensorSensivity}</li>" +
        "<li>${stringTableATCMode}</li>" +
      "</ul>",

    "DIM_LEVEL_LOWEST" :
      "Dimmlevel, ab dem das Leuchtmittel zu leuchten beginnt bzw. beginnt, heller zu werden.<br/><br/>" +
      "Zu beachten ist, dass dieser Wert nicht kleiner sein kann, als der Wert, der beim Parameter <i>Minimaler Pegel im Zustand EIN</i> eingestellt ist.",

    "DIM_LEVEL_HIGHEST" : "Dimmlevel ab dem das Leuchtmittel die maximale Helligkeit erreicht hat.",

    "INPUT_COPRO_ENABLED" :
      "Bei Aktivierung dieses Parameters wird der Kanal %FCber den CoProzessor ausgewertet, anstatt %FCber den HmIP-Prozessor.<br/><br/>" +
      "Im Normalfall sollte die Auswertung %FCber den Coprozessor nicht aktiviert werden, " +
      "da z. B. die Kan%E4le 1 und 2 nicht direkt vom Coprozessor auswertbar sind und die Auswertung %FCber den HmIP-Prozessor stromsparender ist. " +
      "Aktivieren Sie diesen Parameter daher nur, wenn es in der Anleitung eines Applikationsmoduls gefordert wird.<br/></br>" +
      "Je nach verwendetem Applikationsmodul kann es erforderlich sein, die Auswertung %FCber den Coprozessor laufen zu lassen, " +
      "um z.B. Schaltbefehle mit Bedingung oder Level nutzen zu k%F6nnen.<br/><br/>" +
      "N%E4heres entnehmen Sie der Anleitung der jeweiligen Applikation.",

    "ESI_CHANNEL_OPERATION_MODE" :
      "Der HmIP-ESI bestimmt den Sensortyp und das Protokoll automatisch. Das Ergebnis ist in diesem Feld eingetragen. " +
      "Um den Vorgang der automatischen Erkennung nach einem Tausch vom Sensor oder Z%E4hler erneut zu starten, l%F6schen Sie das Ger%E4t und lernen es wieder an.",

    "ESI_METER_OBIS_SEARCH_STRING" :
      "Anhand der OBIS-Kennzahlen identifiziert der HmIP-ESI die relevanten Daten vom Z%E4hler. Sie werden automatisch ermittelt. Liefert die automatische Ermittlung nicht die gew%FCnschten Werte, " +
      "so k%F6nnen andere Kennzahlen im OBIS-Wertegruppenformat C.D.E eingetragen werden.<br/><br/>" +
      "Mehrere Werte lassen sich zusammenfassen:<br/><br/>" +
      "1.8.1+2+3 z. B. addiert 1.8.1 + 1.8.2 + 1.8.3<br/><br/>" +
      "1 - 2.7.0 z. B. subtrahiert 1.7.0 - 2.7.0.",

    "CHANNEL_ACTIVE_CLIMATECONTROL" : 
      "Diese Checkbox dient dazu, Fehlermeldungen an unbenutzten Kan%E4len auf der Seite Status/Bedienung zu vermeiden. Aktivieren Sie diese Checkbox daher nur, wenn der Kanal auch benutzt wird.",

    "DISPLAY_MODE" :
      "Mit diesem Parameter kann zwischen folgenden beiden Display-Layouts gew%E4hlt werden:<br/><br/>" +
      "<b><u>Reduzierter Modus</u></b><br>" +
      "Die Informationen im Display sind auf ein Minimum reduziert, bei besonders gro%DFer Anzeige der Soll-Temperatur.<br/><br/>" +
      "\"<b><u>Funktioneller Modus</u></b><br/>" +
      "Im funktionellen Modus werden mehr Informationen auf dem Display dargestellt.<br/>",

      "DISPLAY_INVERTED_COLORS"  : "Mit diesem Parameter w%E4hlen Sie f%FCr das Display die normale Anzeige oder den Dunkelmodus.",

    "noMoreHelp" : ""
  },

  "en" : {
    "HelpTitle" : "Help",
    "noHelpAvailable" : "No help available",
    "ROUTER_MODULE_ENABLED" : "<b>The device acts as router</b><br/><br/>This option allows the Homematic IP device to forward wireless commands. It therefore is used to increase the reach of standalone components.",
    "ENABLE_ROUTING" : "<b>Routing active</b><br/><br/>Through this option the device attempts to communicate via a Homematic IP router as soon as it cannot directly reach the receiver.",
    "BLIND_REFERENCE_RUNNING_TIME" : "After you have manually changed the movement time value, the CCU has no information anymore on the blind/shutter position. You should therefore perform a calibration run (once completely to up and down). This ensures that the CCU is updated on the blind/shutters exact position.<br/><br/>" +
      "This applies also to devices with automatic calibration run if you decide to manually change the movement time value.",
    "BLIND_AUTOCALIBRATION" : "The automatic calibration run determines how long the shutter/blind needs to move to the desired level. The time for adjusting the slats is not considered and has to be entered manually.",


    "BLOCKING_PERIOD" :
    "The motion and presence detection can be deactivated for the time defined here, by linking a push-button or similar to this channel. " +
    "As soon as the channel receives a switching command, the detection is muted for the time defined. After the time has expired the motion detector/presence sensor continues normal operation.",

    "PERMANENT_FULL_RX" :
      "To keep the energy consumption of battery operated devices at a low level, the devices are not permanently listening in the default settings. " +
      "Changes that are made e.g. on this configuration page are transferred only after the device has been operated or sends a status.<br/><br/>" +
      "This parameter can be used to change the behaviour to permanent listening. Thus, changes are adapted immediately but however the battery lifetime will be reduced faster.",


    "COND_TX_DECISION_ABOVE_BELOW" :
      "Change this parameter only if it is really necessary. Changing this value can lead to " +
      "incorrect operation of connections with this channel.",

    "DELAY_COMPENSATION" : "Some motors start running after switching on with a certain delay. The parameter can be used to adjust the duration of the delay.",

    "SPDR_CHANNEL_MODE" :
    "<ul>" +
            "<li class='diagramHelpCustomModeLi1'>" +
              "<b>1 - \${optionInactiv}</b><br/>" +
              "Deactivate counter-based switching of sensor"+
            "</li>" +

            "<li class='diagramHelpCustomModeLi1'>" +
              "<b>2 - \${optionPassageCounterDetectionLR}</b><br/>" +
              "If the desired number of passages is reached, the defined decision value will be sent "+
              "and direct connections that react to this value are triggered.<br/><br/>" +
              "In this mode, the sensor reacts to passages from both directions." +
            "</li>" +

            "<li class='diagramHelpCustomModeLi1'>" +
              "<b>3 - \${optionPassageCounterDetectionL}</b><br/>" +
              "Here, the same applies as for item 2. The sensor only reacts on passages from right to left."+
             "</li>" +

            "<li class='diagramHelpCustomModeLi1'>" +
              "<b>4 - \${optionPassageCounterDetectionR}</b><br/>" +
              "Here, also the same applies as for item 2. The sensor only reacts to passages from left to right."+
             "</li>" +

            "<li class='diagramHelpCustomModeLi1'>" +
              //"<b>5 - \${optionPassageCounterDeltaL}</b><br/>" +
              "<b>5 -Difference of passages - left </b><br/>" +
                "In this mode an internal counter variant is increased by 1 on detected passage to LEFT and " +
                "reduced by 1 on passage detected to RIGHT. The mimium value of the internal counter variable is ZERO and the maximum value is 1000.<br/><br/>" +
                "The adjustable upper and lower difference value is used to create a hysteresis. If the internal counter reaches the " +
                "upper difference value, a switching command is send with the upper decision value to the " +
                "connection partner(s). Additional passages are counted until the maximum value but will not cause " +
                "additional switching commands. Only when reaching the lower difference value, a switching command " +
                "with the lower decision value is sent to the connection partner(s)." +
             "</li>" +

            "<li class='diagramHelpCustomModeLi1'>" +
              //"<b>6 - \${optionPassageCounterDeltaR}</b><br/>" +
              "<b>6 -Difference of passages - right </b><br/>" +
                "In this mode an internal counter variant is increased by 1 on detected passage to RIGHT and " +
                "reduced by 1 on passage detected to LEFT. The mimium value of the internal counter variable is ZERO and the maximum value is 1000.<br/><br/>" +
                "The adjustable upper and lower difference value is used to create a hysteresis. If the internal counter reaches the " +
                "upper difference value, a switching command is send with the upper decision value to the " +
                "connection partner(s). Additional passages are counted until the maximum value but will not cause " +
                "additional switching commands. Only when reaching the lower difference value, a switching command " +
                "with the lower decision value is sent to the connection partner(s)." +
                 "</li>" +
          "</ul>",


    "hintPERMANENT_FULL_RX" :
      "<b><u>Please note:</u></b><br/>"+
      "In battery mode, this device is not permanently listening. In this case, muting of motion detection (receiver channel) " +
      "cannot be used in a connection. In battery mode, this is only possible using the push-buttons of HmIP-SMI55. The same applies to programmes for switching motion detection on or off.",

    "EVENT_FILTER_NUMBER_motionDetect":
      "You can adjust the sensitivity of the motion detection here. A higher value is equal to a higher sensitivity level.",

    "ALARM_MODE_ZONE_1 - currently not in use" :
      "In case the "+ HMIdentifier.en.CCUShortName + " is not accessible for any reason, you can select the zones here, " +
      "which then ............",
    "MIN_INTERVAL" :
      "The motion detector reports the first detected movement immediately, then further movements again after the time selected here.",
    "MIN_INTERVAL_PRESENCE" :
      "The presence sensor reports the first detected movement immediately, then further movements again after the time selected here.",

    "LOCAL_RESET_DISABLED" : "Please note that the factory settings of this device can no longer be restored via the device button after activating this function. " +
    "In this case, the device reset is only possible via the Central Control Unit.<br/><br/>" +
    "<b>Before activation of this function, please create a backup of your Central Control Unit that already includes this device.</b>",

    "BRIGHTNESS_FILTER" : "The brightness filter of the motion detector measures the brightness approximately every 6 minutes. Use the dropdown button to determine how many of these brightness values are saved. The lowest of the stored values is used for the evaluation.",

    "CONTACT_BOOST" : "In order to prevent corrosion and possible functional restrictions of the buttons or switches, the 'corrosion protection' can be activated. " +
    "This ensures that an increased current flows briefly through a connected pushbutton or switch when it is actuated. The current pulse counteracts corrosion.<br/><br/>" +
    "This function should only be activated with mains voltage push-buttons and switches and under no circumstances with micro push-buttons or other contacts with low switching capacity..",

    "repetitionOffTimeSound" : "Select the pause between the repetitions with the off duration. If a permanent off time is selected, the Repeats parameter is ignored.",
    "repetitionOffTimeDimmer" : "Select the pause between the repetitions with the off duration. If a permanent on-time or off-time is selected, the Repeats parameter is ignored.",

    "comment" : "text changed - see sphm-542",
    "CYCLIC_INFO_MSG" :
        "Each device sends its status at least one a day. " +

     "If the parameter <b>${stringTableCyclicInfoMsg}</b> is activated, the status is send <u>additionally</u> in a time pattern according to the following formula:<br/><br/> " +
    "<div style=\"margin-left:20px\">" +
      "<u>Time for a status message, if the status changes</u><br>" +
      "<b>(A+1) x C seconds</b><br/><br/>" +
      "During this interval, only values are transmitted that change slowly, like temperatures for example. Settings of individual device channels for sending measured values have priority.<br/></br>"+

      "<u>Time for a status message, if the status does not change:</u><br/>" +
      "<b>(A+1) x (B+1) x C seconds</b><br/><br/>" +
      "Status messages are sent at this interval, even if the status has not changed since the last transmission. " +
      "This can be used to check whether the device is within range / in operation<br/><br/>" +
    "</div>" +
    "The following applies:<br/><br/>"+
    "<b>A = ${stringTableCyclicInfoMsgDis}</br><br/>" +
    "B = ${stringTableCyclicInfoMsgDisUnChangedwoBR}</br><br/>" +
    "C = Random time between 120 and 184 seconds</b></br><br/>",

    "OPTIMUM_START_STOP" : "The optimum start/stop function automatically calculates the required lead time to achieve a desired temperature already at the set time in the heating profile. The heating profile is considered in advance.",

    "EVENT_FILTER_TIME" :
    "When using passive glass break sensors, an event filter time of at least 60 seconds has to be selected.",

    "EVENT_FILTER_PERIOD" :
      "The filter time of the sensor is determined by multiplying the values <b>filter time counter</b> and <b>filter basis</b>.<br/><br/>." +
      "The result is the event filter time in seconds. A higher value is equal to a larger filter time.",

    "helpBrightnessLux" : "To ensure functionality of this connection, the brightness value determined by the sensor (which can be very high) must be converted to a value between 0 and 255. "+
      "If you enter the brightness value you want to use here, the converted value is entered in the 'brightness threshold' field.",

    "COND_TX_FALLING" :
      "This parameter must be activated in order for connections in this channel to function properly.<br/><br/>" +
      "If the value falls below the lower limit, the corresponding decision value is sent, <u>if the value has previously exceeded the upper limit.</u><br/><br/>" +
      "The decision value is sent only once. If it is to be sent in regular intervals, also activate the next parameter 'Send decision value cyclically'.",

    "COND_TX_FALLING_Temp" :
      "This parameter must be activated in order for connections in this channel to function properly.<br/><br/>" +
      "If the temperature falls below the lower temperature threshold, the corresponding switch command is sent, <u>if the value has previously exceeded the upper temperature threshold.</u><br/><br/>" +
      "The switch command is sent only once. If it is to be sent in regular intervals, also activate the next parameter 'Send switch command cyclically'.",

    "COND_TX_RISING" :
      "This parameter must be activated in order for connections in this channel to function properly. <br/><br/>" +
      "If the value exceeds the upper limit, the corresponding decision value is sent. <u>if the value falls below the lower limit.</u><br/><br/>" +
      "The decision value is sent only once. If it is to be sent in regular intervals, also activate the next parameter 'Send decision value cyclically'.",

    "COND_TX_RISING_Temp" :
      "This parameter must be activated in order for connections in this channel to function properly. <br/><br/>" +
      "If the temperature exceeds the upper limit, the corresponding decision value is sent. <u>if the value falls below the lower temperature threshold.</u><br/><br/>" +
      "The switch command is sent only once. If it is to be sent in regular intervals, also activate the next parameter 'Send switch command cyclically'.",

    "FILTER_SIZE_ANALOG_INPUT_TRANSMITTER" :
      "The level of the applied input voltage is checked every 100 ms. This means that 10 measurements/second are carried out.<br/><br/>"+
      "This parameter determines how many measurements are used for the mean value of the voltage value to be output. With a value of e.g. 2, 2 values are used accordingly. Example:<br/><br/>"+
      "&nbsp;&nbsp;&nbsp;Value 1: 5.4V, Value 2: 5.6V - The average value is (5.4V+5.6V) / 2 = 5.5V<br/><br/>"+
      "The status, i.e. the average value of the input voltage present shortly before transmission, is transmitted at a certain interval. You can influence this parameter using the parameter ‘Cyclical status message' of channel 0. Please read the corresponding help text.<br/><br/>",

    "PWM_AT_LOW_VALVE_POSITION" :
      "The parameter should be activated if different temperatures occur with a small valve position (< 15%) on the surface of the floor in a room with several heating circuits.<br/><br/>" +
      "Furthermore, the parameter can be activated if with small valve positions noise develops at the heating circuit distributor. " +
      "In this case, an additional value must be selected for the 'Valve positions changeover value' parameter." ,

    "ON_MIN_LEVEL" :
      "If the parameter 'Automatic switchover from continuous to PWM' has been activated, the automatic switchover from continuous to PWM for small valve positions can be activated for all channels by entering the switchover value.",

    "ABORT_EVENT_SENDING_CHANNELS" :
      "To ensure that the device reacts immediately to a new button press, the transmission process of an old button press that is still in progress can be cancelled.  " +
      "For key pairs, e.g. for moving up and down, both selection fields on both key channels should be activated.<br/><br/>" +
      "When using as a single key, only the selection field with the number of your own key channel should be selected." ,

    "ABORT_EVENT_SENDING_CHANNELS_ACCESS_TRANSCEIVER" :
      "In order for the device to be able to react immediately to a code that is being received correctly, " +
      "a transmission of a preceding code that is still in progress can be cancelled.<br/><br/>" +
      "If a code is valid for more than one channel, the selection fields of the channels should be selected.  " +
      "If the code is only used for one channel, only the selection field with the number of the channel used should be selected.",

    "POSITION_SAVE_TIME" :
    "Time after which the current position is interpreted as 'old value'.",

    "SENSOR_SENSITIVITY" : "When using as vibration sensor, this parameter can be used to set the sensor sensitivity. That means:<br/><br/>" +
    "16G = very insensitive<br/>" +
    "8G<br/>" +
    "4G<br/>" +
    "2G<br/>" +
    "2G+<br/>" +
    "2G++ = very sensitive",

    "SENSOR_SENSITIVITY_rain" :
      "You can adjust the rain sensor sensitivity here. A higher value implies higher sensitivity.<br/><br/>"  +
      "Setting 0%:   Almost the entire sensor surface must be covered with rainwater for the sensor to trigger.<br/><br/>" +
      "Setting 100%: A small drop (of approx. 70mm&sup3;) is sufficient to trigger the sensor (more or less, depending on the area).<br/><br/>" +
      "<b>Please note:</b><br/>If drinking water is used for a test of the sensor, the amount of water required for triggering is reduced, as its conductance value is usually several potencies of 10 higher.",


    "TRIGGER_ANGLE" : "When used as position detection sensor, this parameter determines by how many degrees the angle of the top/bottom of the sensor has to change in relation to the horizontal, " +
      "to trigger an event.",

    "TRIGGER_ANGLE_2" : "When being used as a position detection sensor, this parameter determines by how many degrees the angle of the top/bottom side of the sensor must change in relation to the horizontal so that the vertical state is achieved.",

    "DIM_STEP" :
      "This parameter determines the number of steps to dim the brightness from 0% - 100% up, or from 100% - 0% down.<br/><br/>" +
      "<u>Example:</u><br/>" +
      "A value of 4 ensures that the brightness can be adjusted in 25% steps (100% / 4). If a level limitation of 50% is set, in this case the value is reached in 2 steps.<br/><br/>" +
      "A value of 1 immediately sets the brightness to the desired value.",

    "AUTO_SENSOR_CLEANING" :
      "If the sensor is in measuring mode, automatic cleaning of the air stream path is triggered periodically according to the cleaning interval defined with this parameter. " +
      "This accelerates the fan to maximum speed for 10 seconds to blow out the dust accumulated inside the fan.<br/><br/>" +
      "  - The measured values are not updated while the fan cleaning is running.<br/>" +
      "  - To disable automatic cleaning, set the interval to 'Not active'.",
    
    "AQI_MODE" :
      "Different limit values for particulate matter concentrations are set by the national environmental protection authorities. " +
      "Choose between the national limits of the EU or the USA.",

    "TEMPERATURE_OFFSET_STE2" :
      "The temperature is measured via two separate sensors. This results in a deviation in the temperature measured. " +
      "For compensation, a temperature offset can be set here for the respective sensor. " +
      "To do this, bring the sensors to the same temperature (wait a few minutes if necessary) and read the recorded values. " +
      "The resulting deviation can be set as positive or negative offset for one of the channels.",


    "MULTICAST_ROUTER_MODULE_ENABLED" :
      "The 'Multicast Routing' function can be used to adapt the behaviour of the device in its function as a wireless router to extend the range.  " +
      "Multicast radio commands control the wireless communication partners simultaneously (i.e. in parallel). In this way it is possible to switch on several devices like lights at the same time. " +
      "Afterwards all partners are serially (successively) addressed by unicast radio command. This results in an increased radio traffic at the router, which may lead to functional restrictions (duty cycle).<br/><br/>" +
      "If the parameter is not activated, the sensors are always addressed individually one after the other, thus keeping the radio traffic low.<br/><br/>" +
      "An exception are the Homematic IP Wall Thermostats. If they are connected to a switch actuator, the wall thermostats only send one multicast radio command at the same time. "+
      "For a switch actuator to be used for heating control with a wireless router, this function must therefore be active.<br/><br/>" +
      "We recommend the setting with deactivated parameters, unless this is necessary for the reasons mentioned above.",

    "LED_DISABLE_CHANNELSTATE" :
      "By deactivating this parameter, the internal LED is active with every movement just like in the function test.<br/><br/>" +
      "Please note that this will influence on the battery lifetime. Therefore, only use this function temporarily to optimise the detection range.",

    "OUTPUT_SWAP" :
      "This parameter can be used to swap the outputs. OPEN/CLOSED or UP/DOWN will then be changed into CLOSED/OPEN or DOWN/UP.<br/><br/>" +
      "It can be used, for example, to correct errors during installation.",

    "OUTPUT_SWAP_SERVO" :
      "This parameter enables you to change the direction of rotation.",

    "AUTO_HYDRAULIC_ADJUSTMENT" : "A hydraulic balancing is performed via the valves, which means that the flow rate at the valves is adjusted so that all rooms heat up at the same rate.",

    "CALIBRATION_PPM" :
      "The lowest measured value within pre-defined calibration intervals is used as a new reference for the automatic calibration of the CO2 sensor. " +
      "Fresh outside air has a typical value of approx. 400 ppm. For normal use indoors, it is accepted that the indoor air will reach the level of fresh outdoor air at least once within a period of one week." +
      "<br/><br/>The calibration requires at least three calibration intervals for the reliable determination of the maximum value.\n" +
      "<br/><br/>This function must be deactivated for rooms with a 24/7 permanent occupancy. In this case, a manual calibration should be performed every 1-2 years.",

    "MOUNTING_ORIENTATION" : "This parameter makes it possible to rotate the display content by 180 degrees.",
    "MOUNTING_ORIENTATION_A" : "This parameter enables the actuator to be placed at the required angle.",

    "POWERUP_ONTIME_UNIT" :
      "Select the delay time until <i>Auto Relock</i> is executed after the door lock has been unlocked or opened.<br/><br/>" +
      "In order to use <i>Auto Relock</i>, at least one corresponding entry of the type 'Mode for the door lock drive' must also be entered in the week progam.",

    "DOOR_LOCK_DIRECTION" : "Select on which side the door lock and the door lock drive are located when you look at the door from the inside.",
    "DOOR_LOCK_DIRECTION_1" : "Select on which side the door lock and the door lock sensor are located when you look at the door from the inside.",
    "DOOR_LOCK_TURNS" : "Please select the number of turns that are necessary in order to completely lock the door.",
    "DOOR_LOCK_NEUTRAL_POS" : "Select the position in which the key can be inserted or removed when the cylinder is not locked.",

    "DOOR_LOCK_END_STOP_OFFSET_OPEN" : "Angle range of the mechanical end position starting from an 'unlocked' neutral position towards the open position for detecting states",
    "DOOR_LOCK_END_STOP_OFFSET_LOCKED" : "Angle range of the mechanical end position starting from a 'locked' neutral position towards the closed position for detecting states",
    "DOOR_LOCK_HOLD_TIME" : "Holding time for the lock latch when the door is opened",
    "DOOR_LOCK_DISABLE_ACOUSTIC_CHANNELSTATE" : "Deactivates the acoustic feedback at the end of a motorised movement. The acoustic signal for low battery voltage remains unchanged.",


    "DEVICE_SENSOR_SENSITIVITY" :
      "You can set the correct sensor sensitivity value for the respective installation site using Sensor sensitivity.<br/><br/>" +
      "The sensitivity must be adjusted accordingly depending on the material and thickness to ensure unique activation via the sensor surfaces.<br/><br/>" +
      "Value 1 corresponds to the lowest level, while value 5 is the highest sensitivity level.",

    "PIR_SENSITIVITY" :
      "The detection distance and sensitivity for motion detection can be set using this parameter. " +
      "This means<br/>" +
      "<ul>" +
      "<li><pre>&nbsp;&nbsp;&nbsp;&nbsp;0% = insensitive/short distance</pre></li>" +
      "<li>100% = high sensitivity/long distance<br/></li>" +
      "</ul>"+
      "<b><u>Attention:</u></b><br/>" +
      "A high sensitivity level can cause false triggering under specific circumstances. " +
      "This setting should be adjusted accordingly as needed. " +
      "A suitable configuration can be made via the 'Sensitivity' parameter.",

    "BLOCKING_ON_SABOTAGE" : "<b>Lock in case of sabotage.</b><br/></br>" +
      "As long as sabotage is triggered via the sabotage contact, incoming codes are not accepted.",

    "BLOCKING_ON_SABOTAGE_FWI" : "<b>Lock in case of sabotage.</b><br/></br>" +
      "As long as sabotage is triggered via the sabotage contact, incoming Wiegand codes are not accepted.",

    "BLOCKING_PERMANENT" : "<b>Number of faulty code entries for complete locking.</b><br/></br>" +
      "This parameter can be used to define after how many incorrect codes the device is completely locked,  " +
      "i. e. incoming commands are not accepted permanently.<br/></br>" +
      "Re-enabling must be done manually via the page \'Status&Control\'",

    "BLOCKING_PERMANENT_WKP" : "<b>Number of further incorrect entries for permanent input lock after temporary input lock</b><br/></br>." +
      "After the device has been temporarily locked by erroneous codes, this parameter can be used to determine after how many further erroneous codes the device will be permanently locked,  " +
      "This means that incoming commands are not accepted permanently.<br/></br>" +
      "The new release must be done manually via the page \'Status&Control\'",

    "BLOCKING_TEMPORARY" : "<b>Number of faulty code entries for temporary locking.</b></br></br>" +
      "This parameter can be used to define after how many incorrect codes the device is temporarily locked, "+
      "i.e. incoming commands are not accepted for a while.<br/><br/>" +
      "If temporary locking has been activated, each further invalid code entry leads to an extension of the temporary lock.",

    "BLOCKING_PERMANENT_FWI" : "<b>Number of faulty Wiegand code entries for complete locking.</b><br/></br>" +
      "This parameter can be used to define the point at which the Wiegand interface is permanently locked. " +
      "This means that incoming Wiegand codes are not accepted permanently.<br/></br>" +
      "Re-enabling must be done manually via the page \'Status&Control\'",

    "BLOCKING_TEMPORARY_FWI" : "<b>Number of faulty Wiegand code entries for temporary locking</b></br></br>" +
      "This parameter can be used to define the point at which the Wiegand interface is temporarily locked, "+
      " i.e. incoming Wiegand codes are not accepted for a while.<br/><br/>" +
      "If the temporary lock has been activated, each further invalid code entry leads to an extension of the lock.",

    "PSM_CHANNEL_OPERATION_MODE" :
      "<b>${optionModeConsumption}:</br> Measures connected loads" +
      "<b>${optionModeFeeding}:</br> Measures fed-in power, e.g. for small PV systems",

    "GROUP_SMOKE_DETECTOR" :
      "<div class='MultiChannelChooserRow'>" +
      "If no group is selected, the alarm is compatible with all smoke detectors of the same type (HmIP-SWSD).<br/>" +
      "If one or more groups are activated, the alarm is only active with smoke detectors with matching group selection.<br/>" +
      "</div>",

    "DISABLE_DEVICE_ALIVE_SIGNAL" : "This parameter allows you to deactivate the monitoring LED’s flashing red every 45 sec in the monitoring state.",

    "REPEAT_ENABLE" :
      "If this check box is activated, the smoke alarm works as a repeater for wireless telegrams from other smoke alarms within the installation or group to increase the alerting range.<br/><br/>" +
      "Telegrams that have already been repeated are not repeated again. It is therefore not possible to daisy chain repeaters.<br/><br/>" +
      "This function is only intended to allow smoke alarms to communicate wirelessly with each other, so that remote smoke alarms can be reliably alerted even in case of power failure.",

    "VOLTAGE_0" :
      "Use this parameter to influence the output voltage.<br/><br/>" +
      "Example: value of the output voltage when switched off (0 %):<br/><br/>" +
      "50 % -> 5 V oder 10 % -> 1 V",

    "VOLTAGE_100" :
      "Use this parameter to influence the output voltage.<br/><br/>" +
      "Example: value of the output voltage when switched on (100 %):<br/><br/>" +
      "100 % -> 10 V oder 50 % -> 5 V",

    "SAMPLE_INTERVAL" :
      "This value defines the time taken for checking door or window contacts (door/window open or closed).<br/><br/>" +
      "The battery runtime is based on a scanning frequency of 0.5 seconds." +
      "By lengthening the time take, e.g., by reducing the scanning frequency to 1 second, the battery runtime can be greatly increased.<br/><br/>" +
      "Depending on the application, it makes sense to lengthen the time taken.  Whereas a longer scanning frequency is uncritical in a heating solution, " +
      "the scanning frequency should be made shorter in a security solution for the alarm response.",

    "SCREEN_MANAGEMENT" :
      "<b><u>Screen Management</u></b><br/>" +
      "Select the order in which the possible screens of the display are scrolled through here. " +
      "After you have taught the display to the CCU, 1 screen is initially available. This is Screen 1. " +
      "To activate further screens, proceed as follows:   <br/><br/>" +
      "For each screen there are 2 selection boxes, with which you can select the left and right neighboring screen respectively. "+
      "This is indicated by the symbols < and >. To activate the second screen, for example, select the following as the right neighbor " +
      "using the > selection box under Screen 1. To return from Screen 2 to Screen 1, activate the value 1 in the < selection box under Screen 2.",

    "DEVICE_OPERATION_MODE_RGBW" :
      "The Homematic IP LED Controller – RGBW can be operated in four different modes:<br/><br/>" +
      " - RGBW: Operation with a Red, Green, Blue, White Strip<br/>" +
      " - RGB: Operation with a Red, Green, Blue Strip<br/>" +
      " - Tunable White: Operation with up to two Tunable White Strips (comprising cold white and warm white LEDs)<br/>" +
      " - Single Channels: Operation of up to four single output channels.<br/></br>" +
      "The mode can be changed only if there are no links or programs using the device.",

    "POWERUP_JUMPTARGET_RGBW" :
      "Behaviour of the output channel after feeding the supply voltage.",

    "POWERUP_ON_HUE" :
      "Colour shade after feeding the supply voltage.<br/><br/>" +
      "(360 = last 'on' value; 361 = no change)",

    "POWERUP_ON_SATURATION":
      "Colour saturation after feeding the supply voltage.<br/><br/>" +
      "(100.5 = last 'on' value; 101 = no change)",

    "POWERUP_ON_COLOR_TEMPERATURE_RGBW":
    "Colour temperature after feeding the supply voltage.",

    "EVENT_DELAY" :
      "Delay until a stable channel status is transmitted to the switchboard.",

    "EVENT_RANDOMTIME" :
      "Maximum random time added to the event delay.",

    "ON_MIN_LEVEL_RGBW" :
      "Level change from OFF to ON to skip areas of the lamp without luminaires.",

    "HARDWARE_COLOR_TEMPERATURE_WARM_WHITE" :
      "Colour temperature of the warm white LED of the connected Tunable White Strip.",

    "HARDWARE_COLOR_TEMPERATURE_COLD_WHITE" :
      "Colour temperature of the cold white LED of the connected Tunable White Strip.",

    "CONTROL_REPRESENTATION" :
      "<b>None</b>: Additional level control disabled.<br/><br/>" +
      " With the representation, another channel for direct control of a target level can be activated for the tile via two additional keys on the tile.<br/><br/>" +
      "<b>Dimmer</b>: Via the keys Plus and Minus a target level can be set.<br/><br/>" +
      "<b>Shutter/blind</b>: A target level can be set via the Up and Down keys.<br/><br/>" +
      "<b>Switch actuator</b>: The target level 100% and 0% can be set via the keys for On and Off.<br/><br/>",

    "DALI_GROUP" :
      "Here, the DALI device can be assigned to up to 16 groups. " +
      "The DALI groups can be addressed like individual channels.<br/><br/> " +
      "Make sure that the functionality of the DALI group corresponds to the functionality of the DALI luminaire that is assigned to the group and has the lowest channel number.",

    "PYRO_CHANNEL_OPERATION_MODE" :
      "Here, select one of the three possible detection zones that should be used for this channel.<br/><br/>" +

      "<u>Which zone is located where on the device?</u><br/><br/>" +

      "With a frontal view of the device<br/><br/>" +

      "<ul>" +
        "<li>Zone 1 = The entire 90%B0 angle area on the left</li>" +
        "<li>Zone 2 = The entire 90%B0 angle area on the right</li>" +
        "<li>Zone 3 = Zone 3 = The entire 360%B0 angle area below the device</li>" +
      "</ul><br/><br/> " +

      "<b><u>Important!</u></b><br/><br/>" +
      "The following parameters of channels 1 to 3 influence the relevant Zone 1 - 3.:<br><br/>" +

      "<ul>" +
        "<li>${stringTableSensivity}</li>" +
        "<li>${stringTableSensorSensivity}</li>" +
        "<li>${stringTableATCMode}</li>" +
      "</ul>",

    "DIM_LEVEL_LOWEST" :
      "Dimming level from which the lamp starts to light up or starts to become brighter.<br/><br/>" +
      "It must be noted that this value cannot be lower than the value that is set in the parameter <i>Minimum level in ON state<i>.",

    "DIM_LEVEL_HIGHEST" : "Dimming level from which the lamp has reached maximum brightness.",

    "INPUT_COPRO_ENABLED" :
      "When this parameter is activated, the channel is evaluated via the co-processor instead of the HmIP processor.<br/><br/>" +
      "Under normal circumstances, evaluation via the co-processor should not be activated, " +
      "as channels 1 and 2, for example, cannot be evaluated by the co-processor directly, plus evaluation via the HmIP processor is more energy-efficient. " +
      "Therefore, you should only activate this parameter if so instructed in the manual for an application module.<br/></br>" +
      "Depending on which application module you use, it may be necessary to conduct the evaluation via the co-processor " +
      "in order to use switching commands with a condition or level.<br/><br/>" +
      "Please refer to your application's manual for more information.",


    "ESI_CHANNEL_OPERATION_MODE" :
      "The HmIP-ESI determines the sensor type and the protocol automatically. The result is entered in this field. " +
      "To restart the automatic detection process after replacing the sensor or meter, delete the device and teach it in again.",

    "ESI_METER_OBIS_SEARCH_STRING" :
      "The HmIP-ESI identifies the relevant data from the meter based on the OBIS identification numbers. The data is determined automatically. If the automatic determination process does not deliver the required values, " +
      "you can enter other identification numbers in the OBIS value group format C.D.E.<br/><br/>" +
      "Multiple values can be grouped together:<br/><br/>" +
      "1.8.1+2+3, for example, denotes addition: 1.8.1 + 1.8.2 + 1.8.3<br/><br/>" +
      "1 - 2.7.0, for example, denotes subtraction: 1.7.0 - 2.7.0.",

    "CHANNEL_ACTIVE_CLIMATECONTROL" :
      "This checkbox is used to avoid error messages for unused channels on the status/operation screen. Therefore, only activate this checkbox if the channel is actually being used.",

    "DISPLAY_MODE" :
      "en* Mit diesem Parameter kann zwischen folgenden beiden Display-Layouts gew%E4hlt werden:<br/><br/>" +
      "<b><u>Reduzierter Modus</u></b><br>" +
      "Die Informationen im Display sind auf ein Minimum reduziert, bei besonders gro%DFer Anzeige der Soll-Temperatur.<br/><br/>" +
      "\"<b><u>Funktioneller Modus</u></b><br/>" +
      "Im funktionellen Modus werden mehr Informationen auf dem Display dargestellt.<br/>",

    "DISPLAY_INVERTED_COLORS"  : "en* Mit diesem Parameter w%E4hlen Sie f%FCr das Display die normale Anzeige oder den Dunkelmodus.",

    "noMoreHelp" : ""
    }
});


