################################################################################
#
# Support for SSDPD Daemon
#
################################################################################

SSDPD_VERSION = 1.0.0
SSDPD_SOURCE =
SSDPD_LICENSE = Apache-2.0

define SSDPD_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(SSDPD_PKGDIR)/S50ssdpd \
		$(TARGET_DIR)/etc/init.d/S50ssdpd
endef

$(eval $(generic-package))
