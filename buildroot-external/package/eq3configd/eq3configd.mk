################################################################################
#
# Support for eq3configd Daemon
#
################################################################################

EQ3CONFIGD_VERSION = 1.0.0
EQ3CONFIGD_SOURCE =
EQ3CONFIGD_LICENSE = Apache-2.0

define EQ3CONFIGD_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(EQ3CONFIGD_PKGDIR)/S50eq3configd \
		$(TARGET_DIR)/etc/init.d/S50eq3configd
endef

$(eval $(generic-package))
