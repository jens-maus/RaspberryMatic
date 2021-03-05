#############################################################
#
# Neo Server
#
#############################################################
NEOSERVER_VERSION = 2.6.1
NEOSERVER_SOURCE =
NEOSERVER_LICENSE = PROPERITARY

define NEOSERVER_INSTALL_TARGET_CMDS
  $(INSTALL) -d -m 0755 $(TARGET_DIR)/opt/mediola/
  cp -a $(NEOSERVER_PKGDIR)/overlay/* $(TARGET_DIR)/
  echo -n $(NEOSERVER_VERSION) >$(TARGET_DIR)/opt/mediola/VERSION
  mkdir -p $(TARGET_DIR)/opt/mediola/pkg
  (cd $(NEOSERVER_PKGDIR)/pkg; tar --owner=root --group=root -czf $(TARGET_DIR)/opt/mediola/pkg/mediola.tar.gz mediola)
endef

$(eval $(generic-package))
