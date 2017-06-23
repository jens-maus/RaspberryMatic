#############################################################
#
# S.USV Support (www.s-usv.de)
#
#############################################################
SUSVD_VERSION = 2.2
SUSVD_SOURCE =
SUSVD_SITE =
SUSVD_LICENSE = PROPERITARY

define SUSVD_PRE_PATCH
	cp -a $(SUSVD_PKGDIR)/opt $(@D)
endef
SUSVD_PRE_PATCH_HOOKS += SUSVD_PRE_PATCH

define SUSVD_INSTALL_TARGET_CMDS
	cp -a $(@D)/opt/susvd $(TARGET_DIR)/opt/
endef

$(eval $(generic-package))
