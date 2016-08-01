#############################################################
#
# homematic by eQ-3 
#
#############################################################
HOMEMATIC_VERSION = 2.21.10
# HOMEMATIC_VERSION = e9b2827153428ee7e5c4fc157a025246bd7fbe9d
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
		$(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
