<img height="60px" src="release/logo.png" align="left">

<br/>

**– The alternative/free operating system for your homematicIP CCU**

[![Current Release](https://img.shields.io/github/release/OpenCCU/OpenCCU.svg)](https://github.com/OpenCCU/OpenCCU/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/OpenCCU/OpenCCU/latest/total.svg)](https://github.com/OpenCCU/OpenCCU/releases/latest)
[![DownloadsSnapshots](https://img.shields.io/github/downloads/OpenCCU/OpenCCU/snapshots/total.svg)](https://github.com/OpenCCU/OpenCCU/releases/snapshots)
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

<sub>[Deutschsprachiges 🇩🇪🇦🇹🇨🇭 ReadMe](README.de.md)</sub>
___
OpenCCU is a free and non-commercial open-source operating system alternative for running a cloud-free smart-home IoT central to provide connectivity to the [homematicIP](https://www.homematic-ip.com/) / [HomeMatic](http://homematic.com/) hardware line of IoT devices developed by [eQ-3](https://eq-3.de) and distributed by [ELV](https://elv.de/). OpenCCU has the aim to be 100% compatible to the vendor-developed _HomeMatic CCU3 control central_ (CCU3) system. It can be directly installed on a _[CCU3](https://homematic-ip.com/en/product/smart-home-ccu3-central-control-unit)_ or _[ELV Charly](https://www.elv.de/elv-smart-home-zentrale-charly-starter-set-bausatz.html)_ hardware device. Alternatively, it can also be installed on a wide range of freely available single-board-computers (SBC) like a [RaspberryPi](https://www.raspberrypi.org/), [ASUS Tinkerboard](https://www.asus.com/Single-Board-Computer/Tinker-Board-S/), [Hardkernel ODROID](https://www.hardkernel.com/product-category/odroid-board/) or even on full-fledged hardware platforms like an [Intel NUC](https://www.intel.com/content/www/us/en/products/details/nuc.html) system. Furthermore, it can be run as a virtual appliance in modern virtualization environments (e.g. Proxmox VE, VirtualBox, Synology VMM, Docker/OCI, Kubernetes/K8s, vmWare ESXi, etc.) or even as a pure [Home Assistant](https://www.home-assistant.io/) Add-On. On top of that wider range of supported operating environments, it also comes with exclusive features on different levels (WebUI, Linux OS, connectivity, etc.) to support end users with a more modern and advanced user experience compared to the vendor-provided CCU3 operating system.

[more...](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung)

## :cookie: Features

Due to the base components used, OpenCCU is 100% compatible with the standard CCU control center distributed by eQ3/ELV (CCU2/CCU3). This means not only can it use the same HomeMatic/homematicIP IoT hardware as a CCU3 running the same base version, it also provides the same level of functionality in areas such as the WebUI and add-on compatibility. Furthermore, even system backups are compatible between the two CCU variants, which allows to easily switch between the vendor-provided CCU firmware and this free open-source based CCU system software.

On top of that, OpenCCU provides a whole bunch of enhancements or even bugfixes in the WebUI or underlying Linux operating system which are either not _yet_ integrated in the official eQ3 CCU firmware or will never be integrated due to the functionality not being commercially interesting enough for eQ3/ELV.

[more...](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung#features)

## :computer: Requirements

OpenCCU can be directly installed on the following, commercially distributed CCU hardware:

* _Hardware_:
  * [CCU3](https://homematic-ip.com/en/product/smart-home-ccu3-central-control-unit), [ELV-Charly](https://www.elv.de/elv-smart-home-zentrale-charly-starter-set-bausatz.html)
  * [RaspberryPi](https://www.raspberrypi.org/)
  * [ASUS Tinkerboard](https://www.asus.com/Single-Board-Computer/Tinker-Board-S/)
  * [Hardkernel ODROID](https://www.hardkernel.com/shop/odroid-n2-with-4gbyte-ram-2/)
  * [Intel NUC](https://www.intel.de/content/www/de/de/products/boards-kits/nuc.html)

...or as a virtual appliance on the following virtualization environments:

* _Virtualization Environment_:
  * [Proxmox Virtual Environment](https://www.proxmox.com/en/proxmox-ve)
  * [Home Assistant](https://home-assistant.io/)
  * [Docker Container (OCI)](https://www.docker.com/)
  * [Linux Container (LXC)](https://linuxcontainers.org/)
  * [QEmu/KVM](https://www.qemu.org/)
  * [Kubernetes/K8s](https://kubernetes.io/)
  * [Synology Virtual Machine Manager](https://www.synology.com/de-de/dsm/feature/virtual_machine_manager)
  * [QNAP VirtualizationStation](https://www.qnap.com/event/station/de-de/virtualization.php)
  * [UNRAID](https://unraid.net/)
  * [XCP-ng/XenServer](https://xcp-ng.org/)
  * [Oracle VirtualBox](https://www.virtualbox.org/)
  * [vmWare ESXi](https://www.vmware.com/de/products/esxi-and-esx.html)
  * [vmWare Workstation Player](https://www.vmware.com/de/products/workstation-player/workstation-player-evaluation.html)
  * [HyperV](https://docs.microsoft.com/de-de/virtualization/hyper-v-on-windows/)

[more...](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung#vorraussetzungen)

## :cloud: Quick-Start

Under [Releases](https://github.com/OpenCCU/OpenCCU/releases) you will find dedicated images/files for each supported target hardware. Such an image is e.g. available as an `OpenCCU-X.XX.XX.YYYYMMDD-XXX.zip` download file. After having unarchived this file you should identify a `*.img` file which can be "flashed" to an adequate target media (sd card, usb-stick, ssd or virtual disk, etc.) using e.g. an imaging tool like [Etcher](https://etcher.io). After having flashed this image on the target media you can then put it into your SBC or CCU3 hardware and boot the system. Depending on the used hardware, OpenCCU should then boot-up and try to identify the used HomeMatic/homematicIP RF-Module hardware potentially installed on the GPIO bus of your SBC. If boot-up has finished, you should be able to access the standard WebUI in your local network via `http://openccu/` in your web browser. Afterwards, you should find yourself in the normal CCU WebUI where you can start configuring/using your HomeMatic/homematicIP IoT hardware.

[more...](https://github.com/OpenCCU/OpenCCU/wiki/Installation#schnellstart)

## :memo: Documentation ([🇩🇪](https://github.com/OpenCCU/OpenCCU/wiki/Home)/[🇺🇸](https://github.com/OpenCCU/OpenCCU/wiki/en.Home))

1. [Introduction](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung)
   * [Requirements](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung#vorraussetzungen)
   * [Features](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung#features)
   * [Limitations](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung#limitationeneinschränkungen)
   * [License and Warranty](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung#lizenz--haftung)
   * [Commercial Distribution](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung#kommerzieller-vertrieb)
2. [Installation](https://github.com/OpenCCU/OpenCCU/wiki/Installation)
   * [Quick-Start](https://github.com/OpenCCU/OpenCCU/wiki/Installation#schnellstart)
   * [Basic Installation (Hardware)](https://github.com/OpenCCU/OpenCCU/wiki/Installation#grundinstallation-hardware)
     * [CCU3](https://github.com/OpenCCU/OpenCCU/wiki/Installation-CCU3)
     * [ELV-Charly](https://github.com/OpenCCU/OpenCCU/wiki/Installation-ELV-Charly)
     * [RaspberryPi](https://github.com/OpenCCU/OpenCCU/wiki/Installation-RaspberryPi)
     * [ASUS Tinkerboard](https://github.com/OpenCCU/OpenCCU/wiki/Installation-Tinkerboard)
     * [Hardkernel ODROID](https://github.com/OpenCCU/OpenCCU/wiki/Installation-ODROID)
     * [Intel NUC](https://github.com/OpenCCU/OpenCCU/wiki/Installation-IntelNUC)
   * [Basic Installation (Virtual)](https://github.com/OpenCCU/OpenCCU/wiki/Installation#grundinstallation-virtuell)
     * [Proxmox Virtual Environment](https://github.com/OpenCCU/OpenCCU/wiki/Installation-Proxmox-VE)
     * [Home Assistant Add-on](https://github.com/OpenCCU/OpenCCU/wiki/Installation-HomeAssistant)
     * [Docker Container (OCI)](https://github.com/OpenCCU/OpenCCU/wiki/Installation-Docker-OCI)
     * [Linux Container (LXC)](https://github.com/OpenCCU/OpenCCU/wiki/Installation-LXC)
     * [QEmu/KVM](https://github.com/OpenCCU/OpenCCU/wiki/Installation-QEmu)
     * [Kubernetes/K8s](https://github.com/OpenCCU/OpenCCU/wiki/Installation-Kubernetes)
     * [Synology Virtual Machine Manager](https://github.com/OpenCCU/OpenCCU/wiki/Installation-Synology-VMM)
     * [QNAP VirtualizationStation](https://github.com/OpenCCU/OpenCCU/wiki/Installation-QNAP-VirtualizationStation)
     * [UNRAID](https://github.com/OpenCCU/OpenCCU/wiki/Installation-UNRAID)
     * [XCP-ng/XenServer](https://github.com/OpenCCU/OpenCCU/wiki/Installation-XCPng)
     * [Oracle VirtualBox](https://github.com/OpenCCU/OpenCCU/wiki/Installation-VirtualBox)
     * [vmWare Workstation Player](https://github.com/OpenCCU/OpenCCU/wiki/Installation-vmWare-Workstation-Player)
     * [vmWare ESXi](https://github.com/OpenCCU/OpenCCU/wiki/Installation-vmWare-ESXi)
     * [HyperV](https://github.com/OpenCCU/OpenCCU/wiki/Installation-HyperV)
   * [Configuration Upgrade](https://github.com/OpenCCU/OpenCCU/wiki/Installation#konfigurationsübernahme)
     * [Upgrade from CCU3](https://github.com/OpenCCU/OpenCCU/wiki/Installation#umstieg-von-ccu3)
     * [Upgrade from CCU2](https://github.com/OpenCCU/OpenCCU/wiki/Installation#umstieg-von-ccu2)
     * [Upgrade from CCU1](https://github.com/OpenCCU/OpenCCU/wiki/Installation#umstieg-von-ccu1)
     * [Upgrade to virtual OpenCCU](https://github.com/OpenCCU/OpenCCU/wiki/Installation#umstieg-zu-virtuellem-raspberrymatic)
   * [Deinstallation](https://github.com/OpenCCU/OpenCCU/wiki/Deinstallation)
3. [Administration](https://github.com/OpenCCU/OpenCCU/wiki/Administration)
   * [Firmware Update/Upgrade](https://github.com/OpenCCU/OpenCCU/wiki/Administration#firmware-updateupgrade)
   * [Backup/Restore](https://github.com/OpenCCU/OpenCCU/wiki/Administration#backup--restore)
   * [Security Advices](https://github.com/OpenCCU/OpenCCU/wiki/Administration#sicherheitshinweise)
   * [CCU-Addon Software](https://github.com/OpenCCU/OpenCCU/wiki/Administration#ccu-addons--zusatzsoftware)
4. Usage
   * [WebUI Usage](https://github.com/OpenCCU/OpenCCU/wiki/WebUI-Benutzung)
     * [Log-Level setup](https://github.com/OpenCCU/OpenCCU/wiki/WebUI-Benutzung#log-daten-und-log-level)
   * [Tips&Tricks](https://github.com/OpenCCU/OpenCCU/wiki/Tipps)
   * [Expert-Features](https://github.com/OpenCCU/OpenCCU/wiki/Experten-Features)
     * [WLAN/WiFi Setup](https://github.com/OpenCCU/OpenCCU/wiki/Experten-Features#wlanwifi-nutzung)
     * [Bluetooth Setup](https://github.com/OpenCCU/OpenCCU/wiki/Experten-Features#bluetooth-nutzung)
     * [LAN-Gateway Mode](https://github.com/OpenCCU/OpenCCU/wiki/Experten-Features#lan-gateway-betrieb)
     * [USV Client/Server Setup](https://github.com/OpenCCU/OpenCCU/wiki/Experten-Features#usv-clientserver-nut)
     * [USB-Boot Setup](https://github.com/OpenCCU/OpenCCU/wiki/Experten-Features#usb-boot)
     * [Monit-WatchDog WebUI](https://github.com/OpenCCU/OpenCCU/wiki/Experten-Features#monit-watchdog-weboberfl%C3%A4che)
     * [HB-RF-ETH Setup](https://github.com/OpenCCU/OpenCCU/wiki/Experten-Features#hb-rf-eth-anbindung)
     * [Individual Diagramm/Backup-Path](https://github.com/OpenCCU/OpenCCU/wiki/Experten-Features#individueller-diagrammbackup-speicherpfad)
     * [Own commands during bootup](https://github.com/OpenCCU/OpenCCU/wiki/Experten-Features#eigene-aktionen-während-des-bootvorgangs)
5. [Support, Contributions](https://github.com/OpenCCU/OpenCCU/wiki/Support)
   * [Known Issues](https://github.com/OpenCCU/OpenCCU/wiki/Support#bekannte-probleme)
   * [Request Help](https://github.com/OpenCCU/OpenCCU/wiki/Support#hilfe-suchen)
   * [FAQ - Frequently Asked Questions](https://github.com/OpenCCU/OpenCCU/wiki/Support#faq)
   * [Report Issues](https://github.com/OpenCCU/OpenCCU/wiki/Support#bugreports)
   * [Request Features](https://github.com/OpenCCU/OpenCCU/wiki/Support#featurerequests)
   * [Contributions / Development](https://github.com/OpenCCU/OpenCCU/wiki/Support#mitarbeit--weiterentwicklung)

## :yum: Support, Contributions

To provide general feedback or start discussions, please use either the [Discussion fora](https://github.com/OpenCCU/OpenCCU/discussions) in this GitHub project or (if you are german speaking) please contribute to the OpenCCU fora of the [HomeMatic-Forum](https://homematic-forum.de/forum/viewforum.php?f=65). If during discussions in these fora a definite and unique feature request or bug has been acknowledged by other OpenCCU users, please feel free to open a dedicated feature or bug fixing request in the [issue tracker](https://github.com/OpenCCU/OpenCCU/issues).

Any contribution in any way is highly welcome. Please feel free to contribute not only by using the official releases. If you have some time and free resources, we welcome any contributing to help to reproduce and perhaps even fixing any [open issues](https://github.com/OpenCCU/OpenCCU/issues) in our issue tracker. Also participating in enhancing or fixing the official wiki-based [documentation](https://github.com/OpenCCU/OpenCCU/wiki) is appreciated. That's why any logged-in GitHub user can directly add and modify any documentation pages in this wiki.

On top of that, direct contributions by sending in PullRequests and source code contributions (Bugs, Features, etc.) are welcome. So if someone would like to see a certain feature implemented or bug fixed and has enough free resources and knowhow, please feel free to directly send in PullRequests using Git/GitHub. Please note, however, that any contribution to this open source project have to be in accordance to the Apache-2.0 open source license under which OpenCCU itself is developed and distributed. So by sending in PullRequests you will have to acknowledge that you are fine with the license implications of your contributions. Therefore, please refer to [CONTRIBUTING](CONTRIBUTING.md) as well as reading our [CODE OF CONDUCT](CODE_OF_CONDUCT.md) before you consider contributing to this project in any form.

[more...](https://github.com/OpenCCU/OpenCCU/wiki/Support)

## :scroll: Licenses

The OpenCCU project itself – the files in this repository – as well as the downloadable binary images in the [Releases](https://github.com/OpenCCU/OpenCCU/releases) section are distributed under conditions of the open source [Apache License 2.0](https://opensource.org/licenses/Apache-2.0) license, if not otherwise stated. OpenCCU itself is distributed completely free of charge and without any commercial intention whatsoever. Please note, that on top of the Apache-2.0 license, under which OpenCCU itself is distributed, other components (e.g. the underlying Buildroot/Linux Operating System) are distributed under different licenses. E.g. Buildroot/Linux itself is distributed under the [GPLv2](http://www.gnu.org/licenses/gpl-2.0.html) which could have other implications when changing source parts or distributing own OpenCCU images. Furthermore, the [eQ-3 OCCU](https://github.com/eq-3/occu) components OpenCCU uses to provide the HomeMatic/homematicIP interconnectivity are re-distributed under the [HMSL](https://github.com/eq-3/occu/blob/master/LicenseEN.txt) license terms. Furthermore, the OpenCCU logo and all other graphical image files in this repository and the downloadable binary images which are closely linked to this project are copyrighted by its sole authors. Any commercial and non-commercial (re-)use of these graphical image files or use of the OpenCCU logo are strictly prohibited when distributing own binary distributions or forked versions of OpenCCU.

### Disclaimer of Warranty

All project contributors provide OpenCCU (and each Contributor provides its Contributions) on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied, including, without limitation, any warranties or conditions of TITLE, NON-INFRINGEMENT, MERCHANTABILITY, or FITNESS FOR A PARTICULAR PURPOSE. You are solely responsible for determining the appropriateness of using or redistributing OpenCCU and assume any risks associated with Your exercise of permissions under this License.

[more...](https://github.com/OpenCCU/OpenCCU/wiki/Einleitung#lizenz--haftung)

## :book: Literature

If after reading through this documentation anyone is still unsure regarding the pros and cons of using OpenCCU rather than the standard vendor-provided CCU firmware or if someone would like to read / see more on which additional features OpenCCU provides, please see the following list of (mostly german speaking) literature:

<a href="https://www.youtube.com/watch?v=regDw7rcIb0"><img alt="Usertreffen Kassel 2019 – OpenCCU" src="https://img.youtube.com/vi/regDw7rcIb0/hqdefault.jpg" width=320></a>
<a href="https://www.youtube.com/watch?v=hSmDcrkHb7M"><img alt="Usertreffen Kassel 2018 – OpenCCU" src="https://img.youtube.com/vi/hSmDcrkHb7M/hqdefault.jpg" width=320></a>

* [Vortragsfolien HomeMatic-Usertreffen 2019](https://homematic-forum.de/forum/download/file.php?id=59500)
* [Vortragsfolien HomeMatic-Usertreffen 2018](https://homematic-forum.de/forum/download/file.php?id=48428)
* [Vortragsfolien HomeMatic-Usertreffen 2017](https://homematic-forum.de/forum/download/file.php?id=40869)
* [Vortragsfolien HomeMatic-Usertreffen 2016](https://homematic-forum.de/forum/download/file.php?id=40868)

## :clap: Acknowledgements

In addition to the whole list of [Contributors](https://github.com/OpenCCU/OpenCCU/graphs/contributors) which have contributed to the success of OpenCCU, we would like to explicitly thank the following list of people for their third-party contributions:

* _Alexander Reinert (@alexreinert)_ – for his low-latency [generic_raw_uart kernel module](https://github.com/alexreinert/piVCCU/tree/master/kernel) which allows to use the eQ3 distributed RF modules (RPI-RF-MOD, HM-MOD-RPI-PCB) as well as for his [HB-RF-USB](https://github.com/alexreinert/PCB/tree/master/HB-RF-USB), [HB-RF-USB-2](https://github.com/alexreinert/PCB/tree/master/HB-RF-USB-2) and [HB-RF-ETH](https://github.com/alexreinert/PCB/tree/master/HB-RF-ETH) open hardware projects providing USB and Ethernet based adapter PCBs to use the eQ3 RF modules with other base interfaces.

## :family: Authors

Due to the large number of existing people having contributed to the success of OpenCCU, please refer to the [Contributors](https://github.com/OpenCCU/OpenCCU/graphs/contributors) accordingly.

## :construction: ChangeLog

A detailed list of Changes between individual released versions can be reviewed through the [Releases](https://github.com/OpenCCU/OpenCCU/releases/) section of this GitHub project.
