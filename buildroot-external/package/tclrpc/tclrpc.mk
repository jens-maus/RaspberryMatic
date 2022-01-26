################################################################################
#
# eQ-3 char loopback kernel module for HomeMatic/homematicIP
# dual stack implementations for the RPI-RF-MOD/HM-MOD-RPI-PCB
#
# Copyright (c) 2015 by eQ-3 Entwicklung GmbH
# https://github.com/eq-3/occu/blob/master/CCU2/download/tclrpc-eQ-3.tar.gz
#
################################################################################

TCLRPC_VERSION = 1.1
TCLRPC_SITE = $(BR2_EXTERNAL_EQ3_PATH)/package/tclrpc
TCLRPC_SITE_METHOD = local
TCLRPC_LICENSE = Apache2

define TCLRPC_BUILD_CMDS
	$(MAKE) CXX="$(TARGET_CXX)" LD="$(TARGET_LD)" CXXFLAGS="$(TARGET_CXXFLAGS)" -C $(@D) all
endef

#define TCLRPC_INSTALL_TARGET_CMDS
#	$(INSTALL) -D -m 0755 $(@D)/hmlangw $(TARGET_DIR)/bin
#	$(INSTALL) -D -m 0755 $(@D)/S61hmlangw $(TARGET_DIR)/etc/init.d
#endef

$(eval $(generic-package))
