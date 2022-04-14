################################################################################
#
# StromPi2 UPS Support (https://www.joy-it.net/de/products/RB-StromPi2)
#
################################################################################

STROMPI2D_VERSION = 1.1
STROMPI2D_SOURCE =
STROMPI2D_LICENSE = Apache-2.0

define STROMPI2D_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt/strompi2d
	$(INSTALL) -D -m 0755 $(STROMPI2D_PKGDIR)/strompi2d.sh $(TARGET_DIR)/opt/strompi2d/strompi2d.sh
endef

define STROMPI2D_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(STROMPI2D_PKGDIR)/S51strompi2d \
		$(TARGET_DIR)/etc/init.d/S51strompi2d
endef

$(eval $(generic-package))
