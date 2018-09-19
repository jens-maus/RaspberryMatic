#############################################################
#
# Neo Server
#
#############################################################
NEOSERVER_VERSION = 2.3.1
NEOSERVER_SOURCE =
NEOSERVER_LICENSE = PROPERITARY

define NEOSERVER_INSTALL_TARGET_CMDS
  $(INSTALL) -d -m 0755 $(TARGET_DIR)/opt/mediola/
  cp -a $(NEOSERVER_PKGDIR)/overlay/opt/mediola/ $(TARGET_DIR)/opt/
  $(INSTALL) -D -m 0755 $(NEOSERVER_PKGDIR)/S97NeoServer $(TARGET_DIR)/etc/init.d
  #wget -O $(TARGET_DIR)/opt/mediola/pkg/mediola.tar.gz https://s3-eu-west-1.amazonaws.com/mediola-download/ccu3/neo_server.tar.gz
endef

$(eval $(generic-package))
