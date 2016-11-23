<img src="https://github.com/jens-maus/RaspberryMatic/raw/master/buildroot-external/package/homematic/logo.png" align=right>
# RaspberryMatic
[![Build Status](https://travis-ci.org/jens-maus/RaspberryMatic.svg?branch=master)](https://travis-ci.org/jens-maus/RaspberryMatic)
[![Code Climate](https://codeclimate.com/github/jens-maus/RaspberryMatic/badges/gpa.svg)](https://codeclimate.com/github/jens-maus/RaspberryMatic)
[![License](http://img.shields.io/:license-gpl2-blue.svg?style=flat)](http://www.gnu.org/licenses/gpl-2.0.html)
[![Github Issues](http://githubbadges.herokuapp.com/jens-maus/RaspberryMatic/issues.svg)](https://github.com/jens-maus/RaspberryMatic/issues)

The RaspberryMatic project is a collaborate effort to provide a [Linux/buildroot](http://buildroot.org/)-based HomeMatic compatible distribution for embedded devices like the [RaspberryPi](https://www.raspberrypi.org/). It is based on the **O**pen-**C**entral-**C**ontrol-**U**nit-SDK ([OCCU](https://github.com/eq-3/occu)) provided by [eQ-3](http://eq-3.de) as part of the [HomeMatic](http://homematic.com/) home automation platform. The RaspberryMatic distribution is provided as a full microSD card image that can be directly flashed and then used in a RaspberryPi as the main operating system for controlling all kind of HomeMatic compatible devices with full compatibility to a CCU2 device directly sold by eQ-3.

## Features
* Fully HomeMatic CCU system compliant supporting latest [OCCU](https://github.com/eq-3/occu) software releases
* Fully self-contained SD card image primarily targeted for RaspberryPi hardware
* Up to date [Buildroot](http://buildroot.org/) environment with speed optimized hard-float support and Linux kernel v4+ versions
* Read-only root file system to minimize write operations on SD card
* Direct support for RTC clock module ([PiFace Shim RTC](http://www.piface.org.uk/products/piface_clock/))
* Hardware WatchDog support automatically rebooting the system upon hardware problems

## Limitations
* No HomeMatic-IP support yet (Work in Progress!)
* Updates require complete Backup/Restore procedure
* adapted HomeMatic CCU Addon packages required (CCU2 versions don't work)

## Requirements
* [RaspberryPi 3](http://www.elv.de/raspberry-pi-3-1-gb.html)
* microSD card (4GB minimum)
* HomeMatic GPIO hardware module ([HM-MOD-RPI-PCB](http://www.elv.de/homematic-funkmodul-fuer-raspberry-pi-bausatz.html))

## License
RaspberryMatic uses different software products that are all distributed under different license models. The following list summarizes which parts of RaspberryMatic are using which license:

* buildroot environment ([GPLv2+](http://www.gnu.org/licenses/gpl-2.0.html))
* eQ-3 OCCU ([HMSL](https://github.com/eq-3/occu/blob/master/LicenseDE.txt))

To summarize, the build environment found here (including buildroot itself) is licensed under the [GPLv2+](http://www.gnu.org/licenses/gpl-2.0.html) license while the eQ-3 OCCU binaries that are directly obtained from the OCCU github repository are licensed under a properitary so-called [HMSL](https://github.com/eq-3/occu/blob/master/LicenseDE.txt) license.

## Contributions
As the RaspberryMatic project is an open source based project everyone is invited to contribute to this project. Please note, however, that functionality within the corresponding eQ-3 OCCU binaries can not be modified as the main HomeMatic services (rfd, ReGaHSS, HMServer, etc.) are only provided in binary format by the [OCCU](https://github.com/eq-3/occu) project.

## Authors

* Jens Maus
* Wolfgang Willinghöfer

## ChangeLog / Roadmap

* 2.25.15-XXXXXXXX (beta – Not yet released)
  * HomeMatic-CCU 2.25.15 compatibility
  * working Backup / Restore / Factory-Reset
  * finalized Filesystem structure (read-only root file system)
  * working addon install/removal routines
  * implemented boot splash screen
  * implemented hardware watchdog support
  * ntpd is used as a network time protocol (NTP) daemon

* 2.21.10-20160821 (alpha)
  * First development version. There are still broken features like filesystem structure (readonly root file system), backup, restore, install extensions..., but it's possible to teach-in and controll HomeMatic RF devices.
