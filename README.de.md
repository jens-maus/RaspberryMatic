<img height="60px" src="release/logo.png" align="left">

<br/>

**– Das alternative/freie Betriebssystem für Ihre HomeMatic CCU**

[![Current Release](https://img.shields.io/github/release/OpenCCU/OpenCCU.svg)](https://github.com/OpenCCU/OpenCCU/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/OpenCCU/OpenCCU/latest/total.svg)](https://github.com/OpenCCU/OpenCCU/releases/latest)
[![CI Build](https://github.com/OpenCCU/OpenCCU/workflows/CI%20Build/badge.svg)](https://github.com/OpenCCU/OpenCCU/actions)
[![Snapshot Build](https://github.com/OpenCCU/OpenCCU/workflows/Snapshot%20Build/badge.svg)](https://github.com/OpenCCU/OpenCCU/releases/tag/snapshots)
[![Contributors](https://img.shields.io/github/contributors/OpenCCU/OpenCCU.svg)](https://github.com/OpenCCU/OpenCCU/graphs/contributors)
[![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/OpenCCU/OpenCCU.svg)](https://github.com/OpenCCU/OpenCCU/issues)
[![Percentage of issues still open](http://isitmaintained.com/badge/open/OpenCCU/OpenCCU.svg)](https://github.com/OpenCCU/OpenCCU/issues)
[![Commits since last release](https://img.shields.io/github/commits-since/OpenCCU/OpenCCU/latest.svg)](https://github.com/OpenCCU/OpenCCU/releases/latest)
[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/openccu)](https://artifacthub.io/packages/search?repo=openccu)
[![License](https://img.shields.io/github/license/OpenCCU/OpenCCU.svg)](https://github.com/OpenCCU/OpenCCU/blob/master/LICENSE)
[![Donate](https://img.shields.io/badge/donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=RAQSDY9YNZVCL)
[![GitHub sponsors](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&link=https://github.com/sponsors/jens-maus)](https://github.com/sponsors/jens-maus)
[![GitHub stars](https://img.shields.io/github/stars/OpenCCU/OpenCCU.svg?style=social&label=Star)](https://github.com/OpenCCU/OpenCCU/stargazers/)

<sub>[Click here for 🇬🇧🇺🇸 english readme](README.md)</sub>
___
Bei _OpenCCU_ handelt es sich um ein alternatives, freies und nicht-kommerziell vertriebenes OpenSource Betriebssystem für die kommerziell erhältlichen _[CCU3](https://www.homematic-ip.com/en/products/detail/smart-home-central-control-unit-ccu3.html)_ bzw. _[ELV Charly](https://www.elv.de/elv-smart-home-zentrale-charly-starter-set-bausatz.html)_ SmartHome-Zentralen zur Nutzung von [HomeMatic](http://homematic.com/)/BidCos-RF bzw. [homematicIP](https://www.homematic-ip.com/) Hardware der Firmengruppe [eQ-3](https://eq-3.de)/[ELV](https://elv.de/). OpenCCU hat sich zum Ziel gesetzt nicht nur den kompletten Funktionsumfang einer sog. _HomeMatic CCU SmartHome-Zentrale_ für eine Cloudfreie Nutzung von HomeMatic Geräten für frei erhältliche Single-Board-Computern (SBC) wie z.B. den [RaspberryPi](https://www.raspberrypi.org/), [ASUS Tinkerboard](https://www.asus.com/Single-Board-Computer/Tinker-Board-S/) oder aber auch als virtualisierte Variante für moderne Virtualisierungsumgebungen (z.B. vmWare ESXi, Proxmox, VirtualBox, Docker/OCI, Kubernetes/K8s, etc.) nutzbar zu machen. Es hat sich auch zum Ziel gesetzt auf verschiedenen Ebenen (WebUI, Linux-Betriebssystem, etc.) Verbesserungen bzw. Bugfixes mitzubringen die in der originalen CCU Firmware von eQ3/ELV (noch) nicht vorhanden sind.

[mehr...](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung)

## :cookie: Features

OpenCCU ist systembedingt zur Betriebssystemsoftware einer CCU‑Zentrale der Firma eQ3/ELV (CCU2/CCU3) (mit gleichem Versionsstand) 100% kompatibel. Dies bedeutet, dass nicht nur dieselben HomeMatic/homematicIP‑Geräte angelernt/genutzt werden können, auch verhält sich OpenCCU in puncto Funktionalität und WebUI vollkommen kompatibel. Des Weiteren kann die komplette Konfiguration zwischen der Standard‑Betriebssystemsoftware von eQ3/ELV und OpenCCU ausgetauscht werden und ein Wechsel zwischen den beiden Betriebssystemen ist jederzeit möglich.

Darüber hinaus bringt OpenCCU jedoch eine ganze Reihe von Verbesserungen/Erweiterungen, neuen Features und teilweise bereits integrierten Bugfixes mit sich die entweder _noch_ nicht in der originalen CCU Firmware von der Firma eQ3/ELV übernommen wurde oder aus kommerzieller Sicht nicht übernommen werden soll.

[mehr...](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung#features)

## :computer: Voraussetzungen

OpenCCU lässt sich auf folgender, kommerziell erhältlicher Kompletthardware (Rechner + HomeMatic-Kommunikationsmodul) installieren:

* [CCU3](https://www.homematic-ip.com/en/products/detail/smart-home-central-control-unit-ccu3.html), [ELV-Charly](https://www.elv.de/elv-smart-home-zentrale-charly-starter-set-bausatz.html)

...oder auf folgender selbst zusammengestellter Hardware:

* _Hardware_:
  * [RaspberryPi](https://www.raspberrypi.org/)
  * [ASUS Tinkerboard](https://www.asus.com/Single-Board-Computer/Tinker-Board-S/)
  * [ODROID](https://www.hardkernel.com/shop/odroid-n2-with-4gbyte-ram-2/)
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
  * [UNRAID](https://unraid.net/)
  * [HyperV](https://docs.microsoft.com/de-de/virtualization/hyper-v-on-windows/)
  * [Docker/OCI](https://www.docker.com/)
  * [Kubernetes/K8s](https://kubernetes.io/)
  * [Home Assistant](https://homeassistant.io/)

[mehr...](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung#vorraussetzungen)

## :cloud: Schnellstart

Unter [Releases](https://github.com/OpenCCU/OpenCCU/releases) steht für die jeweilige Target-Hardware Dateien im Format `OpenCCU-X.XX.XX.YYYYMMDD-XXX.zip` als Download zur Verfügung. Nach Entpacken dieser Datei erhält man eine `*.img` Imagedatei die man auf ein geeignetes Medium (SD-Karte, USB-Stick, SSD oder als virtuelle Disk) mit z.B. dem Imaging-Tool [Etcher](https://etcher.io) "flashen" lassen kann. Danach legt man z.B. die SD Karte in den jeweiligen RaspberryPi ein und startet diesen. Danach sollte dann OpenCCU starten und versuchen im Laufe des Startes das passende HomeMatic/homematicIP Funkmodul zu initialisieren (das man vorher installiert hat). Ist dies erfolgt kann man mittels Webbrowser in seinem lokalen Netzwerk unter Nutzung der Adresse `http://openccu/` auf die Weboberfläche (WebUI) von OpenCCU normal zugreifen und HomeMatic/homematicIP Geräte anlernen, konfigurieren oder bedienen.

[mehr...](https://github.com/OpenCCU/OpenCCU/wiki/Installation#schnellstart)

## :memo: Dokumentation

1. [Einleitung](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung)
   * [Voraussetzungen](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung#vorraussetzungen)
   * [Features](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung#features)
   * [Limitationen/Einschränkungen](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung#limitationeneinschränkungen)
   * [Lizenzbedingungen & Haftung](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung#lizenz--haftung)
   * [Kommerzieller Vertrieb](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung#kommerzieller-vertrieb)
2. [Installation](https://github.com/OpenCCU/OpenCCU/wiki/Installation)
   * [Schnellstart](https://github.com/OpenCCU/OpenCCU/wiki/Installation#schnellstart)
   * [Grundinstallation (Hardware)](https://github.com/OpenCCU/OpenCCU/wiki/Installation#grundinstallation-hardware)
     * [CCU3](https://github.com/OpenCCU/OpenCCU/wiki/Installation-CCU3)
     * [ELV-Charly](https://github.com/OpenCCU/OpenCCU/wiki/Installation-ELV-Charly)
     * [RaspberryPi](https://github.com/OpenCCU/OpenCCU/wiki/Installation-RaspberryPi)
     * [ASUS Tinkerboard](https://github.com/OpenCCU/OpenCCU/wiki/Installation-Tinkerboard)
     * [ODROID](https://github.com/OpenCCU/OpenCCU/wiki/Installation-ODROID)
     * [Intel NUC](https://github.com/OpenCCU/OpenCCU/wiki/Installation-IntelNUC)
   * [Grundinstallation (Virtuell)](https://github.com/OpenCCU/OpenCCU/wiki/Installation#grundinstallation-virtuell)
     * [vmWare ESXi](https://github.com/OpenCCU/OpenCCU/wiki/Installation-vmWare-ESXi)
     * [Proxmox Virtual Environment](https://github.com/OpenCCU/OpenCCU/wiki/Installation-Proxmox-VE)
     * [Oracle VirtualBox](https://github.com/OpenCCU/OpenCCU/wiki/Installation-VirtualBox)
     * [Synology Virtual Machine Manager](https://github.com/OpenCCU/OpenCCU/wiki/Installation-Synology-VMM)
     * [QNAP VirtualizationStation](https://github.com/OpenCCU/OpenCCU/wiki/Installation-QNAP-VirtualizationStation)
     * [vmWare Workstation Player](https://github.com/OpenCCU/OpenCCU/wiki/Installation-vmWare-Workstation-Player)
     * [QEmu/KVM](https://github.com/OpenCCU/OpenCCU/wiki/Installation-QEmu)
     * [UNRAID](https://github.com/OpenCCU/OpenCCU/wiki/Installation-UNRAID)
     * [HyperV](https://github.com/OpenCCU/OpenCCU/wiki/Installation-HyperV)
     * [Docker/OCI](https://github.com/OpenCCU/OpenCCU/wiki/Installation-Docker-OCI)
     * [Kubernetes/K8s](https://github.com/OpenCCU/OpenCCU/wiki/Installation-Kubernetes)
     * [Home Assistant Add-on](https://github.com/OpenCCU/OpenCCU/wiki/Installation-HomeAssistant)
   * [Konfigurationsübernahme](https://github.com/OpenCCU/OpenCCU/wiki/Installation#konfigurationsübernahme)
     * [Umstieg von CCU3](https://github.com/OpenCCU/OpenCCU/wiki/Installation#umstieg-von-ccu3)
     * [Umstieg von CCU2](https://github.com/OpenCCU/OpenCCU/wiki/Installation#umstieg-von-ccu2)
     * [Umstieg von CCU1](https://github.com/OpenCCU/OpenCCU/wiki/Installation#umstieg-von-ccu1)
     * [Umstieg zu virtuellem OpenCCU](https://github.com/OpenCCU/OpenCCU/wiki/Installation#umstieg-zu-virtuellem-raspberrymatic)
   * [Deinstallation](https://github.com/OpenCCU/OpenCCU/wiki/Deinstallation)
3. [Administration](https://github.com/OpenCCU/OpenCCU/wiki/Administration)
   * [Firmware Update/Upgrade](https://github.com/OpenCCU/OpenCCU/wiki/Administration#firmware-updateupgrade)
   * [Backup/Restore](https://github.com/OpenCCU/OpenCCU/wiki/Administration#backup--restore)
   * [Sicherheitshinweise](https://github.com/OpenCCU/OpenCCU/wiki/Administration#sicherheitshinweise)
   * [CCU-Addons / Zusatzsoftware](https://github.com/OpenCCU/OpenCCU/wiki/Administration#ccu-addons--zusatzsoftware)
4. Nutzung
   * [WebUI Benutzung](https://github.com/OpenCCU/OpenCCU/wiki/WebUI-Benutzung)
     * [Log-Level erhöhen für Fehleranalyse](https://github.com/OpenCCU/OpenCCU/wiki/WebUI-Benutzung#log-daten-und-log-level)
   * [Tipps&Tricks](https://github.com/OpenCCU/OpenCCU/wiki/Tipps)
   * [Experten-Features](https://github.com/OpenCCU/OpenCCU/wiki/Experten-Features)
     * [WLAN/WiFi Unterstützung](https://github.com/OpenCCU/OpenCCU/wiki/Experten-Features#wlanwifi-nutzung)
     * [Bluetooth Unterstützung](https://github.com/OpenCCU/OpenCCU/wiki/Experten-Features#bluetooth-nutzung)
     * [LAN-Gateway Betrieb](https://github.com/OpenCCU/OpenCCU/wiki/Experten-Features#lan-gateway-betrieb)
     * [USV Client/Server Betrieb](https://github.com/OpenCCU/OpenCCU/wiki/Experten-Features#usv-clientserver-nut)
     * [USB-Boot](https://github.com/OpenCCU/OpenCCU/wiki/Experten-Features#usb-boot)
5. [Support, Mitarbeit](https://github.com/OpenCCU/OpenCCU/wiki/Support)
   * [Bekannte Probleme](https://github.com/OpenCCU/OpenCCU/wiki/Support#bekannte-probleme)
   * [Hilfe suchen](https://github.com/OpenCCU/OpenCCU/wiki/Support#hilfe-suchen)
   * [FAQ - Häufig gestellte Fragen](https://github.com/OpenCCU/OpenCCU/wiki/Support#faq)
   * [Fehler melden](https://github.com/OpenCCU/OpenCCU/wiki/Support#bugreports)
   * [Features wünschen](https://github.com/OpenCCU/OpenCCU/wiki/Support#featurerequests)
   * [Mitarbeit / Weiterentwicklung](https://github.com/OpenCCU/OpenCCU/wiki/Support#mitarbeit--weiterentwicklung)

## :yum: Support, Mitarbeit

Für Feedback jeglicher Art, Fragen, Vorschläge, Wünsche und Fehlerberichte wird darum gebeten bitte zuerst im jeweiligen OpenCCU Teil des HomeMatic-Forum (<https://homematic-forum.de/forum/viewforum.php?f=65>) einen entsprechenden Beitrag zu erstellen oder an bereits existierenden Beiträgen dort sich zu beteiligen. Sollte aus den Diskussionen dort sich dann ein spezieller Feature-Wunsch oder von anderen Personen bestätigter Bug in OpenCCU herauskristallieren wird darum gebeten diesen Bug bzw. diesen Feature-Request im [Issue Tracker](https://github.com/OpenCCU/OpenCCU/issues) von OpenCCU entsprechend einzutragen bzw. zu melden.

Beteiligung in jeder Form ist willkommen und ausdrücklich gewünscht, insbesondere sind alle Nutzer aufgefordert etwaige Probleme so früh wie möglich zu melden damit diese in zukünftigen Versionen entsprechend repariert werden können. Auch wäre es schön wenn noch offene Issues im  [Issue Tracker](https://github.com/OpenCCU/OpenCCU/issues) von vielen Nutzern reproduziert werden könnte und man sich dort an etwaigen Diskussionen zur Lösungsfindung beteiligen würde. Ausdrücklich erwünscht ist auch an der permanenten Verbesserung und Erweiterung der [Dokumentation](https://github.com/OpenCCU/OpenCCU/wiki) mitzuarbeiten. Deshalb sind die Schreibrechte für die Dokumentation auch so gesetzt das dort Korrekturen/Änderungen von jedem GitHub Nutzer sofort durchgeführt werden können.

Erwünscht sind natürlich auch direkte Entwicklungsbeteiligungen in Form von PullRequests und Source Code submissions (Bugs, Features). Falls hier jemand also gerne ein Feature umsetzen oder einen Bug selbst ausmerzen will, so wird darum gebeten hierfür die unter Git/GitHub zur Verfügung stehenden Mechanismen zu verwenden. Hierbei gilt jedoch die Lizenzierung von OpenCCU und dessen genutzter Drittpakete (z.B. OCCU von eQ3) zu beachten und entsprechend zu akzeptieren. Mehr Informationen dazu kann man unter [CONTRIBUTING.md](CONTRIBUTING.md) nachlesen. Zusätzlich dazu wird darum gebeten für jegliche Beteiligung an diesem Projekt zuerst unseren [CODE OF CONDUCT](CODE_OF_CONDUCT.md) zu studieren und erst dann Beteiligungen in Betracht zu ziehen wenn dieser vollumfänglich akzeptiert werden kann.

[mehr...](https://github.com/OpenCCU/OpenCCU/wiki/Support)

## :scroll: Lizenzen

Die OpenCCU Buildumgebung selbst – die Dateien die hier in diesem Git Repository zu finden sind – sowie die frei herunterladbaren OpenCCU Images sind unter der OpenSource [Apache License 2.0](https://opensource.org/licenses/Apache-2.0) lizenziert. OpenCCU wird selbst komplett kostenfrei und ohne jeglichen kommerziellen Intentionen entwickelt und zur komplett kostenfreien Nutzung bereitgestellt. Hierbei gilt zu beachten, dass die Komponenten der genutzten Buildroot/Linux Umgebung jeweils anderen Lizenzen stehen können wobei Buildroot/Linux hier selbst unter der [GPLv2](http://www.gnu.org/licenses/gpl-2.0.html) lizenziert ist. Des Weiteren stehen die mit OpenCCU mitgelieferten [eQ-3 OCCU](https://github.com/eq-3/occu) Komponenten (Binär+Textdateien), die zur Nutzung der HomeMatic/homematicIP Interoperabilität notwendig sind, unter der sogenannten [HMSL](https://github.com/eq-3/occu/blob/master/LicenseDE.txt) Lizenz.

### Haftungsausschluss

OPENCCU WIRD OHNE JEDE AUSDRÜCKLICHE ODER IMPLIZIERTE GARANTIE BEREITGESTELLT, EINSCHLIEẞLICH DER GARANTIE ZUR BENUTZUNG FÜR DEN VORGESEHENEN ODER EINEM BESTIMMTEN ZWECK SOWIE JEGLICHER RECHTSVERLETZUNG, JEDOCH NICHT DARAUF BESCHRÄNKT. IN KEINEM FALL SIND DIE AUTOREN ODER COPYRIGHTINHABER FÜR JEGLICHEN SCHADEN ODER SONSTIGE ANSPRÜCHE HAFTBAR ZU MACHEN, OB INFOLGE DER ERFÜLLUNG EINES VERTRAGES, EINES DELIKTES ODER ANDERS IM ZUSAMMENHANG MIT DER SOFTWARE ODER SONSTIGER VERWENDUNG DER SOFTWARE ENTSTANDEN.

[mehr...](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung#lizenz--haftung)

## :book: Literatur

Wenn der Eine oder Andere bzgl. Einsatz von OpenCCU noch unentschlossen ist oder die Vor-/Nachteile abwägen will so soll die folgende Literaturliste eine Hilfestellung geben:

<a href="https://www.youtube.com/watch?v=regDw7rcIb0"><img alt="Usertreffen Kassel 2019 – OpenCCU" src="https://img.youtube.com/vi/regDw7rcIb0/hqdefault.jpg" width=320></a>
<a href="https://www.youtube.com/watch?v=hSmDcrkHb7M"><img alt="Usertreffen Kassel 2018 – OpenCCU" src="https://img.youtube.com/vi/hSmDcrkHb7M/hqdefault.jpg" width=320></a>
<a href="https://www.youtube.com/watch?v=LQrzittdEGg"><img alt="Usertreffen Kassel 2017 – OpenCCU (Teil 1)" src="https://img.youtube.com/vi/LQrzittdEGg/hqdefault.jpg" width=320></a>
<a href="https://www.youtube.com/watch?v=duSTLdVKSeM"><img alt="Usertreffen Kassel 2017 - OpenCCU (Teil 2)" src="https://img.youtube.com/vi/duSTLdVKSeM/hqdefault.jpg" width=320></a>

* [Vortragsfolien HomeMatic-Usertreffen 2019](https://homematic-forum.de/forum/download/file.php?id=59500)
* [Vortragsfolien HomeMatic-Usertreffen 2018](https://homematic-forum.de/forum/download/file.php?id=48428)
* [Vortragsfolien HomeMatic-Usertreffen 2017](https://homematic-forum.de/forum/download/file.php?id=40869)
* [Vortragsfolien HomeMatic-Usertreffen 2016](https://homematic-forum.de/forum/download/file.php?id=40868)

## :clap: Danksagungen

Zusätzlich zu den Personen die sich als [Contributors](https://github.com/OpenCCU/OpenCCU/graphs/contributors) im Rahmen des OpenCCU OpenSource Projekte indirekt oder direkt beteiligt haben, soll hier natürlich folgenden Personen ausdrücklich gedankt werden:

* _Alexander Reinert (@alexreinert)_ – für sein Low-Latency [generic_raw_uart](https://github.com/alexreinert/piVCCU/tree/master/kernel) Kernelmodul, welches es erlaubt die von eQ3 angebotenen Funkmodule (RPI-RF-MOD, HM-MOD-RPI-PCB) zu nutzen sowie für seine [HB-RF-USB](https://github.com/alexreinert/PCB/tree/master/HB-RF-USB), [HB-RF-USB-2](https://github.com/alexreinert/PCB/tree/master/HB-RF-USB-2) und [HB-RF-ETH](https://github.com/alexreinert/PCB/tree/master/HB-RF-ETH) OpenHardware Projekte für eine USB- bzw. Ethernet-basierte Nutzung dieser Funkmodule.

## :family: Autoren

Da eine Vielzahl von Personen bereits sich an OpenCCU beteiligt haben sei hier auf die [Contributors](https://github.com/OpenCCU/OpenCCU/graphs/contributors) Liste verwiesen.

## :construction: Änderungshistorie / ChangeLog

Eine detaillierte Liste aller bisherigen Änderungen zwischen den individuellen OpenCCU-Versionen erhält man über die [Release-Seite](https://github.com/OpenCCU/OpenCCU/releases/) bei GitHub.
