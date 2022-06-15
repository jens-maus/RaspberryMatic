################################################################################
#
# Mediola Neo Server
#
################################################################################

NEOSERVER_VERSION = 2.10.0
NEOSERVER_SOURCE =
NEOSERVER_LICENSE = PROPERITARY

define NEOSERVER_INSTALL_TARGET_CMDS
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/opt/mediola/
	cp -a $(NEOSERVER_PKGDIR)/overlay/* $(TARGET_DIR)/
	echo -n $(NEOSERVER_VERSION) >$(TARGET_DIR)/opt/mediola/VERSION
	mkdir -p $(TARGET_DIR)/opt/mediola/pkg
	(cd $(NEOSERVER_PKGDIR)/pkg; tar --owner=root --group=root -czf $(TARGET_DIR)/opt/mediola/pkg/mediola.tar.gz mediola)
endef

define NEOSERVER_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(NEOSERVER_PKGDIR)/S97NeoServer \
		$(TARGET_DIR)/etc/init.d/S97NeoServer
endef

$(eval $(generic-package))
