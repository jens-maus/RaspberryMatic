#############################################################
#
# PiUSV+ Support
#
#############################################################
PIUSVD_VERSION = 0.9
PIUSVD_SITE = $(BR2_EXTERNAL_EQ3_PATH)/package/piusvd
PIUSVD_SITE_METHOD = local
PIUSVD_LICENSE = PROPERITARY

define PIUSVD_INSTALL_TARGET_CMDS
	cp -a $(@D)/rootfs-overlay/* $(TARGET_DIR)/
endef

$(eval $(generic-package))
