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

## Continous integration

RaspberryMatic uses GitHub Workflows for Continous Integrations. The actions tab shows available workflows.

## Requirements

OCI packages require a secret to be uploaded `CR_PAT`. See GitHub [instructions(https://docs.github.com/en/packages/guides/migrating-to-github-container-registry-for-docker-images#authenticating-with-the-container-registry)] on how to create a Personal Access Token to upload to the GitHub Container Registry.

## Workflows

- **ci**: on each push, pull request or manual - builds all artefacts (dev versions)
- **ci_release**: manually triggered - builds a draft release and attach official builds. Updates OCI and Helm latest tags.
- **nightly-snapshot**: cronjob - only works on official repo (dummy in fork) - uploads all snapshot versions
- **nightly-snapshot**: ??

## How to draft a release

1. Go to _Actions_ -> _Release CI_
2. Click on _Run Workflow_
3. Select the branch. Usually `master`
3. Let the skip build to `false` at least you are testing the CI
4. Click on _Run Workflow_ to start CI. The CI does the following
   - creates a new release draft with the VERSION used as name, tag and version. If the release draft already exists then it is not modified.
   - builds all binaries and upload them to the draft release
   - uploads the container with `latest` as tag - NOTE: after this step OCI users using latest will get the update
   - uploads a new release HElm chart using the OCCU_VERSION as version. NOTE: after this point the Kubernetes users will get presented with the update
5. While the draft is being built, the release readme can be updated from the UI
6. Once the CI has completed and all binaries are uploaded to the release the release can be published

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
