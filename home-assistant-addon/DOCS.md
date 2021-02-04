# Home Assistant Add-on: RaspberryMatic CCU

🚧 **WORK-IN-PROGRESS** 🚧<br/>
This add-on tries to provide all features of a standard, e.g. RaspberryPi or OVA-based
RaspberryMatic CCU system. Please note: due to the partly restrictive docker-based nature of
Home Assistant some of the features require additional operating system modules which
are **not yet** available (e.g. use of the GPIO-based RF modules - RPI-RF-MOD/HM-MOD-RPI-PCB).

## Installation

Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to **Supervisor** -> **Add-on Store**.
2. Click on the vertical "..." on the top-right corner and select **Repositories**.
3. Add the URL https://github.com/jens-maus/RaspberryMatic as a new add-on repository and click **Close**.
4. Find the "RaspberryMatic CCU" add-on at the bottom and click it.
5. Click on the "INSTALL" button.

## How to use

After installation you can configure the add-on to add a "RaspberryMatic" link
to the sidebar of your Home Assistant user interface. After having done so, this link can
be used to access the standard RaspberryMatic/CCU WebUI to configure/setup your
HomeMatic/homematicIP devices.

More detailed documentation can be found [here](https://github.com/jens-maus/RaspberryMatic/wiki/Installation-HomeAssistant)
