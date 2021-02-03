<img height="60px" src="release/logo.png" align="left">

<br/>

**– The alternative/free operating system for your HomeMatic CCU**

[![Current Release](https://img.shields.io/github/release/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/jens-maus/RaspberryMatic/latest/total.svg)](https://github.com/jens-maus/RaspberryMatic/releases/latest)
[![CI Build](https://github.com/jens-maus/RaspberryMatic/workflows/CI%20Build/badge.svg)](https://github.com/jens-maus/RaspberryMatic/actions)
[![Contributors](https://img.shields.io/github/contributors/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/graphs/contributors)
[![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/issues)
[![Percentage of issues still open](http://isitmaintained.com/badge/open/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/issues)
[![Commits since last release](https://img.shields.io/github/commits-since/jens-maus/RaspberryMatic/latest.svg)](https://github.com/jens-maus/RaspberryMatic/releases/latest)
[![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/raspberrymatic)](https://artifacthub.io/packages/search?repo=raspberrymatic)
[![License](https://img.shields.io/github/license/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/blob/master/LICENSE)
[![Donate](https://img.shields.io/badge/donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=RAQSDY9YNZVCL)
[![Twitter](https://img.shields.io/twitter/follow/RaspberryMatic.svg?style=social&label=Follow)](https://twitter.com/RaspberryMatic)
[![GitHub stars](https://img.shields.io/github/stars/jens-maus/RaspberryMatic.svg?style=social&label=Star)](https://github.com/jens-maus/RaspberryMatic/stargazers/)

<sub>[Hier drücken für 🇩🇪🇦🇹🇨🇭 deutsches ReadMe](README.de.md)</sub>
### [🚀 Quick-Start](#cloud-schnellstart)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[📚 Documentation](https://github.com/jens-maus/RaspberryMatic/wiki)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[📦 Download](https://github.com/jens-maus/RaspberryMatic/releases/latest)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[🚑 Support](#yum-support-mitarbeit)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[👮 Licenses](#scroll-lizenzen)

___
RaspberryMatic is a free and non-commercial OpenSource operating system alternative for the _[CCU3](https://www.homematic-ip.com/en/products/detail/smart-home-central-control-unit-ccu3.html)_ or  _[ELV Charly](https://www.elv.de/elv-smart-home-zentrale-charly-starter-set-bausatz.html)_ smart home central systems to configure and use [HomeMatic](http://homematic.com/)/BidCos-RF or [homematicIP](https://www.homematic-ip.com/) IoT hardware distributed by [eQ-3](https://eq-3.de)/[ELV](https://elv.de/). RaspberryMatic has the aim to be 100% compatible to a standard _HomeMatic CCU control central_ for a cloud-free use of HomeMatic IoT hardware on freely available single-board-computers (SBC) like a [RaspberryPi](https://www.raspberrypi.org/), [ASUS Tinkerboard](https://www.asus.com/Single-Board-Computer/Tinker-Board-S/) or even as a virtual appliance on modern virtual environments (e.g. vmWare ESXi, Proxmox, VirtualBox, Docker/OCI, Kubernetes/K8s, etc.). On top of that, it provides additional exclusive features on different levels (WebUI, Linux-OS, etc.) to provide users with an enhanced user experience compared to the standard vendor-provided CCU firmware from eQ3/ELV.

[more...](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung)

## :cookie: Features
Due to the used base components, RaspberryMatic is 100% compatibile to the standard CCU control center distributed by eQ3/ELV (CCU2/CCU3). This means, that not only it can use the same HomeMatic/homematicIP IoT hardware like a CCU3 central with the same base version. It also provides the same level of functionality in areas like the WebUI or Add-on compatibility. Furthermore, even system backups are compatible between the two CCU variants, which allows to easily switch between the vendor-provided CCU firmware and this free open-source based CCU system software.

On top of that, RaspberryMatic provides a whole bunch of enhancements or even bugfixes in the WebUI or underlying Linux operating system which are either not _yet_ integrated in the official eQ3 CCU firmware or will never be integrated due to the functionality not being commercially interesting enough for eQ3/ELV.

[more...](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung#features)

## :computer: Requirements
RaspberryMatic can be directly installed on the following, commercially distributed CCU hardware:

* [CCU3](https://www.homematic-ip.com/en/products/detail/smart-home-central-control-unit-ccu3.html), [ELV-Charly](https://www.elv.de/elv-smart-home-zentrale-charly-starter-set-bausatz.html)

...or on the following self-made hardware systems:

* _Hardware_:
   * [RaspberryPi](https://www.raspberrypi.org/)
   * [ASUS Tinkerboard](https://www.asus.com/Single-Board-Computer/Tinker-Board-S/)
   * [Intel NUC](https://www.intel.de/content/www/de/de/products/boards-kits/nuc.html)

...or even as a virtual appliance on the following virtualization environments:

* _Virtualization Environment_:
   * [vmWare ESXi](https://www.vmware.com/de/products/esxi-and-esx.html)
   * [Proxmox Virtual Environment](https://www.proxmox.com/de/)
   * [Oracle VirtualBox](https://www.virtualbox.org/)
   * [Synology Virtual Machine Manager](https://www.synology.com/de-de/dsm/feature/virtual_machine_manager)
   * [QNAP VirtualizationStation](https://www.qnap.com/event/station/de-de/virtualization.php)
   * [vmWare Workstation Player](https://www.vmware.com/de/products/workstation-player/workstation-player-evaluation.html)
   * [QEmu/KVM](https://www.qemu.org/)
   * [HyperV](https://docs.microsoft.com/de-de/virtualization/hyper-v-on-windows/)
   * [Docker/OCI](https://www.docker.com/)
   * [Kubernetes/K8s](https://kubernetes.io/)
   
[more...](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung#vorraussetzungen)

## :cloud: Quick-Start
Under [Releases](https://github.com/jens-maus/RaspberryMatic/releases) you will find dedicated images/files for each supported target hardware. Such an image is e.g. available as an `RaspberryMatic-X.XX.XX.YYYYMMDD-XXX.zip` download file. After having unarchived this file you should identify a `*.img` file which can be "flashed" to an adequate target media (sd card, usb-stick, ssd or virtual disk, etc.) using e.g. an imaging tool like [Etcher](https://etcher.io). After having flashed this image on the target media you can then put it into your SBC or CCU3 hardware and boot the system. Depending on the used hardware, RaspberryMatic should then boot-up and try to identify the used HomeMatic/homematicIP RF-Module hardware potentially installed on the GPIO bus of your SBC. If this boot-up is finished, you should be able to access the standard WebUI in your local network by using the address `http://homematic-raspi/` in your web browser. Afterwards you should then find yourself in then normal CCU WebUI where you can start configuring/using your HomeMatic/homematicIP IoT hardware.

[more...](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#schnellstart)

## :memo: Documentation
1. [Introduction](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung)
   * [Requirements](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung#vorraussetzungen)
   * [Features](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung#features)
   * [Limitations](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung#limitationeneinschränkungen)
   * [License and Warranty](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung#lizenz--haftung)
   * [Commercial Distribution](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung#kommerzieller-vertrieb)
2. [Installation](https://github.com/jens-maus/RaspberryMatic/wiki/Installation)
   * [Quick-Start](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#schnellstart)
   * [Basic Installation (Hardware)](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#grundinstallation-hardware)
     * [CCU3](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-CCU3)
     * [ELV-Charly](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-ELV-Charly)
     * [RaspberryPi](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-RaspberryPi)
     * [ASUS Tinkerboard](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-Tinkerboard)
     * [Intel NUC](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-IntelNUC)
   * [Basic Installation (Virtual)](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#grundinstallation-virtuell)
     * [vmWare ESXi](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-vmWare-ESXi)
     * [Proxmox Virtual Environment](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-Proxmox-VE)
     * [Oracle VirtualBox](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-VirtualBox)
     * [Synology Virtual Machine Manager](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-Synology-VMM)
     * [QNAP VirtualizationStation](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-QNAP-VirtualizationStation)
     * [vmWare Workstation Player](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-vmWare-Workstation-Player)
     * [QEmu/KVM](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-QEmu)
     * [HyperV](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-HyperV)
     * [Docker/OCI](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-Docker-OCI)
     * [Kubernetes/K8s](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-Kubernetes)
   * [Configuration Upgrade](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#konfigurationsübernahme)
     * [Upgrade from CCU3](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#umstieg-von-ccu3)
     * [Upgrade from CCU2](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#umstieg-von-ccu2)
     * [Upgrade from CCU1](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#umstieg-von-ccu1)
     * [Upgrade to virtual RaspberryMatic](https://github.com/jens-maus/RaspberryMatic/wiki/Installation#umstieg-zu-virtuellem-raspberrymatic)
   * [Deinstallation](https://github.com/jens-maus/RaspberryMatic/wiki/Deinstallation)
3. [Administration](https://github.com/jens-maus/RaspberryMatic/wiki/Administration)
   * [Firmware Update/Upgrade](https://github.com/jens-maus/RaspberryMatic/wiki/Administration#firmware-updateupgrade)
   * [Backup/Restore](https://github.com/jens-maus/RaspberryMatic/wiki/Administration#backup--restore)
   * [Security Advices](https://github.com/jens-maus/RaspberryMatic/wiki/Administration#sicherheitshinweise)
   * [CCU-Addon Software](https://github.com/jens-maus/RaspberryMatic/wiki/Administration#ccu-addons--zusatzsoftware)
4. Usage
   * [WebUI Usage](https://github.com/jens-maus/RaspberryMatic/wiki/WebUI-Benutzung)
     * [Log-Level setup](https://github.com/jens-maus/RaspberryMatic/wiki/WebUI-Benutzung#log-daten-und-log-level)
   * [Tips&Tricks](https://github.com/jens-maus/RaspberryMatic/wiki/Tipps)
   * [Expert-Features](https://github.com/jens-maus/RaspberryMatic/wiki/Experten-Features)
     * [WLAN/WiFi Setup](https://github.com/jens-maus/RaspberryMatic/wiki/Experten-Features#wlanwifi-nutzung)
     * [Bluetooth Setup](https://github.com/jens-maus/RaspberryMatic/wiki/Experten-Features#bluetooth-nutzung)
     * [LAN-Gateway Mode](https://github.com/jens-maus/RaspberryMatic/wiki/Experten-Features#lan-gateway-betrieb)
     * [USV Client/Server Setup](https://github.com/jens-maus/RaspberryMatic/wiki/Experten-Features#usv-clientserver-nut)
     * [USB-Boot Setup](https://github.com/jens-maus/RaspberryMatic/wiki/Experten-Features#usb-boot)
5. [Support, Contributions](https://github.com/jens-maus/RaspberryMatic/wiki/Support)
   * [Known Issues](https://github.com/jens-maus/RaspberryMatic/wiki/Support#bekannte-probleme)
   * [Request Help](https://github.com/jens-maus/RaspberryMatic/wiki/Support#hilfe-suchen)
   * [FAQ - Frequently Asked Questions](https://github.com/jens-maus/RaspberryMatic/wiki/Support#faq)
   * [Report Issues](https://github.com/jens-maus/RaspberryMatic/wiki/Support#bugreports)
   * [Request Features](https://github.com/jens-maus/RaspberryMatic/wiki/Support#featurerequests)
   * [Contributions / Development](https://github.com/jens-maus/RaspberryMatic/wiki/Support#mitarbeit--weiterentwicklung)

## :yum: Support, Contributions
To provide general feedback or start discussions, please use either the [Discussion fora](https://github.com/jens-maus/RaspberryMatic/discussions) in this GitHub project or (if you are german speaking) please contribute to the RaspberryMatic fora of the [HomeMatic-Forum](https://homematic-forum.de/forum/viewforum.php?f=65). If during discussions in these fora a definite and unique feature request or bug has been acknowledged by other RaspberryMatic users, please feel free to open a dedicated feature or bug fixing request in the [issue tracker](https://github.com/jens-maus/RaspberryMatic/issues).

Any contribution in any way is highly welcome. Please feel free to contribute not only by using the official releases. If you have some time and free resources, we welcome any contributing to help to reproduce and perhaps even fixing any [open issues](https://github.com/jens-maus/RaspberryMatic/issues) in our issue tracker. Also participating in enhancing or fixing the official wiki-based [documentation](https://github.com/jens-maus/RaspberryMatic/wiki) is appreciated. That's why any logged-in GitHub user can directly add and modify any documentation pages in this wiki.

On top of that, direct contributions by sending in PullRequests and source code contributions (Bugs, Features, etc.) are welcome. So if someone would like to see a certain feature implemented or bug fixed and has enough free resources and knowhow, please feel free to directly send in PullRequests using Git/GitHub. Please note, however, that any contribution to this open source project have to be in accordance to the Apache-2.0 open source license under which RaspberryMatic itself is developed and distributed. So by sending in PullRequests you will have to acknowledge that you are fine with the license implications of your contributions. Therefore, please refer to [CONTRIBUTING](CONTRIBUTING.md) as well as reading our [CODE OF CONDUCT](CODE_OF_CONDUCT.md) before you consider contributing to this project in any form.

[more...](https://github.com/jens-maus/RaspberryMatic/wiki/Support)

## :scroll: Licenses
The RaspberryMatic  build enviroment itself – the files in this git repository – as well as the downloadable images in the Releases section are distributed under the open source [Apache License 2.0](https://opensource.org/licenses/Apache-2.0) license. RaspberryMatic itself is distributed completly free of charge and without any commercial intension whatsoever. Please note, that on top of the Apache-2.0 license RaspberryMatic itself is distributed, some components (e.g. the underlying Buildroot/Linux System) can be distributed under different licenses. E.g. Buildroot/Linux itself is distributed under the [GPLv2](http://www.gnu.org/licenses/gpl-2.0.html) which could have other implications when changing source parts of these components. Furthermore, the [eQ-3 OCCU](https://github.com/eq-3/occu) components RaspberryMatic uses to provide the HomeMatic/homematicIP interconnectivity are distributed under the [HMSL](https://github.com/eq-3/occu/blob/master/LicenseEN.txt) license terms.

### Disclaimer of Warranty
All project contributors provide RaspberryMatic (and each Contributor provides its Contributions) on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE. You are solely responsible for determining the appropriateness of using or redistributing RaspberryMatic and assume any risks associated with Your exercise of permissions under this License.

[more...](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung#lizenz--haftung)

## :book: Literature
If after reading through this documentatin anyone is still unsure regarding the pros and cons of using RaspberryMatic rather than the standard vendor-provided CCU firmware or if someone would like to read / see more on which additional features RaspberryMatic provides, please see the following list of (mostly german speaking) literature:

<a href="https://www.youtube.com/watch?v=regDw7rcIb0"><img alt="Usertreffen Kassel 2019 – RaspberryMatic" src="https://img.youtube.com/vi/regDw7rcIb0/hqdefault.jpg" width=320></a>
<a href="https://www.youtube.com/watch?v=hSmDcrkHb7M"><img alt="Usertreffen Kassel 2018 – RaspberryMatic" src="https://img.youtube.com/vi/hSmDcrkHb7M/hqdefault.jpg" width=320></a>
<a href="https://www.youtube.com/watch?v=LQrzittdEGg"><img alt="Usertreffen Kassel 2017 – RaspberryMatic (Teil 1)" src="https://img.youtube.com/vi/LQrzittdEGg/hqdefault.jpg" width=320></a>
<a href="https://www.youtube.com/watch?v=duSTLdVKSeM"><img alt="Usertreffen Kassel 2017 - RaspberryMatic (Teil 2)" src="https://img.youtube.com/vi/duSTLdVKSeM/hqdefault.jpg" width=320></a>

* [Vortragsfolien HomeMatic-Usertreffen 2019](https://homematic-forum.de/forum/download/file.php?id=59500)
* [Vortragsfolien HomeMatic-Usertreffen 2018](https://homematic-forum.de/forum/download/file.php?id=48428)
* [Vortragsfolien HomeMatic-Usertreffen 2017](https://homematic-forum.de/forum/download/file.php?id=40869)
* [Vortragsfolien HomeMatic-Usertreffen 2016](https://homematic-forum.de/forum/download/file.php?id=40868)

## :clap: Acknowledgements
In addition to the whole list of [Contributors](https://github.com/jens-maus/RaspberryMatic/graphs/contributors) which have contributed to the success of RaspberryMatic, we would like to explicitly thank the following list of people for their third-party contributions:
* _Alexander Reinert (@alexreinert)_ – for his low-latency [generic_raw_uart kernel module](https://github.com/alexreinert/piVCCU/tree/master/kernel) which allows to use the eQ3 distributed RF modules (RPI-RF-MOD, HM-MOD-RPI-PCB) as well as for his [HB-RF-USB](https://github.com/alexreinert/PCB/tree/master/HB-RF-USB), [HB-RF-USB-2](https://github.com/alexreinert/PCB/tree/master/HB-RF-USB-2) and [HB-RF-ETH](https://github.com/alexreinert/PCB/tree/master/HB-RF-ETH) open hardware projects providing USB and Ethernet based adapter PCBs to use the eQ3 RF modules with other base interfaces.

## :family: Authors
Due to the large number of existing people having contributed to the success of RaspberryMatic, please refer to the [Contributors](https://github.com/jens-maus/RaspberryMatic/graphs/contributors) accordingly.

## :construction: ChangeLog
A detailed list of Changes between individual released versions can be reviewed through the [Releases](https://github.com/jens-maus/RaspberryMatic/releases/) section of this GitHub project.
