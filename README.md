# RaspberryMatic
<img src="https://github.com/jens-maus/RaspberryMatic/raw/master/buildroot-external/package/homematic/logo.png" align=right>
[![Build Status](https://travis-ci.org/jens-maus/RaspberryMatic.svg?branch=master)](https://travis-ci.org/jens-maus/RaspberryMatic)
[![Github Issues](http://githubbadges.herokuapp.com/jens-maus/RaspberryMatic/issues.svg)](https://github.com/jens-maus/RaspberryMatic/issues)

A collaborate effort to create an open sourced HomeMatic-aware distribution for the RaspberryPi platform based on buildroot.

## WARNING
This repository is Work-in-Progress and not yet ment to provide a productive HomeMatic-compatible distribution for the RaspberryPi

## ChangeLog

* 2.25.14-XXXXXXXX (beta – Not yet released)
  * HomeMatic-CCU 2.25.14 compatibility
  * working Backup / Restore / Factory-Reset
  * finalized Filesystem structure (read-only root file system)
  * working addon install/removal routines

* 2.21.10-20160821 (alpha)
  * First development version. There are still broken features like filesystem structure (readonly root file system), backup, restore, install extensions..., but it's possible to teach-in and controll HomeMatic RF devices.
