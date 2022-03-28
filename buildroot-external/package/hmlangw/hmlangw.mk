################################################################################
#
# hmlangw - http://homematic-forum.de/forum/viewtopic.php?f=18&t=27705
#
################################################################################

HMLANGW_VERSION = 0.0.2
HMLANGW_SITE = $(BR2_EXTERNAL_EQ3_PATH)/package/hmlangw
HMLANGW_SITE_METHOD = local
HMLANGW_LICENSE = Apache-2.0
HMLANGW_LICENSE_FILES = LICENSE

define HMLANGW_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" CFLAGS="$(TARGET_CFLAGS)" -C $(@D) all
endef

define HMLANGW_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/hmlangw $(TARGET_DIR)/bin
endef

define HMLANGW_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(HMLANGW_PKGDIR)/S61hmlangw \
		$(TARGET_DIR)/etc/init.d/S61hmlangw
endef

$(eval $(generic-package))
