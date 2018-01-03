#############################################################
#
# S.USV Support (www.s-usv.de)
#
#############################################################
SUSVD_VERSION = 2.33
SUSVD_SOURCE =
SUSVD_SITE =
SUSVD_LICENSE = PROPERITARY

define SUSVD_PRE_PATCH
	cp -a $(SUSVD_PKGDIR)/opt $(@D)
	cp -a $(SUSVD_PKGDIR)/etc $(@D)
endef
SUSVD_PRE_PATCH_HOOKS += SUSVD_PRE_PATCH

define SUSVD_INSTALL_TARGET_CMDS
	cp -a $(@D)/opt/susvd $(TARGET_DIR)/opt/
	cp -a $(@D)/etc/init.d/S51susvd $(TARGET_DIR)/etc/init.d/
endef

$(eval $(generic-package))
