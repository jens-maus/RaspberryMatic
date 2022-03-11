################################################################################
#
# ArgonONE/FAT Support Daemon
#
################################################################################

ARGONONED_VERSION = 1.1
ARGONONED_SOURCE =
ARGONONED_LICENSE = Apache-2.0

define ARGONONED_INSTALL_TARGET_CMDS
	cp -a $(ARGONONED_PKGDIR)/rootfs-overlay/* $(TARGET_DIR)/
endef

define ARGONONED_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(ARGONONED_PKGDIR)/S08argononed \
		$(TARGET_DIR)/etc/init.d/S08argononed
endef

$(eval $(generic-package))
