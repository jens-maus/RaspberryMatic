<img src="https://github.com/jens-maus/RaspberryMatic/raw/master/buildroot-external/package/homematic/logo.png" align=right>

# RaspberryMatic

[![Release](https://img.shields.io/github/release/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/releases/latest)
[![Downloads](https://img.shields.io/github/downloads/jens-maus/RaspberryMatic/latest/total.svg)](https://github.com/jens-maus/RaspberryMatic/releases/latest)
[![Issues](https://img.shields.io/github/issues/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/issues)
[![Code Climate](https://codeclimate.com/github/jens-maus/RaspberryMatic/badges/gpa.svg)](https://codeclimate.com/github/jens-maus/RaspberryMatic)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Donate](https://img.shields.io/badge/donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=RAQSDY9YNZVCL)

The RaspberryMatic project is a collaborate effort to provide a lightweight, [Linux/buildroot](http://buildroot.org/)-based HomeMatic compatible distribution for embedded devices like the [RaspberryPi](https://www.raspberrypi.org/). It is based on the **O**pen-**C**entral-**C**ontrol-**U**nit-SDK ([OCCU](https://github.com/eq-3/occu)) provided by [eQ-3](http://eq-3.de) as part of the [HomeMatic](http://homematic.com/) home automation platform. The RaspberryMatic distribution is provided as a full microSD card image that can be directly flashed and then used in a RaspberryPi as the main operating system for controlling all kind of HomeMatic compatible devices with full compatibility to a CCU2 device directly sold by eQ-3.

## Features
* 100% HomeMatic CCU system compliant using latest [OCCU 2.27.8](https://github.com/eq-3/occu) software releases
* Fully BidCos-RF (HomeMatic), Wired (HomeMatic-Wired) and HmIP-RF (HomeMatic-IP) compatible
* Integration of latest [beta versions of WebUI](https://github.com/eq-3/occu/tree/master/arm-gnueabihf/packages-eQ-3/WebUI-Beta) (`ReGaHss`)
* Self-contained disk image primarily targeted for RaspberryPi hardware
* Based on latest [Buildroot 2017.05](http://buildroot.org/) Linux environment
* Latest [Linux kernel v4.9.x](https://github.com/raspberrypi/linux/tree/rpi-4.9.y) with hard-float support 
* Enabled Preemptive kernel support (`PREEMPT`) to minimize latencies and improve CCU operation properties
* Support to boot system using an external USB memory stick or hard disk (RaspberryPi3 only)
* Read-only root file system to minimize write operations on SD card
* Supports latest JAVA8 runtime environment ([1.8.0_121-8.20.0.42](http://www.azul.com/downloads/zulu-embedded/))
* Supports onboard WiFi of RaspberryPi3 or Raspberry Pi Zero W as well as various third-party USB WiFi sticks
* Supports onboard Bluetooth of RaspberryPi3 or Raspberry Pi Zero W as well as various third-party USB Bluetooth sticks
* Supports [Network UPS Tools](http://networkupstools.org) (NUT) setup including USB connection of UPS as well as NUT server use (e.g. via Synology NAS Network UPS functionality)
* Support to be used as a LAN Gateway ([HM-LGW-O-TW-W-EU](https://www.elv.de/homematic-funk-lan-gateway.html)) only
* Support to be used without [HM-MOD-RPI-PCB](http://www.elv.de/homematic-funkmodul-fuer-raspberry-pi-bausatz.html) RF module and just connect it to a LAN Gateway ([HM-LGW-O-TW-W-EU](https://www.elv.de/homematic-funk-lan-gateway.html))
* Full IPv6 support and default HTTPS enabled WebUI support
* Supports to query status information of the underlying Linux system using SNMP requests
* Auto-resizing `/usr/local` partition to use the full capacity of the SD card or USB stick
* Direct support for RTC clock modules ([PiFace Shim RTC](http://www.piface.org.uk/products/piface_clock/), [DS3231](https://thepihut.com/products/mini-rtc-module-for-raspberry-pi), [DS1307](https://thepihut.com/products/ds1307-rtc-module-with-battery-for-raspberry-pi))
* Hardware WatchDog support automatically rebooting the system upon hardware/lockup problems
* Direct [CloudMatic](http://cloudmatic.de) (meine-homematic.de) support
* Dedicated Build Environment using a cross compiler (`arm-linux-gcc`) to compile third-party applications

## Limitations
* No web-based configuration for setting up WiFi or Bluetooth support (work in progress)

## Requirements
* Any of the following [RaspberryPi](https://www.raspberrypi.org/products/) models:
  * [RaspberryPi3 Model B](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/)
  * [RaspberryPi2 Model B](https://www.raspberrypi.org/products/raspberry-pi-2-model-b)
  * [RaspberryPi Compute Module 3](https://www.raspberrypi.org/products/compute-module-3/)
  * [RaspberryPi Compute Module 3 lite](https://www.raspberrypi.org/products/compute-module-3-lite/)
  * [RaspberryPi Zero W](https://www.raspberrypi.org/products/pi-zero-w/)  
  * [RaspberryPi Zero](https://www.raspberrypi.org/products/pi-zero/)
  * [RaspberryPi Compute Module 1](https://www.raspberrypi.org/products/compute-module/)  
  * [RaspberryPi1 Model B+](https://www.raspberrypi.org/products/model-b-plus/) or [Model B, 512MB](https://www.adafruit.com/product/998)
  * [RaspberryPi1 Model A+](https://www.raspberrypi.org/products/model-a-plus/) or [Model A, 256MB](https://www.adafruit.com/product/1344)
* 2GB minimum space on microSD card or USB memory stick / hard disk (when using RaspberryPi3)
* HomeMatic-RF GPIO radio module ([HM-MOD-RPI-PCB](http://www.elv.de/homematic-funkmodul-fuer-raspberry-pi-bausatz.html)) and/or HomeMatic LAN Gateway ([HM-LGW-O-TW-W-EU](https://www.elv.de/homematic-funk-lan-gateway.html))

## Compatible Third-Party Addons
The CCU platform allows to enhance the functionality of a CCU by installing so-called Addon packages. For RaspberryMatic, standard CCU-Addon packages won't work because included binaries have to be recompiled for the hard-float buildroot environment RaspberryMatic uses. Here is a list of well-known already compatible Addon packages (please note that this list might be incomplete):

* [CUxD](https://github.com/jens-maus/cuxd)
* [XML-API](https://github.com/hobbyquaker/XML-API)
* [hm_pdetect](https://github.com/jens-maus/hm_pdetect)
* [Email-Addon](https://github.com/jens-maus/hm_email)
* [CUxD-Highcharts](https://github.com/hobbyquaker/CUxD-Highcharts)
* [HQ-WebUI](https://github.com/jens-maus/hq-webui)
* [DB-Access](https://github.com/jens-maus/dbaccess)
* [QuickAccess](https://github.com/jens-maus/quickaccess)
* [Script-Parser](https://github.com/litti/scriptparser)
* [WebMatic](https://github.com/ldittmar81/webmatic)
* [Sonos Player](https://github.com/jens-maus/hm-sonos)
* [hm2mqtt](https://github.com/owagner/hm2mqtt)
* [CCU-Historian](https://github.com/jens-maus/hm-ccu-historian)
* [Watchdog](https://github.com/jens-maus/hm-watchdog)
* [homeputer CL Studio](http://www.contronics.de/download/homeputer-studio-software.html)
* [Print / ProgrammeDrucken](https://github.com/litti/hm-print)
* [HomeMatic Check_MK](https://github.com/alexreinert/homematic_check_mk)

## Installation
The installation of RaspberryMatic is quite straight forward as it is delivered as a full SD card image that can be directly flashed onto a microSD card and put into the corresponding RaspberryPi. As such the installation consists of the following basic steps:

1. [Download latest release](https://github.com/jens-maus/RaspberryMatic/releases) archive (`RaspberryMatic-X.XX.XX.YYYYMMDD-XXX.zip`) for the hardware platform you are using:
   * `wget https://github.com/jens-maus/RaspberryMatic/releases/download/X.XX.XX.YYYYMMDD/RaspberryMatic-X.XX.XX.YYYYMMDD-XXX.zip`
2. Unarchive zip file resulting in an SD card image (`RaspberryMatic-X.XX.XX.YYYYMMDD-XXX.img`), e.g.:
   * `unzip RaspberryMatic-X.XX.XX.YYYYMMDD-XXX.zip`
3. Check sha256 checksum to check integrity of SD card image, e.g.:
   * `sha256sum -c RaspberryMatic-X.XX.XX.YYYYMMDD-XXX.img.sha256`
4. Based on your operating system use a Flash-tool to copy the image onto your microSD card:
   * <i>Linux</i>: `sudo dd if=RaspberryMatic-X.XX.XX.YYYYMMDD-XXX.img of=/dev/sdX bs=4096`
   * <i>macOS</i>: `sudo dd if=RaspberryMatic-X.XX.XX.YYYYMMDD-XXX.img of=/dev/rdiskX bs=1m` (or [ApplePiBaker](http://www.tweaking4all.com/hardware/raspberry-pi/macosx-apple-pi-baker/))
   * <i>Windows</i>: Use [Win32DiskImager](https://sourceforge.net/projects/win32diskimager/)
5. For HM-MOD-RPI-PCB use only: Make sure you have the HM-MOD-RPI-PCB radio module installed on the GPIO
6. Install microSD in your RaspberryPi and connect power
7. Wait until bootup process is finished and use a web browser to connect to http://homematic-raspi/

## Documentation
Documentation (e.g. how to port your HomeMatic configuration from a CCU2 to RaspberryMatic) and installation support is currently limited to using a mostly german language speaking fora with the following links pointing to the relevant sections of the fora where you can find documentation and help about RaspberryMatic:

* [RaspberryMatic - Installation Guide](https://homematic-forum.de/forum/viewtopic.php?f=65&t=34497#p328057)
* [RaspberryMatic - Forum](https://homematic-forum.de/forum/viewforum.php?f=65)

## Contributions
As the RaspberryMatic project is an open source based project everyone is invited to contribute to this project. Please note, however, that functionality within the corresponding eQ-3 OCCU binaries can not be modified as the main HomeMatic services (rfd, ReGaHSS, HMServer, etc.) are provided in binary format by the [OCCU](https://github.com/eq-3/occu) project and not compiled from sources.

### Development
Building your own RaspberryMatic sd card image is a very straight forward process using this build environment – given that you have sufficient Linux/Unix knowledge and you know what you are actually doing. But if you know what you are doing and which host tools are required to actually be able to run a RaspberryMatic build, it should be as simple as:

```
$ git clone https://github.com/jens-maus/RaspberryMatic
$ cd RaspberryMatic
$ make dist
[wait up to 1h]
$ make install of=/dev/sdX
```

### Using the generated cross compiler
After a successfull build of RaspberryMatic a dedicated cross compiler (`arm-linux-gcc`) should be available within the `build-raspberrypi3` path. You can use this GCC-based cross compiler to compile all kind of third party applications which can then be run within RaspberryMatic:

```
$ cd HelloWorld
$ <path-to-RaspberryMatic-build>/build-raspmatic_rpi3/host/usr/bin/arm-linux-gcc -o HelloWorld HelloWorld.c
```

A valid alternative for building RaspberryMatic ARM-hardfloat compatible binaries is to use the linaro based Linux cross compiler suite supplied [here](https://github.com/raspberrypi/tools/tree/master/arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian).

## License
The RaspberryMatic build environment itself – the files found in this git repository – as well as the RaspberryMatic sd card images are licensed under the conditions of the [Apache License 2.0](https://opensource.org/licenses/Apache-2.0). Please note, however, that the buildroot distribution RaspberryMatic is using is licensed under the [GPLv2](http://www.gnu.org/licenses/gpl-2.0.html) license instead. Furthermore, the [eQ-3 OCCU](https://github.com/eq-3/occu) software RaspberryMatic is using to provide HomeMatic-based services is licensed under the ([HMSL](https://github.com/eq-3/occu/blob/master/LicenseDE.txt)).

## Authors

* Jens Maus
* Wolfgang Willinghöfer
