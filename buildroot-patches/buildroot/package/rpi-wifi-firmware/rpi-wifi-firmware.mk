################################################################################
#
# rpi-wifi-firmware
#
################################################################################

RPI_WIFI_FIRMWARE_VERSION = 86e88fbf0345da49555d0ec34c80b4fbae7d0cd3
# brcmfmac43430-sdio.bin comes from linux-firmware
RPI_WIFI_FIRMWARE_SOURCE = brcmfmac43430-sdio.txt brcmfmac43455-sdio.txt
# git repo contains a lot of unrelated files
RPI_WIFI_FIRMWARE_SITE = https://raw.githubusercontent.com/RPi-Distro/firmware-nonfree/$(RPI_WIFI_FIRMWARE_VERSION)/brcm
RPI_WIFI_FIRMWARE_LICENSE = PROPRIETARY

define RPI_WIFI_FIRMWARE_EXTRACT_CMDS
	for file in $($(PKG)_SOURCE); do \
		cp $(DL_DIR)/$${file} $(@D)/; \
	done
endef

define RPI_WIFI_FIRMWARE_INSTALL_TARGET_CMDS
	for file in $(RPI_WIFI_FIRMWARE_SOURCE); do \
	  $(INSTALL) -D -m 0644 $(@D)/$${file} $(TARGET_DIR)/lib/firmware/brcm/${file}; \
	done
endef

$(eval $(generic-package))
