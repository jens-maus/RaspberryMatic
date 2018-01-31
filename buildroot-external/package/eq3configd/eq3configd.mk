#############################################################
#
# Support for EQ3CONFIGD Daemon
#
#############################################################

EQ3CONFIGD_VERSION = 1.0.0
EQ3CONFIGD_SITE = $(BR2_EXTERNAL)/package/eq3configd
EQ3CONFIGD_SITE_METHOD = local

define EQ3CONFIGD_INSTALL_TARGET_CMDS
	cp -a $(@D)/rootfs-overlay/* $(TARGET_DIR)/
endef

$(eval $(generic-package))
