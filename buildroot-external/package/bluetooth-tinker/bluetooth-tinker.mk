#############################################################
#
# Support for Bluetooth for the ASUS Tinkerboard
#
#############################################################

BLUETOOTH_TINKER_VERSION = 1.0.0
BLUETOOTH_TINKER_SITE = $(BR2_EXTERNAL_EQ3_PATH)/package/bluetooth-tinker
BLUETOOTH_TINKER_SITE_METHOD = local

define BLUETOOTH_TINKER_INSTALL_TARGET_CMDS
	cp -a $(@D)/rootfs-overlay/* $(TARGET_DIR)/
endef

$(eval $(generic-package))
