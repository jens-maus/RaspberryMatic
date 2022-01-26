################################################################################
#
# Implementation of XmlRpc protocol (libXmlRpc++)
#
# https://github.com/eq-3/occu/blob/master/CCU2/download/xmlrpc-eQ-3.tar.gz
#
################################################################################

LIBXMLRPCXX_VERSION = 0.7
LIBXMLRPCXX_SITE = $(BR2_EXTERNAL_EQ3_PATH)/package/libxmlrpcxx
LIBXMLRPCXX_SITE_METHOD = local
LIBXMLRPCXX_LICENSE = LGPL-2.1

define LIBXMLRPCXX_BUILD_CMDS
	$(MAKE) CXX="$(TARGET_CXX)" LD="$(TARGET_LD)" AR="$(TARGET_AR)" CXXFLAGS="$(TARGET_CXXFLAGS)" LDFLAGS="$(TARGET_LDFLAGS)" STRIP="$(TARGET_STRIP)" -C $(@D) all
endef

#define TCLRPC_INSTALL_TARGET_CMDS
#	$(INSTALL) -D -m 0755 $(@D)/hmlangw $(TARGET_DIR)/bin
#	$(INSTALL) -D -m 0755 $(@D)/S61hmlangw $(TARGET_DIR)/etc/init.d
#endef

$(eval $(generic-package))
