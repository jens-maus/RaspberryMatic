#############################################################
#
# Support for RPI-RF-MOD RF-Module
#
#############################################################

RPI_RF_MOD_VERSION = 2.9.4
RPI_RF_MOD_SITE = $(BR2_EXTERNAL)/package/rpi-rf-mod
RPI_RF_MOD_SITE_METHOD = local

define RPI_RF_MOD_INSTALL_TARGET_CMDS
	cp -a $(@D)/rootfs-overlay/* $(TARGET_DIR)/
endef

$(eval $(generic-package))
