#############################################################
#
# homematic by eQ-3 
#
#############################################################
# HOMEMATIC_VERSION = 2.21.10
HOMEMATIC_VERSION = 5d1fb3d4eb1831c02b457a369096021252e0518e
HOMEMATIC_SITE = $(call github,eq-3,occu,$(HOMEMATIC_VERSION))

# HOMEMATIC_SITE = $(TOPDIR)/../../../General/Buildroot/Modules/RFD
# HOMEMATIC_SITE_METHOD=local

# HOMEMATIC_PLATFORM=$(call qstrip, $(BR2_PACKAGE_RFD_PLATFORM))


# HOMEMATIC_DEPENDENCIES = rpi-firmware

# ifeq ($(BR2_PACKAGE_RFD_PLATFORM),"SDK")
#	RFD_DEPENDENCIES += libusb
# endif

define HOMEMATIC_PRE_PATCH
	cp $(HOMEMATIC_PKGDIR)/Makefile $(@D)
endef

HOMEMATIC_PRE_PATCH_HOOKS += HOMEMATIC_PRE_PATCH



define HOMEMATIC_INSTALL_TARGET_CMDS
		$(MAKE) HOMEMATIC_VERSION=$(HOMEMATIC_VERSION) \
			-C $(@D) install 
endef

$(eval $(generic-package))
