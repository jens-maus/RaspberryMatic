# Home Assistant Add-on: RaspberryMatic CCU

HomeMatic/homematicIP CCU central based on [RaspberryMatic](raspberrymatic).

![Supports aarch64 Architecture][aarch64-shield] ![Supports amd64 Architecture][amd64-shield] ![Supports armhf Architecture][armhf-shield] ![Supports armv7 Architecture][armv7-shield] ![Supports i386 Architecture][i386-shield]
[![License](https://img.shields.io/github/license/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/blob/master/LICENSE)
[![Donate](https://img.shields.io/badge/donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=RAQSDY9YNZVCL)
[![Twitter](https://img.shields.io/twitter/follow/RaspberryMatic.svg?style=social&label=Follow)](https://twitter.com/RaspberryMatic)
[![GitHub stars](https://img.shields.io/github/stars/jens-maus/RaspberryMatic.svg?style=social&label=Star)](https://github.com/jens-maus/RaspberryMatic/stargazers/)

## About

This add-on allows to run a [HomeMatic/homematicIP][homematic] control center (CCU) on
your Home Assistant. It is based on [RaspberryMatic][raspberrymatic] which
is open-source and 100% compatible with the homematic vendor ([eQ3][eq3]) own CCU
system (CCU3) to connect to HomeMatic/homematicIP devices cloudless. Furthermore,
it is based on [OCCU][occu] while providing additional exclusive features in the WebUI and
underlying operating system for an improved user experience.

🚧 **WORK-IN-PROGRESS** 🚧<br/>
This add-on tries to provide all features of a standard, e.g. RaspberryPi or OVA-based
RaspberryMatic CCU system. **Please note:** due to the restrictive docker-based nature of
Home Assistant, some of the features require additional operating system modules which
are **not yet** available. This currently limits the HomeMatic/homematicIP connectivity to
the use of the HmIP-RFUSB, HM-LGW-O-TW-W-EU, HM-CFG-USB-2, HM-CFG-LAN and HMW-LGW-O-DR-GS-EU.
Support for e.g. the GPIO-based RF modules (RPI-RF-MOD, HM-MOD-RPI-PCB) is currently under
development.

## Features

- Use your Home Assistant central as a full-fledged HomeMatic/homematicIP control center (CCU).
- Access the CCU WebUI from your Home Assistant user interface.
- Provides all features of a RaspberryMatic system within your Home Assistant environment.
- Interconnect to HomeMatic/homematicIP devices using the standard, vendor-provided RF modules (RPI-RF-MOD, HM-MOD-RPI-PCB, HmIP-RFUSB, HM-CFG-USB-2, HM-CFG-LAN), Wired gateways (HmIPW-DRAP, HMW-LGW-O-DR-GS-EU) or LAN gateway solutions (HmIP-HAP, HM-LGW-O-TW-W-EU) – see [Requirements](https://github.com/jens-maus/RaspberryMatic/wiki/Einleitung#vorraussetzungen).
- Supports additional open-hardware based USB/Ethernet adapter devices (HB-RF-USB, HB-RF-USB-2, HB-RF-ETH).

## Documentation

For a detailed documentation please refer either to the "Documentation" tab of the installed Add-on or
consult the [online documentation](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-HomeAssistant)
available in the RaspberryMatic GitHub project.

## License

This Home Assistant add-on as well as the RaspberryMatic base system is licensed under the Apache-2.0 open-source license.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-no-red.svg
[i386-shield]: https://img.shields.io/badge/i386-no-red.svg
[raspberrymatic]: https://github.com/jens-maus/RaspberryMatic
[occu]: https://github.com/eq-3/occu
[eq3]: https://www.eq-3.com/
[homematic]: https://www.homematic-ip.com/en/start.html
