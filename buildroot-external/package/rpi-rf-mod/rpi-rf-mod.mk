################################################################################
#
# Meta package for RPI-RF-MOD/HM-MOD-RPI-PCB device support
# for HomeMatic/homematicIP connectivity.
#
# This includes compiling of required device tree overlays for
# selected platforms
#
# Copyright (c) 2018-2023 Jens Maus <mail@jens-maus.de>
# https://github.com/openccu/openccu/tree/master/buildroot-external/package/rpi-rf-mod
#
################################################################################

RPI_RF_MOD_VERSION = 1.13.3
RPI_RF_MOD_SITE = $(BR2_EXTERNAL_EQ3_PATH)/package/rpi-rf-mod
RPI_RF_MOD_SITE_METHOD = local
RPI_RF_MOD_LICENSE = Apache-2.0
RPI_RF_MOD_LICENSE_FILES = LICENSE
RPI_RF_MOD_DEPENDENCIES = host-dtc

ifeq ($(BR2_PACKAGE_RPI_RF_MOD_DTS_RPI),y)
  # RaspberryPi DTS file
  RPI_RF_MOD_DTS_FILE = rpi-rf-mod
  RPI_RF_MOD_DTS_FILE_ALT = rpi-rf-mod-rpi1
else ifeq ($(BR2_PACKAGE_RPI_RF_MOD_DTS_TINKER),y)
  # ASUS Tinkerboard DTS file
  RPI_RF_MOD_DTS_FILE = rpi-rf-mod-tinker
else ifeq ($(BR2_PACKAGE_RPI_RF_MOD_DTS_ODROID_C4),y)
  # ODROID-C4 DTS file
  RPI_RF_MOD_DTS_FILE = rpi-rf-mod-odroid-c4
else ifeq ($(BR2_PACKAGE_RPI_RF_MOD_DTS_ODROID_N2),y)
  # ODROID-N2/N2+ DTS file
  RPI_RF_MOD_DTS_FILE = rpi-rf-mod-odroid-n2
else ifeq ($(BR2_PACKAGE_RPI_RF_MOD_DTS_ODROID_C2),y)
  # ODROID-C2 DTS file
  RPI_RF_MOD_DTS_FILE = rpi-rf-mod-odroid-c2
else ifeq ($(BR2_PACKAGE_RPI_RF_MOD_DTS_YELLOW),y)
  # HomeAssistant Yellow DTS file
  RPI_RF_MOD_DTS_FILE = rpi-rf-mod-yellow
endif

define RPI_RF_MOD_BUILD_CMDS
	if [[ -n "$(RPI_RF_MOD_DTS_FILE)" ]]; then \
		$(HOST_DIR)/bin/dtc -@ -I dts -O dtb -W no-unit_address_vs_reg -o $(@D)/dts/rpi-rf-mod.dtbo $(@D)/dts/$(RPI_RF_MOD_DTS_FILE).dts; \
	fi
	if [[ -n "$(RPI_RF_MOD_DTS_FILE_ALT)" ]]; then \
		$(HOST_DIR)/bin/dtc -@ -I dts -O dtb -W no-unit_address_vs_reg -o $(@D)/dts/$(RPI_RF_MOD_DTS_FILE_ALT).dtbo $(@D)/dts/$(RPI_RF_MOD_DTS_FILE_ALT).dts; \
	fi
endef

define RPI_RF_MOD_INSTALL_TARGET_CMDS
	if [[ -n "$(RPI_RF_MOD_DTS_FILE)" ]]; then \
		$(INSTALL) -D -m 0644 $(@D)/dts/rpi-rf-mod.dtbo $(BINARIES_DIR)/; \
	fi
	if [[ -n "$(RPI_RF_MOD_DTS_FILE_ALT)" ]]; then \
		$(INSTALL) -D -m 0644 $(@D)/dts/$(RPI_RF_MOD_DTS_FILE_ALT).dtbo $(BINARIES_DIR)/; \
	fi
endef

$(eval $(generic-package))
