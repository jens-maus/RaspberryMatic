################################################################################
#
# PiUSV+ Support
#
################################################################################

PIUSVD_VERSION = 0.9
PIUSVD_SOURCE =
PIUSVD_LICENSE = PROPERITARY

define PIUSVD_INSTALL_TARGET_CMDS
	cp -a $(PIUSVD_PKGDIR)/rootfs-overlay/* $(TARGET_DIR)/
endef

define PIUSVD_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(PIUSVD_PKGDIR)/S51piusvd \
		$(TARGET_DIR)/etc/init.d/S51piusvd
endef

$(eval $(generic-package))
