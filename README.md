<img src="release/logo.png" width="250px" align="left">

<br/><br/>
[![Current Release](https://img.shields.io/github/release/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/jens-maus/RaspberryMatic/latest/total.svg)](https://github.com/jens-maus/RaspberryMatic/releases/latest)
[![Contributors](https://img.shields.io/github/contributors/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/graphs/contributors)
[![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/issues)
[![Percentage of issues still open](http://isitmaintained.com/badge/open/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/issues)
[![Commits since last release](https://img.shields.io/github/commits-since/jens-maus/RaspberryMatic/latest.svg)](https://github.com/jens-maus/RaspberryMatic/releases/latest)
[![License](https://img.shields.io/github/license/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/blob/master/LICENSE)
[![Donate](https://img.shields.io/badge/donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=RAQSDY9YNZVCL)
[![Twitter](https://img.shields.io/twitter/follow/RaspberryMatic.svg?style=social&label=Follow)](https://twitter.com/RaspberryMatic)
[![GitHub stars](https://img.shields.io/github/stars/jens-maus/RaspberryMatic.svg?style=social&label=Star)](https://github.com/jens-maus/RaspberryMatic/stargazers/)

The _RaspberryMatic_ project is a collaborate effort to provide a lightweight, [Linux/buildroot](http://buildroot.org/)-based HomeMatic compatible operating system for embedded single board computers (SBC) like the [RaspberryPi](https://www.raspberrypi.org/) or [Tinkerboard](https://www.asus.com/Single-Board-Computer/Tinker-Board-S/). It is meant to provide a an alternative operating system for [CCU3](https://www.homematic-ip.com/en/products/detail/smart-home-central-control-unit-ccu3.html) or [ELV Charly](https://www.elv.de/elv-smart-home-zentrale-charly-starter-set-bausatz.html) systems. It is based on the **O**pen-**C**entral-**C**ontrol-**U**nit-SDK ([OCCU](https://github.com/eq-3/occu)) provided by [eQ-3](http://eq-3.de) as part of the [HomeMatic](http://homematic.com/) home automation platform. The RaspberryMatic distribution is provided as a full operating system image that can be flashed and then used in a RaspberryPi/Tinkerboard as the main operating system for controlling all HomeMatic compatible devices with full compatibility to a CCU device directly sold by eQ-3.

## :cookie: Features
* 100% HomeMatic [CCU2](http://www.eq-3.com/products/homematic/control-units-and-gateways/homematic-central-control-unit-ccu2.html)/[CCU3](http://www.eq-3.com/products/homematic/control-units-and-gateways/-473.html) system compliant using latest [OCCU](https://github.com/eq-3/occu) software environment
* Fully HomeMatic (BidCos-RF), HomeMatic-Wired (BidCos-Wired), homematicIP (HmIP-RF) and homematicIP-Wired (HmIP-Wired) compatible.
* Integrated WebUI-based firmware update mechanism and Recovery System to perform maintenance operations such as system restore.
* Enabled Preemptive kernel support (`PREEMPT`) to minimize latencies and improve CCU operation properties
* Read-only root file system to minimize write operations on SD card
* Includes embedded JAVA8 runtime environment ([1.8.0_222-8.40.0.178](http://www.azul.com/downloads/zulu-embedded/))
* Full IPv6 support and default HTTPS enabled WebUI support
* Auto-resizing `/usr/local` partition to utilize the full capacity of the SD card or USB stick
* Hardware WatchDog support automatically rebooting the system upon severe hardware/lockup problems
* Direct [CloudMatic](http://cloudmatic.de) (meine-homematic.de) support

## :cake: Exclusive Features (not available in CCU2/CCU3 firmware)
* Runs on all available [RaspberryPi](https://www.raspberrypi.org/) and [ASUS Tinkerboard](https://www.asus.com/Single-Board-Computer/Tinker-Board-S/) hardware models on the market.
* Integration of latest [community version of ReGaHss](https://github.com/eq-3/occu/tree/master/arm-gnueabihf/packages-eQ-3/WebUI-Beta) comming with [latest features and bugfixes](https://github.com/jens-maus/RaspberryMatic/projects/2) in logic engine.
* Integration of over 40 [third-party patches](https://github.com/jens-maus/RaspberryMatic/projects/3) for an improved WebUI experience providing the following additional functionalities:
  * Possibility to disable service messages for manually deactivating homematic devices
  * Direct display of important status messages (config pending, unreach, etc.) and RSSI values for each device
  * Added display of battery level and valve state for all heating control devices (e.g. `HM-CC-RT-DN` or `HMIP-eTRV`)
  * Completly reworked scripting editor (using [CodeMirror](https://codemirror.net/) engine) with the following features:
    * display of line numbers
    * syntax highlighting
    * internal (regex) search & replace functionality as well as match display on the scrollbar
    * internal command completion based on already existing words in the currently edited script
    * brackets-based code folding capabilities
    * brackets matching display to highlight all opening/closing brackets while editing
    * auto adding of closing brackets while editing
    * switchable fullscreen mode
    * Advanced editor keyboard shortcuts (e.g. `Ctrl-Q`: auto folding/un-folding of brackets)
  * Possibility to use "equal" and "not equal" comparisons in WebUI programs  
  * Possibility to force a boot into the recovery system on next boot
  * Optimized WebUI-based file upload/download with improved large file support
  * Possibility to perform a CCU addon installation without a forced reboot
  * Display of the number of previously performed security key changes
  * Possibility to alphabetically sort all system variables added as user favorites
  * Improved browser cache handling for reduced conflicts when updating to newer firmware versions
  * Added Apple-Touch icons to be displayed if the WebUI is displayed as an iOS App on the Desktop of a iPad/iPhone
  * Integrated certain bug fixes in case system variables with white spaces and newlines are used
  * System variables can now be added as user favorites even though they were previously connected to a device channel
  * Cosmetical enhancements in the various table displays in the WebUI
  * More table filter possibilities for a faster search for devices/channels
  * Minor fixes to DevConfig tweak to also display RSSI values for HmIP devices
* Integration of certain general security enhancements:
  * Improved WebUI security via enabled cross-site-scripting preventions (`X-Frame-Options`, `X-XSS-Protection`, `X-Robots-Tag`, etc.)
  * Encryption certificates for HTTPS are exclusively generated on the system itself (and not via third-party servers)
  * Delivered `robots.txt` to prevent web crawlers from indexing a CCU in case it is accidently available from the internet
  * General use of SHA512 strong password hashes when entering a new SSH connection password
  * In case of low-memory conditions critical homematic services will be killed as one of the last services
* Improved backup/restore functionality for
  * manually running a backup/restore on the command-line (`createBackup.sh`, `restoreBackup.sh`)
  * automatic nightly backups on a connected USB memory stick
  * possibility to route nightly backups to external storage devices (e.g. NAS)
* Additional linux packages installed/available:
  * `wiringPi` - GPIO library and command-line tools to easily query/set GPIO states
  * `chrony` - as a drop-in replacement for the old `ntpd` NTP daemon used
  * `jq` - json parsing command-line tool
  * `ethtool` - command-line tool to query/set information on network links
  * `f2fs` - F2FS filesystem which is explicitly developed for flash devices and can be used for e.g. external USB devices
* Additional helper scripts useable on command-line:
  * `triggerAlarm.tcl` – can be used to trigger an own alarm in the WebUI
  * `updateAddonContig.tcl` – to add/remove CCU addon buttons to the WebUI
* Automatic generation and update of `DutyCycle` system variables which will contain the percentage of each rf module (GPIO module or connected LAN gateways) as well as automatic alarm triggering in case a duty cycle > 98% is reached
* Use of the RaspberryPi/Tinkerboard onboard LEDs to signal general system load using heartbeat-typed LED flashes
* A combination of multiple homematic RF-modules can be used to distribute DutyCycle and allow for a wider range of different homematic access scenarios (e.g. `HmIP-RF-USB` and `HM-CFG-USB-2` at the same time)
* Support to be used as a pure HomeMatic LAN Gateway ([HM-LGW-O-TW-W-EU](https://www.elv.de/homematic-funk-lan-gateway.html)) only
* Support to be used without any GPIO RF module HAT when just connecting to a HomeMatic LAN Gateway ([HM-LGW-O-TW-W-EU](https://www.elv.de/homematic-funk-lan-gateway.html))
* Self-contained disk image targeted for lightweight embedded devices (e.g. RaspberryPi, ASUS Tinkerboard)
* Based on latest [Buildroot 2019.08.1](http://buildroot.org/) lightweight Linux operating system
* Latest Linux kernel (RaspberryPi: [4.19.79](https://github.com/raspberrypi/linux/tree/rpi-4.19.y), Tinkerboard: [4.19.79](https://github.com/armbian/build/tree/master/patch/kernel/rockchip-next)) with hard-float (ARMv7) support
* Support to boot system using an external USB memory stick or hard disk (RaspberryPi3 only) or from internal eMMC storage (ASUS Tinkerboard S)
* Supports onboard WiFi of RaspberryPi3, RaspberryPi Zero W or ASUS Tinkerboard as well as various third-party USB WiFi sticks
* Supports USB Gadget Mode for RaspberryPi Zero and RaspberryPi Zero W to connect the USB port to another system (Linux/macOS/Windows) and use it for a routed ethernet connection (requires `/etc/config/usbGadgetModeEnabled`)
* Supports onboard Bluetooth of RaspberryPi3, RaspberryPi Zero W or ASUS Tinkerboard as well as various third-party USB Bluetooth sticks
* Supports [Network UPS Tools](http://networkupstools.org) (NUT) setups including USB connection to uninterruptible power supply (UPS) as well as remote NUT server use (e.g. via Synology NAS Network UPS functionality)
* Support for the following third-party *Hardware Attached on Top* (HAT) boards:
  * [S.USV](http://www.s-usv.de/) – UPS including alarm notification upon power loss and automatic system shutdown.
  * [PiUSV+](https://www.reichelt.de/?ARTICLE=169883) – UPS including alarm notification upon power loss and automatic system shutdown.
  * [PiModules UPS PIco](http://pimodules.com/) – UPS including automatic system shutdown.
  * [StromPi2](https://strompi.joy-it.net/strompi-2/) – UPS including alarm notification upon power loss (WARNING: [StromPi3](https://strompi.joy-it.net/strompi-3/) is *NOT* supported!)
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
#### Existing product
You can use one of the following existing ready-to-go products:

<img src="https://files.elv.com/bilder/artikel/Produkte/15/1519/151965/Internet/normalneu/151965_F03_GeCCU3.jpg" alt="CCU3" width=150 align=right>

1. [CCU3](https://www.elv.de/homematic-ip-smart-home-zentrale-ccu3-inklusive-mediola-aio-creator-neo-lizenz.html)
2. [ELV Charly](https://www.elv.de/elv-smart-home-zentrale-charly-starter-set-bausatz.html)

#### Build-your-Own hardware
... or you can build your own embedded system using the following components:

<img src="https://files.elv.com/bilder/artikel/Produkte/25/2502/250297/Internet/normalneu/250297_w01_charly.jpg" alt="ELV Charly with RaspberryPi+RPI-RF-MOD" width=200 align=right>

1. One of the following hardware boards:
   * [RaspberryPi4 Model B](https://www.raspberrypi.org/products/raspberry-pi-4-model-b/)
   * [RaspberryPi3 Model B+](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
   * [RaspberryPi3 Model B](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)
   * [RaspberryPi3 Model A+](https://www.raspberrypi.org/products/raspberry-pi-3-model-a-plus/)
   * [RaspberryPi2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b)
   * [RaspberryPi Compute Module 3](https://www.raspberrypi.org/products/compute-module-3/)
   * [RaspberryPi Compute Module 3 lite](https://www.raspberrypi.org/products/compute-module-3-lite/)
   * [RaspberryPi Zero W](https://www.raspberrypi.org/products/raspberry-pi-zero-w/)
   * [RaspberryPi Zero](https://www.raspberrypi.org/products/raspberry-pi-zero/)
   * [RaspberryPi Compute Module 1](https://www.raspberrypi.org/products/compute-module-1/)
   * [RaspberryPi1 Model B+](https://www.raspberrypi.org/products/raspberry-pi-1-model-b-plus/)
   * [RaspberryPi1 Model B, 512MB](https://www.adafruit.com/product/998)
   * [RaspberryPi1 Model A+](https://www.raspberrypi.org/products/raspberry-pi-1-model-a-plus/)
   * [RaspberryPi1 Model A, 256MB](https://www.adafruit.com/product/1344)
   * [Tinker Board S](https://www.asus.com/Single-Board-Computer/Tinker-Board-S/)
   * [Tinker Board](https://www.asus.com/en/Single-Board-Computer/Tinker-Board/)
2. A minimum 4 GB sized microSD card or USB device (memory stick, SSD, hard disk)
3. One or more of the following homematic capabale communication devices:

|  | | HomeMatic | homematicIP | HomeMatic-Wired | homematicIP-Wired |
| ----------- | ------ | :-------: | :---------: | :-------------: | :---------------: |
| [RPI-RF-MOD](https://www.elv.de/homematic-funk-modulplatine-fuer-raspberry-pi-3-rpi-rf-mod-komplettbausatz.html) | GPIO Radio Module HAT | :heavy_check_mark: | :heavy_check_mark: |
| [HM-MOD-RPI-PCB](http://www.elv.de/homematic-funkmodul-fuer-raspberry-pi-bausatz.html)<br/>([Installation](https://www.youtube.com/watch?v=xtzXsvOLa_Y)) | GPIO Radio Module HAT | :heavy_check_mark: | :heavy_check_mark: |
| [HB-RF-USB](https://github.com/alexreinert/PCB/tree/master/HB-RF-USB)<br/> ([Discussion](https://homematic-forum.de/forum/viewtopic.php?f=69&t=47691#p477528)) | USB Radio Module Adapter PCB | :heavy_check_mark: | :heavy_check_mark: |
| [HmIP-RFUSB](https://www.elv.de/elv-homematic-ip-rf-usb-stick-hmip-rfusb-fuer-alternative-steuerungsplattformen-arr-bausatz.html) | USB Radio Module Stick | | :heavy_check_mark: |
| [HM-CFG-USB-2](https://wiki.fhem.de/wiki/HM-CFG-USB_USB_Konfigurations-Adapter) | USB Radio Module Stick | :heavy_check_mark: |
| [HM-LGW-O-TW-W-EU](https://www.elv.de/homematic-funk-lan-gateway.html) | LAN RF-Gateway | :heavy_check_mark: |
| [HMW-LGW-O-DR-GS-EU](https://www.elv.de/homematic-rs485-gateway-1.html) | LAN Wired-Gateway |  | | :heavy_check_mark: |
| [HmIPW-DRAP](https://www.elv.de/homematic-ip-wired-access-point.html) | HmIP-Wired Access Point | | | | :heavy_check_mark:<br/>(requires RPI-RF-MOD) |

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
<a href="https://www.youtube.com/watch?v=regDw7rcIb0"><img alt="Usertreffen Kassel 2019 – RaspberryMatic" src="https://img.youtube.com/vi/regDw7rcIb0/hqdefault.jpg" width=320></a>
<a href="https://www.youtube.com/watch?v=hSmDcrkHb7M"><img alt="Usertreffen Kassel 2018 – RaspberryMatic" src="https://img.youtube.com/vi/hSmDcrkHb7M/hqdefault.jpg" width=320></a>
<a href="https://www.youtube.com/watch?v=LQrzittdEGg"><img alt="Usertreffen Kassel 2017 – RaspberryMatic (Teil 1)" src="https://img.youtube.com/vi/LQrzittdEGg/hqdefault.jpg" width=320></a>
<a href="https://www.youtube.com/watch?v=duSTLdVKSeM"><img alt="Usertreffen Kassel 2017 - RaspberryMatic (Teil 2)" src="https://img.youtube.com/vi/duSTLdVKSeM/hqdefault.jpg" width=320></a>

## :yum: How to contribute
As the RaspberryMatic project is an open source based project everyone is invited to contribute to this project. Please note, however, that functionality within the corresponding eQ-3 OCCU binaries can not be modified as the main HomeMatic services (rfd, ReGaHSS, HMServer, etc.) are provided in binary format by the [OCCU](https://github.com/eq-3/occu) project and not compiled from sources. Nevertheless, if you are a talented developer and want to contribute to the success of RaspberryMatic feel free to send over pull requests or report issues / enhancement requests. Please note, however, the licensing and contributing implications and accept that - in short - anything you contribute to this repository/project (especially source code) will be (re)licensed under the Apache 2.0 license (see [CONTRIBUTING.md](CONTRIBUTING.md)). In addition, please understand that we will only accept contributions (either source code or issues in the issue tracker) if these comply to our [CODE OF CONDUCT](CODE_OF_CONDUCT.md).

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
