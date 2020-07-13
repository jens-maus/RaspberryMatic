#############################################################
#
# ArgonONE/FAT GAR Support Daemon
#
#############################################################
ARGONONED_VERSION = 1.0
ARGONONED_SITE = $(BR2_EXTERNAL_EQ3_PATH)/package/argononed
ARGONONED_SITE_METHOD = local
ARGONONED_LICENSE = Apache-2.0

define ARGONONED_INSTALL_TARGET_CMDS
	cp -a $(@D)/rootfs-overlay/* $(TARGET_DIR)/
endef

$(eval $(generic-package))
