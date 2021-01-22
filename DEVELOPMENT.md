# Development guide

## How to build
The fastest and recommended way to develop is using a local [Visual Studio Code](https://code.visualstudio.com/) dev environment. This repository contains a dev container setup for VS Code with all required development tools to build Raspberrymatic.

1. Please follow the instructions to download and install the [Remote Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) VS Code extension.
2. Open the root folder inside VS Code, and when prompted re-open the window inside the container (or, from the Command Palette, select 'Rebuild and Reopen in Container').
3. Follow one of the subsections bellow depending on what component you want to build

### Building Raspberrymatic images

1. When VS Code has opened your folder in the container (which can take some time for the first run) you will need to start a terminal (Terminal -> New Terminal).
2. Use `make` to build any of the Raspberrymatic. If you run `make`without targets the list of available commands is printed.

### Building and testing the Home Assistant Add-on

1. When VS Code has opened your folder in the container (which can take some time for the first run) you'll need to run the task (Terminal -> Run Task) 'Start Home Assistant', which will bootstrap Supervisor and Home Assistant. 
2. You'll then be able to access the normal onboarding process via the Home Assistant instance at `http://localhost:7123/`.
3. The add-on(s) found in your root folder will automatically be found in the Local Add-ons repository.
4. Install the Raspberrymatic from the supervisord menu.
5. Once installed you need to start the adapter.
6. It is usefull to enable the `Show in sidebar` so you can open the Raspberrymatic UI (NOTE: you might need to wait some seconds until it is available).

## Components Update Guide

This short documentation serves as a quick-guide to which and from where components should be update on a regular basis.

- Buildroot:
  https://buildroot.org/

- Java-AZUL:
  https://www.azul.com/downloads/zulu-embedded/

- CloudMatic Addon:
  https://github.com/EasySmartHome/CloudMatic-CCUAddon

- RaspberryPi Linux Kernel:
  https://github.com/raspberrypi/linux/

- ASUS Tinkerboard Kernel Patches (Armbian):
  https://github.com/armbian/build/tree/master/patch/kernel/rockchip-current
  
- CodeMirror WebUI Script Editor Engine:
  https://codemirror.net/

- S.USV Support-Tools:
  https://s-usv.de/downloads/

- generic_raw_uart/HB-RF-USB/HB-RF-USB-2/HB-RF-ETH driver:
  https://github.com/alexreinert/piVCCU/tree/master/kernel

- detect_radio_module tool:
  https://github.com/alexreinert/piVCCU/tree/master/detect_radio_module
