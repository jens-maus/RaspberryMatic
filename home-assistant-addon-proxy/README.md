# Home Assistant Add-on: RaspberryMatic Proxy

![Supports aarch64 Architecture][aarch64-shield] ![Supports amd64 Architecture][amd64-shield] ![Supports armhf Architecture][armhf-shield] ![Supports armv7 Architecture][armv7-shield] ![Supports i386 Architecture][i386-shield]
[![License](https://img.shields.io/github/license/jens-maus/RaspberryMatic.svg)](https://github.com/jens-maus/RaspberryMatic/blob/master/LICENSE)
[![Donate](https://img.shields.io/badge/donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=RAQSDY9YNZVCL)
[![GitHub stars](https://img.shields.io/github/stars/jens-maus/RaspberryMatic.svg?style=social&label=Star)](https://github.com/jens-maus/RaspberryMatic/stargazers/)

## About

⚠️ This add-on does NOT provide a full RaspberryMatic system ⚠️

It acts as a web proxy to an external running [RaspberryMatic](raspberrymatic) CCU instance. Thus, the sole purpose of this add-on is to add a RaspberryMatic icon to the sidebar of Home Assistant which will open the frontend of an external running RaspberryMatic instance so that it can be accessed from within HA.

## Documentation / Installation

In addition to installing this HA add-on you will have to set some mandatory add-on options to link against an external RaspberryMatic CCU WebUI:

- `webui-url` (required): the URL on which the external RaspberryMatic CCU WebUI is accessible, e.g. `http://192.168.2.43`.

In addition, you have to make sure that your HA system is able to directly access the RaspberryMatic CCU WebUI. Thus, if you have the internal firewall system of your RaspberryMatic system enabled, make sure to add the ip adress of your HA system to these firewall settings.

## License

This Home Assistant add-on as well as RaspberryMatic is licensed under the Apache-2.0 open-source license.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[armhf-shield]: https://img.shields.io/badge/armhf-no-red.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[i386-shield]: https://img.shields.io/badge/i386-no-red.svg
[raspberrymatic]: https://github.com/jens-maus/RaspberryMatic
