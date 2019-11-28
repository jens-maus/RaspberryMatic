#############################################################
#
# PiDesktop Daemon Support
#
#############################################################
PIDESKTOPD_VERSION = 1.0
PIDESKTOPD_SITE = $(BR2_EXTERNAL_EQ3_PATH)/package/pidesktopd
PIDESKTOPD_SITE_METHOD = local
PIDESKTOPD_LICENSE = Apache-2.0

define PIDESKTOPD_INSTALL_TARGET_CMDS
	cp -a $(@D)/rootfs-overlay/* $(TARGET_DIR)/
endef

$(eval $(generic-package))
