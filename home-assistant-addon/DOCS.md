# Home Assistant Add-on: RaspberryMatic CCU

🚧 **WORK-IN-PROGRESS** 🚧<br/>
This add-on tries to provide all features of a standard, e.g. RaspberryPi or OVA-based
RaspberryMatic CCU system. Please note: due to the partly restrictive docker-based nature of
Home Assistant some of the features require additional operating system modules which
are **not yet** available (e.g. use of the GPIO-based RF modules - RPI-RF-MOD/HM-MOD-RPI-PCB).

## Installation

Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to **Supervisor** -> **Add-on Store**.
2. Click on the vertical "⋮" dots on the top-right corner and select **Repositories**.
3. Add the URL https://github.com/jens-maus/RaspberryMatic as a new add-on repository and click **Close**.
4. Find the "RaspberryMatic CCU" add-on at the bottom and click it.
5. Click on the `INSTALL` button.
6. Install to the sidebar by clicking on `Show in sidebar`
7. Start add-on by clicking on `START`
8. Click on the `RaspberryMatic` sidebar link to switch into the RaspberryMatic WebUI.

More detailed documentation on the installation can be found [here](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-HomeAssistant)

## How to use

After installation you can configure the add-on to add a "RaspberryMatic" link
to the sidebar of your Home Assistant user interface. After having done so, this link can
be used to access the standard RaspberryMatic/CCU WebUI to configure/setup your
HomeMatic/homematicIP devices.

### Setup HomeMatic integration in Home Assistant

After the RaspberryMatic Add-on has been correctly installed and your embedded RaspberryMatic WebUI shows existing HomeMatic/homematicIP devices, you still have to setup the general [HomeMatic integration](https://www.home-assistant.io/integrations/homematic/). Only this step will then bring up/integrate the HomeMatic/homematicIP devices (which the RaspberryMatic Add-on shows) in the general Home Assistant user interface, thus making them usable within Home Assistant.

For this to happen, you have to add the following configuration entries to the `configuration.yaml` file in Home Assistant:

```yaml
homematic:
  interfaces:
    rf:
      host: 5422eb72-raspberrymatic
      port: 2001
      resolvenames: json
      username: Admin
      password: 1234
    wired:
      host: 5422eb72-raspberrymatic
      port: 2000
      resolvenames: json
      username: Admin
      password: 1234
    hmip:
      host: 5422eb72-raspberrymatic
      port: 2010
      resolvenames: json
      username: Admin
      password: 1234
    groups:
      host: 5422eb72-raspberrymatic
      port: 9292
      resolvenames: json
      username: Admin
      password: 1234
      path: /groups
  hosts:
    raspberrymatic:
      host: 5422eb72-raspberrymatic
      username: Admin
      password: 1234
 ```
 
Please note, that the `5422eb72-raspberrymatic` hostname in this example should be replaced by the hostname of the RapberryMatic add-on installed in your Home Assistant. To identify the correct hostname, you can e.g. login to your RaspberryMatic system via SSH and then use the `hostname` command to query for the actual hostname. In addition, please make sure that you have setup the firewall rules in RaspberryMatic itself to either "relaxed mode" or that you added the IP address of the Home Assistant system itself to the allowed ip addresses section.
