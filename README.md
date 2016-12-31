<img src="https://github.com/jens-maus/RaspberryMatic/raw/master/buildroot-external/package/homematic/logo.png" align=right>
# RaspberryMatic
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=RAQSDY9YNZVCL)
[![Build Status](https://travis-ci.org/jens-maus/RaspberryMatic.svg?branch=master)](https://travis-ci.org/jens-maus/RaspberryMatic)
[![Code Climate](https://codeclimate.com/github/jens-maus/RaspberryMatic/badges/gpa.svg)](https://codeclimate.com/github/jens-maus/RaspberryMatic)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Github Issues](http://githubbadges.herokuapp.com/jens-maus/RaspberryMatic/issues.svg)](https://github.com/jens-maus/RaspberryMatic/issues)

The RaspberryMatic project is a collaborate effort to provide a [Linux/buildroot](http://buildroot.org/)-based HomeMatic compatible distribution for embedded devices like the [RaspberryPi](https://www.raspberrypi.org/). It is based on the **O**pen-**C**entral-**C**ontrol-**U**nit-SDK ([OCCU](https://github.com/eq-3/occu)) provided by [eQ-3](http://eq-3.de) as part of the [HomeMatic](http://homematic.com/) home automation platform. The RaspberryMatic distribution is provided as a full microSD card image that can be directly flashed and then used in a RaspberryPi as the main operating system for controlling all kind of HomeMatic compatible devices with full compatibility to a CCU2 device directly sold by eQ-3.

## Features
* Fully HomeMatic CCU system compliant supporting latest [OCCU](https://github.com/eq-3/occu) software releases
* Full BidCos-RF (HomeMatic), Wired (HomeMatic-Wired) and HmIP-RF (HomeMatic-IP) compatibility
* Self-contained SD card image primarily targeted for RaspberryPi hardware
* Up to date [Buildroot](http://buildroot.org/) 2016.XX Linux environment
* Linux kernel v4.4.x with hard-float support for RaspberryPi2/3 platform 
* Low-Latency Linux kernel support (`PREEMPT`) to reduce kernel latency
* Read-only root file system to minimize write operations on SD card
* Auto-resizing `/usr/local` partition to use the full space of the SD card
* Direct support for RTC clock modules ([PiFace Shim RTC](http://www.piface.org.uk/products/piface_clock/), [DS3231](https://thepihut.com/products/mini-rtc-module-for-raspberry-pi))
* Hardware WatchDog support automatically rebooting the system upon hardware problems
* Direct CloudMatic (meine-homematic.de) support
* Build Environment creates a dedicated cross compiler (`arm-linux-gcc`) to compile third-party applications

## Limitations
* No HomeMatic-IP (HmIP-RF) support for RaspberryPi3 (Work in Progress, see [#30](https://github.com/jens-maus/RaspberryMatic/issues/30))
* HmIP-RF devices have to be reteached after Config restore from CCU2 (Limitation of HmIP)
* Updates require complete Backup/Reinstall/Restore procedure
* Special HomeMatic CCU Addon packages required (CCU2 versions don't work)
* No WiFi or Bluetooth support (yet) with RaspberryPi3

## Requirements
* [RaspberryPi3](https://www.raspberrypi.org/products/raspberry-pi-3-model-b/) or [RaspberryPi2](https://www.raspberrypi.org/products/raspberry-pi-2-model-b)
* microSD card (2GB minimum)
* HomeMatic-RF GPIO radio module ([HM-MOD-RPI-PCB](http://www.elv.de/homematic-funkmodul-fuer-raspberry-pi-bausatz.html))

## Compatible Third-Party Addons
The CCU platform allows to enhance the functionality of a CCU by installing so-called Addon packages. For RaspberryMatic, standard CCU-Addon packages won't work because included binaries have to be recompiled for the hard-float buildroot environment RaspberryMatic uses. Here is a list of well-known already compatible Addon packages (please note that this list might be incomplete):

* [CUxD](https://github.com/jens-maus/cuxd)
* [XML-API](https://github.com/jens-maus/XML-API)
* [hm_pdetect](https://github.com/jens-maus/hm_pdetect)
* [Email-Addon](https://github.com/jens-maus/hm_email)
* [CUxD-Highcharts](https://github.com/hobbyquaker/CUxD-Highcharts)
* [HQ-WebUI](https://github.com/jens-maus/hq-webui)
* [DB-Access](https://github.com/jens-maus/dbaccess)
* [QuickAccess](https://github.com/jens-maus/quickaccess)
* [Script-Parser](https://github.com/jens-maus/scriptparser)
* [WebMatic](https://github.com/ldittmar81/webmatic)
* [Sonos Player](https://github.com/jens-maus/hm-sonos)
* [hm2mqtt](https://github.com/owagner/hm2mqtt)
* [CCU-Historian](https://github.com/jens-maus/hm-ccu-historian)
* [Watchdog](https://github.com/jens-maus/hm-watchdog)

## Installation
The installation of RaspberryMatic is quite straight forward as it is delivered as a full SD card image that can be directly flashed onto a microSD card and put into the corresponding RaspberryPi. As such the installation consists of the following basic steps:

1. Download latest release archive (`RaspberryMatic-X.XX.XX.YYYYMMDD.zip`) from [here](https://github.com/jens-maus/RaspberryMatic/releases)
2. Unarchive zip file resulting in an SD card image (`RaspberryMatic-X.XX.XX.YYYYMMDD.img`)
3. Based on your operating system use a Flash-tool to copy the image onto your microSD card:
  * <i>Linux</i>: `sudo dd if=RaspberryMatic-X.XX.XX.YYYYMMDD.img of=/dev/sdX bs=4096`
  * <i>macOS</i>: Use [ApplePiBaker](http://www.tweaking4all.com/hardware/raspberry-pi/macosx-apple-pi-baker/)
  * <i>Windows</i>: Use [Win32DiskImager](https://sourceforge.net/projects/win32diskimager/)
4. Make sure you have the HM-MOD-RPI-PCB radio modul installed on the GPIO of your RaspberryPi
4. Install microSD in your RaspberryPi and start it
5. Wait until bootup process is finished and use a web browser to connect to http://homematic-raspi/
 
## Contributions
As the RaspberryMatic project is an open source based project everyone is invited to contribute to this project. Please note, however, that functionality within the corresponding eQ-3 OCCU binaries can not be modified as the main HomeMatic services (rfd, ReGaHSS, HMServer, etc.) are provided in binary format by the [OCCU](https://github.com/eq-3/occu) project and not compiled from sources.

### Development
Building your own RaspberryMatic sd card image is a very straight forward process using this build environment – given that you have sufficient Linux/Unix knowledge and you know what you are actually doing. But if you know what you are doing and which host tools are required to actually be able to run a RaspberryMatic build, it should be as simple as:

```
$ git clone https://github.com/jens-maus/RaspberryMatic
$ cd RaspberryMatic
$ make dist
```

### Using the generated cross compiler
After a successfull build of RaspberryMatic a dedicated cross compiler (`arm-linux-gcc`) should be available within the `build-raspberrypi3` path. You can use this GCC-based cross compiler to compile all kind of third party applications which can then be run within RaspberryMatic:

```
$ cd HelloWorld
$ <path-to-RaspberryMatic-build>/build-raspberrypi3/host/usr/bin/arm-linux-gcc -o HelloWorld HelloWorld.c
```

## License
The RaspberryMatic build environment itself – the files found in this git repository – as well as the RaspberryMatic sd card images are licensed under the conditions of the [Apache License 2.0](https://opensource.org/licenses/Apache-2.0). Please note, however, that the buildroot distribution RaspberryMatic is using is licensed under the [GPLv2](http://www.gnu.org/licenses/gpl-2.0.html) license instead. Furthermore, the [eQ-3 OCCU](https://github.com/eq-3/occu) software RaspberryMatic is using to provide HomeMatic-based services is licensed under the ([HMSL](https://github.com/eq-3/occu/blob/master/LicenseDE.txt)).

## Authors

* Jens Maus
* Wolfgang Willinghöfer
