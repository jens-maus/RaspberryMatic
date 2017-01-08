################################################################################
#
# rpi-bt-firmware
#
################################################################################

RPI_BT_FIRMWARE_VERSION = 1.0
RPI_BT_FIRMWARE_SITE = $(BR2_EXTERNAL)/package/rpi-bt-firmware
RPI_BT_FIRMWARE_SITE_METHOD = local
RPI_BT_FIRMWARE_INSTALL_TARGET = YES

define RPI_BT_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/fw/BCM43430A1.hcd $(TARGET_DIR)/lib/firmware/brcm/BCM43430A1.hcd
	$(INSTALL) -D -m 0755 $(@D)/S31bluetooth $(TARGET_DIR)/etc/init.d/S31bluetooth
	$(INSTALL) -D -m 0644 $(@D)/main.conf $(TARGET_DIR)/etc/bluetooth/main.conf
endef

$(eval $(generic-package))
