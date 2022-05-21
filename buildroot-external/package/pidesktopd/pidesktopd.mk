################################################################################
#
# PiDesktop Daemon Support
#
################################################################################

PIDESKTOPD_VERSION = 1.0
PIDESKTOPD_SOURCE =
PIDESKTOPD_LICENSE = Apache-2.0

define PIDESKTOPD_INSTALL_TARGET_CMDS
	cp -a $(PIDESKTOPD_PKGDIR)/rootfs-overlay/* $(TARGET_DIR)/
endef

define PIDESKTOPD_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(PIDESKTOPD_PKGDIR)/S08pidesktopd \
		$(TARGET_DIR)/etc/init.d/S08pidesktopd
endef

$(eval $(generic-package))
