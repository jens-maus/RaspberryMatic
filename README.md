<img height="60px" src="release/logo.png" align="left">

<br/>

**– Das alternative/freie Betriebssystem für Ihre HomeMatic CCU**

[![Current Release](https://img.shields.io/github/release/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/jens-maus/RaspberryMatic/latest/total.svg)](https://github.com/jens-maus/RaspberryMatic/releases/latest)
[![Build](https://github.com/jens-maus/RaspberryMatic/workflows/CI/badge.svg)](https://github.com/jens-maus/RaspberryMatic/actions)
[![Contributors](https://img.shields.io/github/contributors/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/graphs/contributors)
[![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/issues)
[![Percentage of issues still open](http://isitmaintained.com/badge/open/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/issues)
[![Commits since last release](https://img.shields.io/github/commits-since/jens-maus/RaspberryMatic/latest.svg)](https://github.com/jens-maus/RaspberryMatic/releases/latest)
[![License](https://img.shields.io/github/license/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/blob/master/LICENSE)
[![Donate](https://img.shields.io/badge/donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=RAQSDY9YNZVCL)
[![Twitter](https://img.shields.io/twitter/follow/RaspberryMatic.svg?style=social&label=Follow)](https://twitter.com/RaspberryMatic)
[![GitHub stars](https://img.shields.io/github/stars/jens-maus/RaspberryMatic.svg?style=social&label=Star)](https://github.com/jens-maus/RaspberryMatic/stargazers/)

<sub>[Click here for 🇬🇧🇺🇸 english readme](README.en.md)</sub>
### [🚀 Schnellstart](#cookie-features)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[📚 Dokumentation](ttps://github.com/jens-maus/RaspberryMatic/wiki)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[📦 Download](https://github.com/jens-maus/RaspberryMatic/releases/latest)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[🚑 Support](#yum-how-to-contribute)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[👮 Lizenzen](#scroll-license)
___
Bei _RaspberryMatic_ handelt es sich um ein alternatives, OpenSource-basiertes Betriebssystem für die kommerziell entwickelten _[CCU3](https://www.homematic-ip.com/en/products/detail/smart-home-central-control-unit-ccu3.html)_ bzw. _[ELV Charly](https://www.elv.de/elv-smart-home-zentrale-charly-starter-set-bausatz.html)_ Zentralen zur Nutzung von [HomeMatic](http://homematic.com/)/BidCos-RF bzw. [homematicIP](https://www.homematic-ip.com/) Hardware der Firmengruppe [eQ-3](https://eq-3.de)/[ELV](https://elv.de/). RaspberryMatic hat sich zum Ziel gesetzt nicht nur den kompletten Funktionsumfang einer sogn. _HomeMatic CCU SmartHome-Zentrale_ für eine Cloudfreie Nutzung von HomeMatic Geräten für frei erhältliche Single-Board-Computern (SBC) wie z.B. den [RaspberryPi](https://www.raspberrypi.org/), [ASUS Tinkerboard](https://www.asus.com/Single-Board-Computer/Tinker-Board-S/) oder aber auch als virtualisierte Variante für moderne Virtualisierungsumgebungen (z.B. vmWare ESXi, Proxmox, VirtualBox) nutzbar zu machen. Es hat sich auch zum Ziel gesetzt auf verschiedenen Ebenen (WebUI, Linux-Betriebsystem, etc.) Verbesserungen bzw. Bugfixes mitzubringen die in der originalen CCU Firmware von eQ3/ELV (noch) nicht vorhanden sind.
[mehr...](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung)

## :cookie: Features
RaspberryMatic ist systembedingt zu der Betriebssystemsoftware einer CCU-Zentrale der Firma eQ3/ELV (CCU2/CCU3) (die den gleichen Versionsstand hat) 100% kompatibel. Dies bedeutet, das nicht nur die selben HomeMatic/homematicIP Geräte angelernt/genutzt werden können, auch verhält sich RaspberryMatic in Punkto Funktionalität und WebUI vollkommen kompatibel. Des Weiteren kann die komplette Konfiguration zwischen der Standard Betriebssystemsoftware von eQ3/ELV und RaspberryMatic ausgetauscht werden und ein Wechsel zwischen den beiden Betriebssystemen ist somit jederzeit möglich.

Darüber hinaus bringt RaspberryMatic jedoch eine ganze Reihe von Verbesserungen/Erweiterungen, neuen Features und teilweise bereits integrierten Bugfixes mit sich die entweder _noch_ nicht in der originalen CCU Firmware von der Firma eQ3/ELV übernommen wurde oder aus kommerzieller Sicht nicht übernommen werden soll.
[mehr...](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung#features)

## :computer: Voraussetzungen
RaspberryMatic lässt sich momentan auf folgender, kommerziell erhältlicher Kompletthardware (Rechner + HomeMatic-Kommunikationsmodul) installieren:

* [CCU3](https://www.homematic-ip.com/en/products/detail/smart-home-central-control-unit-ccu3.html), [ELV-Charly](https://www.elv.de/elv-smart-home-zentrale-charly-starter-set-bausatz.html)

oder auf folgender selbst zusammengestellter SBC/Kommunikations Hardware:

* _Hardware_:
   * [RaspberryPi](https://www.raspberrypi.org/)
   * [ASUS Tinkerboard](https://www.asus.com/Single-Board-Computer/Tinker-Board-S/)
   * [Intel NUC](https://www.intel.de/content/www/de/de/products/boards-kits/nuc.html)

bzw. unter folgenden Virtualisierungsumgebungen installieren:

* _Virtualisierungsumgebung_:
   * [vmWare ESXi](https://www.vmware.com/de/products/esxi-and-esx.html)
   * [Proxmox Virtual Environment](https://www.proxmox.com/de/)
   * [Oracle VirtualBox](https://www.virtualbox.org/)
   * [Synology Virtual Machine Manager](https://www.synology.com/de-de/dsm/feature/virtual_machine_manager)
   * [QNAP VirtualizationStation](https://www.qnap.com/event/station/de-de/virtualization.php)
   * [vmWare Workstation Player](https://www.vmware.com/de/products/workstation-player/workstation-player-evaluation.html)
   * [QEmu/KVM](https://www.qemu.org/)
   * [HyperV](https://docs.microsoft.com/de-de/virtualization/hyper-v-on-windows/)
   
[mehr...](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung#vorraussetzungen)      

## :cloud: Schnellstart
Unter [Releases](ttps://github.com/jens-maus/RaspberryMatic/releases) steht die Datei `RaspberryMatic-X.XX.XX.YYYYMMDD-XXX.zip` als Download zur Verfügung. Nach Entpacken dieser Datei erhält man eine `*.img` Imagedatei die man auf ein geeignetes Medium (SD-Karte, USB-Stick, SSD oder als virtuelle Disk) mit z.B. dem Imaging-Tool [Etcher](https://etcher.io) auf das Medium "flashen" lassen kann. Danach legt man die SD Karte in den jeweiligen RaspberryPi ein und startet diesen normal. Danach sollte dann RaspberryMatic normal starten und versuchen im Laufe des startes das passende HomeMatic/homematicIP Funkmodul zu initialisieren (das man vorher entsprechend installieren mus). Ist dies erfolgt kann man mittels Webbrowser in seinem lokalen Netzwerk unter Nutzung der Adresse `http://homematic-raspi/` auf die Weboberfläche (WebUI) von RaspberryMatic normal zugreifen.

[mehr...](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#schnellstart)

## :memo: Dokumentation
1. [Einleitung](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung)
   * [Vorraussetzungen](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung#vorraussetzungen)
   * [Features](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung#features)
   * [Limitationen/Einschränkungen](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung#limitationeneinschränkungen)
   * [Lizenzbedingungen & Haftung](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung#lizenz--haftung)
   * [Kommerzieller Vertrieb](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung#kommerzieller-vertrieb)
2. [Installation](https://github.com/jens-maus/RaspberryMatic/wiki/Installation)
   * [Schnellstart](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#schnellstart)
   * [Grundinstallation (Hardware)](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#grundinstallation-hardware)
     * [CCU3](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-CCU3)
     * [ELV-Charly](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-ELV-Charly)
     * [RaspberryPi](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-RaspberryPi)
     * [ASUS Tinkerboard](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-Tinkerboard)
     * [Intel NUC](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-IntelNUC)
   * [Grundinstallation (Virtuell)](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#grundinstallation-virtuell)
     * [vmWare ESXi](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-vmWare-ESXi)
     * [Proxmox Virtual Environment](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-Proxmox-VE)
     * [Oracle VirtualBox](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-VirtualBox)
     * [Synology Virtual Machine Manager](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-Synology-VMM)
     * [QNAP VirtualizationStation](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-QNAP-VirtualizationStation)
     * [vmWare Workstation Player](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-vmWare-Workstation-Player)
     * [QEmu/KVM](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-QEmu)
     * [HyperV](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-HyperV)
   * [Konfigurationsübernahme](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#konfigurationsübernahme)
     * [Umstieg von CCU3](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#umstieg-von-ccu3)
     * [Umstieg von CCU2](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#umstieg-von-ccu2)
     * [Umstieg von CCU1](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#umstieg-von-ccu1)
     * [Umstieg zu virtuellem RaspberryMatic](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#umstieg-zu-virtuellem-raspberrymatic)
   * [Deinstallation](https://github.com/jens-maus/RaspberryMatic/wiki/Deinstallation)
3. [Administration](https://github.com/jens-maus/RaspberryMatic/wiki/Administration)
   * [Firmware Update via WebUI](https://github.com/jens-maus/RaspberryMatic/wiki/Update)
   * [Backup/Restore](https://github.com/jens-maus/RaspberryMatic/wiki/BackupRestore)
   * [Sicherheitshinweise](https://github.com/jens-maus/RaspberryMatic/wiki/Sicherheit)
   * [Erweiterungen/CCU-Addons](https://github.com/jens-maus/RaspberryMatic/wiki/Administration#ccu-addons)
4. Nutzung
   * [WebUI Benutzung](https://github.com/jens-maus/RaspberryMatic/wiki/WebUI-Benutzung)
   * [Tipps&Tricks](https://github.com/jens-maus/RaspberryMatic/wiki/Tipps)
   * Experten-Features
     * [WLAN/WiFi Unterstützung](https://github.com/jens-maus/RaspberryMatic/wiki/WLAN-Nutzung)
     * [Bluetooth Unterstützung](https://github.com/jens-maus/RaspberryMatic/wiki/Bluetooth-Nutzung)
     * [LAN-Gateway Betrieb](https://github.com/jens-maus/RaspberryMatic/wiki/LAN-Gateway-Betrieb)
     * [Log-Level erhöhen für Fehleranalyse](https://github.com/jens-maus/RaspberryMatic/wiki/Loglevel)
5. Support, Mitarbeit
   * [Hilfe suchen](https://github.com/jens-maus/RaspberryMatic/wiki/Hilfe-suchen)
   * [FAQ - Häufig gestellte Fragen](https://github.com/jens-maus/RaspberryMatic/wiki/Faq)
   * [Fehler melden](https://github.com/jens-maus/RaspberryMatic/wiki/Bugreports)
   * [Features wünschen](https://github.com/jens-maus/RaspberryMatic/wiki/FeatureRequests)

## :yum: Support, Mitarbeit
Für Feedback jeglicher Art, Fragen, Vorschläge, Wünsche und Fehlerberichte wird darum gebeten bitte zuerst im jeweiligen RaspberryMatic Teil des HomeMatic-Forum (https://homematic-forum.de/forum/viewforum.php?f=65) einen entsprechenden Beitrag zu erstellen oder an bereits existierenden Beiträgen dort sich zu beteiligen. Sollte aus den Diskussionen dort sich dann ein spezieller Feature-Wunsch oder von anderen Personen bestätigter Bug in RaspberryMatic herauskristallieren wird darum gebeten diesen Bug bzw. diesen Feature-Request im [Issue Tracker](https://github.com/jens-maus/RaspberryMatic/issues) von RaspberryMatic entsprechend einzutragen bzw. zu melden.

Beteiligung in jeder Form ist willkommen und ausdrücklich gewünscht, insbesondere sind alle Nutzer aufgefordert etwaige Probleme so früh wie möglich zu melden damit diese in zukünftigen Versionen entsprechend repariert werden können. Auch wäre es schön wenn noch offene Issues im  [Issue Tracker](https://github.com/jens-maus/RaspberryMatic/issues) von vielen Nutzern reproduziert werden könnte und man sich dort an etwaigen Diskussionen zur Lösungsfindung beteiligen würde. Ausdrücklich erwünscht ist auch an der permanenten Verbesserung und Erweiterung der [Dokumentation](https://github.com/jens-maus/RaspberryMatic/wiki) mitzuarbeiten. Deshalb sind die Schreibrechte für die Dokumentation auch so gesetzt das dort Korrekturen/Änderungen von jedem GitHub Nutzer sofort durchgeführt werden können.

Erwünscht sind natürlich auch direkte Entwicklungsbeteiligungen in Form von PullRequests und Source Code submissions (Bugs, Features). Falls hier jemand also gerne ein Feature umsetzen oder einen Bug selbst ausmerzen will, so wird darum gebeten hierfür die unter Git/GitHub zur Verfügung stehenden Mechanismen zu verwenden. Hierbei gilt jedoch die Lizenzierung von RaspberryMatic und dessen genutzter Drittpakete (z.B. OCCU von eQ3) zu beachten und entsprechend zu akzeptieren. Mehr Informationen dazu kann man unter [CONTRIBUTING.md](CONTRIBUTING.md) nachlesen. Zusätzlich dazu wird darum gebeten für jegliche Beteiligung an diesem Projekt zuerst unseren [CODE OF CONDUCT](CODE_OF_CONDUCT.md) zu studieren und erst dann Beteiligungen in Betracht zu ziehen wenn dieser vollumfänglich akzeptiert werden kann.

## :scroll: Lizenzen
Die RaspberryMatic Buildumgebung selbst – die Dateien die hier in diesem Git Repository zu finden sind – sowie die frei herunterladbaren RaspberryMatic Images sind unter der [Apache License 2.0](https://opensource.org/licenses/Apache-2.0) lizenziert. Hierbei gilt zu beachten, dass die Komponenten die durch die genutzte Buildroot/Linux Umgebung mitgeliefert werden unter jeweils anderen Lizenzen stehen können wobei Buildroot/Linux hier selbst unter der [GPLv2](http://www.gnu.org/licenses/gpl-2.0.html) lizenziert ist. Des Weiteren stehen die mit RaspberryMatic mitgelieferten [eQ-3 OCCU](https://github.com/eq-3/occu)  Komponenten (Binär+Textdateien) die zur Nutzung der HomeMatic/homematicIP Interoperabilität notwendig sind unter der sogenannten [HMSL](https://github.com/eq-3/occu/blob/master/LicenseDE.txt) Lizenz.

## :clap: Danksagungen
Zusätzlich zu den Personen die sich als [Contributors](https://github.com/jens-maus/RaspberryMatic/graphs/contributors) im Rahmen des RaspberryMatic OpenSource Projekte indirekt oder direkt beteiligt haben, soll hier natürlich folgenden Personen ausdrücklich gedankt werden:
* _Alexander Reinert_ – für das [generic_raw_uart kernel module](https://github.com/alexreinert/piVCCU/tree/master/kernel) zur Anbindung der von eQ3 vertriebenen Funkmodule, sowie für die Entwicklung der [HB-RF-USB](https://github.com/alexreinert/PCB/tree/master/HB-RF-USB) und [HB-RF-USB-2](https://github.com/alexreinert/PCB/tree/master/HB-RF-USB-2) Adapterplatinen um diese Funkmodule auch via USB an RaspberryMatic anbinden zu können.

## :family: Authoren
Da eine vielzahl von Personen bereits sich an RaspberryMatic beteiligt haben sei hier auf die [Contributors](https://github.com/jens-maus/RaspberryMatic/graphs/contributors) Liste verwiesen.
