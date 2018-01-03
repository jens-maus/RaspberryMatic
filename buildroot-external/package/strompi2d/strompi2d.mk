#############################################################
#
# StromPi2 UPS Support (http://www.joy-it.net/strompi-2/)
#
#############################################################
STROMPI2D_VERSION = 1.0
STROMPI2D_SOURCE =
STROMPI2D_SITE =
STROMPI2D_LICENSE = GPL3

define STROMPI2D_PRE_PATCH
	cp -a $(STROMPI2D_PKGDIR)/S51strompi2d $(@D)
	cp -a $(STROMPI2D_PKGDIR)/strompi2d.sh $(@D)
endef
STROMPI2D_PRE_PATCH_HOOKS += STROMPI2D_PRE_PATCH

define STROMPI2D_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt/strompi2d
	cp -a $(@D)/strompi2d.sh $(TARGET_DIR)/opt/strompi2d/
	cp -a $(@D)/S51strompi2d $(TARGET_DIR)/etc/init.d/
endef

$(eval $(generic-package))
