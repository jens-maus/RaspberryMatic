#############################################################
#
# Support for SSDPD Daemon
#
#############################################################

SSDPD_VERSION = 1.0.0
SSDPD_SITE = $(BR2_EXTERNAL)/package/ssdpd
SSDPD_SITE_METHOD = local

define SSDPD_INSTALL_TARGET_CMDS
	cp -a $(@D)/rootfs-overlay/* $(TARGET_DIR)/
endef

$(eval $(generic-package))
