<img src="release/logo.png" width="250px" align="left">

<br/><br/>
[![Current Release](https://img.shields.io/github/release/jens-maus/RaspberryMatic.svg?style=flat-square)](https://github.com/jens-maus/RaspberryMatic/releases/latest)
[![HitCount](http://hits.dwyl.io/jens-maus/RaspberryMatic.svg)](http://hits.dwyl.io/jens-maus/RaspberryMatic)
[![Downloads](https://img.shields.io/github/downloads/jens-maus/RaspberryMatic/latest/total.svg?style=flat-square)](https://github.com/jens-maus/RaspberryMatic/releases/latest)
[![Issues](https://img.shields.io/github/issues/jens-maus/RaspberryMatic.svg?style=flat-square)](https://github.com/jens-maus/RaspberryMatic/issues)
![License](https://img.shields.io/github/license/jens-maus/RaspberryMatic.svg?style=flat-square)
[![Donate](https://img.shields.io/badge/donate-PayPal-green.svg?style=flat-square)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=RAQSDY9YNZVCL)

The _RaspberryMatic_ project is a collaborate effort to provide a lightweight, [Linux/buildroot](http://buildroot.org/)-based HomeMatic compatible distribution for embedded single board computers (SBC) like the [RaspberryPi](https://www.raspberrypi.org/) or [Tinkerboard](https://www.asus.com/Single-Board-Computer/Tinker-Board-S/). It is based on the **O**pen-**C**entral-**C**ontrol-**U**nit-SDK ([OCCU](https://github.com/eq-3/occu)) provided by [eQ-3](http://eq-3.de) as part of the [HomeMatic](http://homematic.com/) home automation platform. The RaspberryMatic distribution is provided as a full operating system image that can be flashed and then used in a RaspberryPi/Tinkerboard as the main operating system for controlling all HomeMatic compatible devices with full compatibility to a CCU device directly sold by eQ-3.

## :cookie: Features
* 100% HomeMatic [CCU2](http://www.eq-3.com/products/homematic/control-units-and-gateways/homematic-central-control-unit-ccu2.html)/[CCU3](http://www.eq-3.com/products/homematic/control-units-and-gateways/-473.html) system compliant using latest [OCCU](https://github.com/eq-3/occu) software environment
* Fully HomeMatic (BidCos-RF), HomeMatic-Wired (BidCos-Wired), homematicIP (HmIP-RF) and homematicIP-Wired (HmIP-Wired) compatible.
* Integrated WebUI-based firmware update mechanism and Recovery System to perform maintenance operations such as system restore.
* Enabled Preemptive kernel support (`PREEMPT`) to minimize latencies and improve CCU operation properties
* Read-only root file system to minimize write operations on SD card
* Includes embedded JAVA8 runtime environment ([1.8.0_192-8.33.0.134](http://www.azul.com/downloads/zulu-embedded/))
* Full IPv6 support and default HTTPS enabled WebUI support
* Auto-resizing `/usr/local` partition to utilize the full capacity of the SD card or USB stick
* Hardware WatchDog support automatically rebooting the system upon severe hardware/lockup problems
* Direct [CloudMatic](http://cloudmatic.de) (meine-homematic.de) support

## :cake: Exclusive Features (not available in CCU2/CCU3 firmware)
* Fully compatible to all available [RaspberryPi](https://www.raspberrypi.org/) and [ASUS Tinkerboard](https://www.asus.com/Single-Board-Computer/Tinker-Board-S/) hardware models on the market.
* Integration of latest [community version of ReGaHss](https://github.com/eq-3/occu/tree/master/arm-gnueabihf/packages-eQ-3/WebUI-Beta) comming with [latest features and bugfixes](https://github.com/jens-maus/RaspberryMatic/projects/2) in logic engine.
* Integration of over 40 [third-party patches](https://github.com/jens-maus/RaspberryMatic/projects/3) for an improved WebUI experience.
* Support to be used as a pure HomeMatic LAN Gateway ([HM-LGW-O-TW-W-EU](https://www.elv.de/homematic-funk-lan-gateway.html)) only
* Support to be used without GPIO RF module just connecting to a HomeMatic LAN Gateway ([HM-LGW-O-TW-W-EU](https://www.elv.de/homematic-funk-lan-gateway.html))
* Self-contained disk image targeted for lightweight embedded devices (e.g. RaspberryPi, ASUS Tinkerboard)
* Based on latest [Buildroot 2018.08.2](http://buildroot.org/) lightweight Linux operating system
* Latest Linux kernel (RaspberryPi: [4.14.80](https://github.com/raspberrypi/linux/tree/rpi-4.14.y), Tinkerboard: [4.14.80](https://github.com/armbian/build/tree/master/patch/kernel/rockchip-next)) with hard-float (ARMv7) support
* Support to boot system using an external USB memory stick or hard disk (RaspberryPi3 only) or from internal eMMC storage (ASUS Tinkerboard S)
* Supports onboard WiFi of RaspberryPi3, Raspberry Pi Zero W or ASUS Tinkerboard as well as various third-party USB WiFi sticks
* Supports onboard Bluetooth of RaspberryPi3, Raspberry Pi Zero W or ASUS Tinkerboard as well as various third-party USB Bluetooth sticks
* Supports [Network UPS Tools](http://networkupstools.org) (NUT) setups including USB connection to uninterruptible power supply (UPS) as well as remote NUT server use (e.g. via Synology NAS Network UPS functionality)
* Support to query status information of the underlying Linux system using SNMP requests
* Support for the following third-party *Hardware Attached on Top* (HAT) boards:
  * [S.USV](http://www.s-usv.de/) – UPS including alarm notification upon power loss and automatic system shutdown.
  * [PiUSV+](https://www.reichelt.de/?ARTICLE=169883) – UPS including alarm notification upon power loss and automatic system shutdown.
  * [PiModules UPS PIco](http://pimodules.com/) – UPS including automatic system shutdown.
  * [StromPi2](https://strompi.joy-it.net/strompi-2/) – UPS including alarm notification upon power loss.
  * [PiDesktop](http://de.farnell.com/element14/pi-desktop/element-14-pi-desktop-hatencl/dp/2687142) – Addon HAT with power button and dedicated RTC clock (PCF8563).
* Integrated support for various RTC clock modules:
  * [PiFace Shim RTC](http://www.piface.org.uk/products/piface_clock/)
  * [DS3231](https://thepihut.com/products/mini-rtc-module-for-raspberry-pi)
  * [DS1307](https://thepihut.com/products/ds1307-rtc-module-with-battery-for-raspberry-pi)
  * [RX8130CE](https://www5.epsondevice.com/en/products/rtc/rx8130ce.html)
  * [PCF8563](https://www.nxp.com/products/analog/signal-chain/real-time-clocks/ic-real-time-clocks-rtc/real-time-clock-calendar:PCF8563)
  * onboard Tinkerboard RTC
* Dedicated Build Environment using a cross compiler (`arm-linux-gcc`) to compile third-party applications
  
## :fire: Limitations
* No web-based configuration for setting up WiFi or Bluetooth support (work in progress)
* No web-based configuration for enabling/disabling the LAN-Gateway mode (work in progress)
* No web-based configuration for configuring NUT (UPS) support (work in progress)

## :computer: Requirements
<img src="https://files.elv.com/bilder/artikel/Produkte/15/1529/152941/Internet//gross/152941_w01_modulplatine.jpg" alt="RaspberryPi equipped with RPI-RF-MOD" width=300 align=right>

* Any of the following embedded hardware boards:
  * [RaspberryPi3 Model B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
  * [RaspberryPi3 Model B](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)
  * [RaspberryPi3 Model A+](https://www.raspberrypi.org/products/raspberry-pi-3-model-a-plus/)
  * [RaspberryPi2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b)
  * [RaspberryPi Compute Module 3](https://www.raspberrypi.org/products/compute-module-3/)
  * [RaspberryPi Compute Module 3 lite](https://www.raspberrypi.org/products/compute-module-3-lite/)
  * [RaspberryPi Zero W](https://www.raspberrypi.org/products/pi-zero-w/)  
  * [RaspberryPi Zero](https://www.raspberrypi.org/products/pi-zero/)
  * [RaspberryPi Compute Module 1](https://www.raspberrypi.org/products/compute-module/)  
  * [RaspberryPi1 Model B+](https://www.raspberrypi.org/products/model-b-plus/) or [Model B, 512MB](https://www.adafruit.com/product/998)
  * [RaspberryPi1 Model A+](https://www.raspberrypi.org/products/model-a-plus/) or [Model A, 256MB](https://www.adafruit.com/product/1344)
  * [Tinker Board S](https://www.asus.com/Single-Board-Computer/Tinker-Board-S/)
  * [Tinker Board](https://www.asus.com/en/Single-Board-Computer/Tinker-Board/)
* One or more of the following HomeMatic/HomeMatic-Wired/homematicIP/homematicIP-Wired capabale devices:
  * HomeMatic َ+ homematicIP:
    * GPIO Radio Module HAT – [RPI-RF-MOD](https://www.elv.de/homematic-funk-modulplatine-fuer-raspberry-pi-3-rpi-rf-mod-komplettbausatz.html)  
    * GPIO Radio Module HAT – [HM-MOD-RPI-PCB](http://www.elv.de/homematic-funkmodul-fuer-raspberry-pi-bausatz.html) ([Installation](https://www.youtube.com/watch?v=xtzXsvOLa_Y))
  * homematicIP only:
    * USB Stick – [HmIP-RFUSB](https://www.elv.de/elv-homematic-ip-rf-usb-stick-hmip-rfusb-fuer-alternative-steuerungsplattformen-arr-bausatz.html)
  * HomeMatic only:
    * LAN Gateway – [HM-LGW-O-TW-W-EU](https://www.elv.de/homematic-funk-lan-gateway.html)
    * USB Config Adapter – [HM-CFG-USB-2](https://wiki.fhem.de/wiki/HM-CFG-USB_USB_Konfigurations-Adapter)
  * HomeMatic-Wired only:
    * LAN Wired Gateway – [HMW-LGW-O-DR-GS-EU](https://www.elv.de/homematic-rs485-gateway-1.html)
  * homematicIP-Wired only:
    * Wired Access Point (DRAP) – [HmIPW-DRAP](https://www.elv.de/homematic-ip-wired-access-point.html)
* 4 GB minimum sized microSD card or USB memory stick / hard disk (RaspberryPi3 only)

## :telescope: Compatible Third-Party CCU Addons
The CCU platform allows to enhance the functionality of a CCU by installing so-called CCU Addon packages. For RaspberryMatic, standard CCU Addon packages won't work because included binaries have to be recompiled for the hard-float buildroot environment RaspberryMatic uses. Here is a list of well-known already compatible Addon packages (please note that this list might be incomplete):

* [CUxD](https://github.com/jens-maus/cuxd)
* [XML-API](https://github.com/hobbyquaker/XML-API)
* [hm_pdetect](https://github.com/jens-maus/hm_pdetect)
* [Email-Addon](https://github.com/jens-maus/hm_email)
* [CUxD-Highcharts](https://github.com/hobbyquaker/CUxD-Highcharts)
* [HQ-WebUI](https://github.com/hobbyquaker/hq-webui)
* [DB-Access](https://github.com/jens-maus/dbaccess)
* [QuickAccess](https://github.com/jens-maus/quickaccess)
* [Script-Parser](https://github.com/litti/scriptparser)
* [WebMatic](https://github.com/ldittmar81/webmatic)
* [Sonos Player](https://github.com/jens-maus/hm-sonos)
* [hm2mqtt](https://github.com/owagner/hm2mqtt)
* [CCU-Historian](https://github.com/mdzio/ccu-historian)
* [Watchdog](https://github.com/jens-maus/hm-watchdog)
* [homeputer CL Studio](http://www.contronics.de/download/homeputer-studio-software.html)
* [Print / ProgrammeDrucken](https://github.com/litti/hm-print)
* [HomeMatic Check_MK](https://github.com/alexreinert/homematic_check_mk)
* [hm-tools](https://github.com/fhetty/hm-tools)
* [HB-UW-Sen-THPL Universalsensor](https://github.com/jp112sdl/Wettersensor/tree/master/Contrib/CCURM)
* [RedMatic](https://github.com/hobbyquaker/RedMatic)
* [Mosquitto](https://github.com/hobbyquaker/ccu-addon-mosquitto)
* [Redis](https://github.com/hobbyquaker/ccu-addon-redis)
* [HomeMatic Virtual Interface](https://github.com/thkl/Homematic-Virtual-Interface)

## :cloud: Installation
The installation of RaspberryMatic is quite straight forward as it is delivered as a full system image that can be directly flashed onto a microSD / eMMC and put into the corresponding SBC. As such the installation consists of the following basic steps:

1. [Download latest release](https://github.com/jens-maus/RaspberryMatic/releases) archive (`RaspberryMatic-X.XX.XX.YYYYMMDD-XXX.zip`) for the hardware platform you are using:
   * `wget https://github.com/jens-maus/RaspberryMatic/releases/download/X.XX.XX.YYYYMMDD/RaspberryMatic-X.XX.XX.YYYYMMDD-XXX.zip`
2. Unarchive zip file resulting in an SD card image (`RaspberryMatic-X.XX.XX.YYYYMMDD-XXX.img`), e.g.:
   * `unzip RaspberryMatic-X.XX.XX.YYYYMMDD-XXX.zip`
3. Check sha256 checksum to check integrity of SD card image, e.g.:
   * `sha256sum -c RaspberryMatic-X.XX.XX.YYYYMMDD-XXX.img.sha256`
4. Use the  image flasher tool "Etcher" (https://etcher.io) to flash the `*.img` file to your SD card or USB drive. As an alternative you can also use the following command-line calls to manually flash it on Unix-based operating systems:
   * <i>Linux</i>: `sudo dd if=RaspberryMatic-X.XX.XX.YYYYMMDD-XXX.img of=/dev/mmcblk0 bs=1M conv=fsync`
   * <i>macOS</i>: `sudo dd if=RaspberryMatic-X.XX.XX.YYYYMMDD-XXX.img of=/dev/rdiskX bs=1m`
5. For RPI-RF-MOD/HM-MOD-RPI-PCB use only: Make sure you have the RPI-RF-MOD/HM-MOD-RPI-PCB radio module correctly installed on the GPIO
6. Install microSD in your SBC and connect power
7. Wait until bootup process is finished and use a web browser to connect to http://homematic-raspi/

## :memo: Documentation
Documentation (e.g. how to port your HomeMatic configuration from a CCU2/CCU3 to RaspberryMatic) and installation support is currently limited to using a mostly german language speaking fora with the following links pointing to the relevant sections of the fora where you can find documentation and help about RaspberryMatic:

* [RaspberryMatic - Installation Guide :de:](https://homematic-forum.de/forum/viewtopic.php?f=65&t=34497#p328057)
* [RaspberryMatic - Forum :de:](https://homematic-forum.de/forum/viewforum.php?f=65)
* [HM-MOD-RPI-PCB - Installation Video :de:](https://www.youtube.com/watch?v=xtzXsvOLa_Y)

## :tv: Presentations (German :de: – YouTube)
<a href="https://www.youtube.com/watch?v=hSmDcrkHb7M"><img alt="Usertreffen Kassel 2018 – RaspberryMatic" src="https://img.youtube.com/vi/hSmDcrkHb7M/hqdefault.jpg" width=420></a>
<a href="https://www.youtube.com/watch?v=LQrzittdEGg"><img alt="Usertreffen Kassel 2017 – RaspberryMatic (Teil 1)" src="https://img.youtube.com/vi/LQrzittdEGg/hqdefault.jpg" width=420></a>
<a href="https://www.youtube.com/watch?v=duSTLdVKSeM"><img alt="Usertreffen Kassel 2017 - RaspberryMatic (Teil 2)" src="https://img.youtube.com/vi/duSTLdVKSeM/hqdefault.jpg" width=420></a>

## :yum: How to contribute
As the RaspberryMatic project is an open source based project everyone is invited to contribute to this project. Please note, however, that functionality within the corresponding eQ-3 OCCU binaries can not be modified as the main HomeMatic services (rfd, ReGaHSS, HMServer, etc.) are provided in binary format by the [OCCU](https://github.com/eq-3/occu) project and not compiled from sources. Nevertheless, if you are a talented developer and want to contribute to the success of RaspberryMatic feel free to send over pull requests or report issues / enhancement requests.

### :moneybag: Donations [![Donate](https://img.shields.io/badge/donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=RAQSDY9YNZVCL)
Even for those that don't have the technical knowhow to help developing on RaspberryMatic there are ways to support our development. Please consider sending us a donation to not only help us to compensate for expenses regarding RaspberryMatic, but also to keep our general development motivation on a high level. So if you want to donate some money please feel free to send us money via [PayPal](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=RAQSDY9YNZVCL). And if you are running a business which might integrate RaspberryMatic in one of your products please contact us for a regular donation plan which could not only show that you do care about open source development, but also could secure your product by ensuring that development on RaspberryMatic continues in future.

### :construction: Development
Building your own RaspberryMatic SD card image is a very straight forward process using this build environment – given that you have sufficient Linux/Unix knowledge and you know what you are actually doing. But if you know what you are doing and which host tools are required to actually be able to run a RaspberryMatic build, it should be as simple as:

```sh
$ git clone https://github.com/jens-maus/RaspberryMatic
$ cd RaspberryMatic
$ make dist
[wait up to 1h]
$ make install of=/dev/sdX
```

#### :bookmark: Using the generated cross compiler
After a successfull build of RaspberryMatic a dedicated cross compiler (`arm-linux-gcc`) should be available within the `build-raspmatic_rpi3` path. You can use this GCC-based cross compiler to compile all kind of third party applications which can then be run within RaspberryMatic:

```sh
$ cd HelloWorld
$ <path-to-RaspberryMatic-build>/build-raspmatic_rpi3/host/usr/bin/arm-linux-gcc -o HelloWorld HelloWorld.c
```

A valid alternative for building RaspberryMatic ARM-hardfloat compatible binaries is to use the following Linux cross compiler suite [supplied by the RaspberryPi foundation](https://github.com/raspberrypi/tools/tree/master/arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf).

## :scroll: License
The RaspberryMatic build environment itself – the files found in this git repository – as well as the RaspberryMatic sd card images are licensed under the conditions of the [Apache License 2.0](https://opensource.org/licenses/Apache-2.0). Please note, however, that the buildroot distribution RaspberryMatic is using is licensed under the [GPLv2](http://www.gnu.org/licenses/gpl-2.0.html) license instead. Furthermore, the [eQ-3 OCCU](https://github.com/eq-3/occu) software RaspberryMatic is using to provide HomeMatic-based services is licensed under the ([HMSL](https://github.com/eq-3/occu/blob/master/LicenseDE.txt)).

## :clap: Acknowledgments
As this project is a collaborative effort also indirectly using several third-party solutions we would like to thank the following authors for their valueable contributions:
* Alexander Reinert – for his [generic_raw_uart kernel module](https://github.com/alexreinert/piVCCU/tree/master/kernel) enabling homematicIP support with the ASUS Tinkerboard.

## :family: Authors
See [Contributors](https://github.com/jens-maus/RaspberryMatic/graphs/contributors) for a complete list of people that have directly contributed to this project.
