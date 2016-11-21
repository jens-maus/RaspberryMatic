#############################################################
#
# CloudMatic/meine-homematic.de support
#
#############################################################
CLOUDMATIC_VERSION = 20160417
CLOUDMATIC_SOURCE =
CLOUDMATIC_SITE =

define CLOUDMATIC_PRE_PATCH
	cp $(CLOUDMATIC_PKGDIR)/Makefile $(@D)
  cp -R $(CLOUDMATIC_PKGDIR)/mh $(@D)
endef

CLOUDMATIC_PRE_PATCH_HOOKS += CLOUDMATIC_PRE_PATCH

define CLOUDMATIC_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) install 
endef

$(eval $(generic-package))
