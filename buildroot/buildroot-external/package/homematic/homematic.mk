#############################################################
#
# homematic by eQ-3 
#
#############################################################
HOMEMATIC_VERSION = 2.19.9
# HOMEMATIC_VERSION = e9b2827153428ee7e5c4fc157a025246bd7fbe9d
HOMEMATIC_SITE = $(call github,eq-3,occu,$(HOMEMATIC_VERSION))

# HOMEMATIC_SITE = $(TOPDIR)/../../../General/Buildroot/Modules/RFD
# HOMEMATIC_SITE_METHOD=local

# HOMEMATIC_PLATFORM=$(call qstrip, $(BR2_PACKAGE_RFD_PLATFORM))


# HOMEMATIC_DEPENDENCIES = rpi-firmware

# ifeq ($(BR2_PACKAGE_RFD_PLATFORM),"SDK")
#	RFD_DEPENDENCIES += libusb
# endif


# define RFD_BUILD_CMDS
#		$(MAKE) -C $(@D) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" CFLAGS="$(TARGET_CFLAGS)" \
#		CROSS="$(TARGET_CROSS)" \
#		TOPDIR="$(TOPDIR)" \
#		PLATFORM="$(RFD_PLATFORM)" \
#		ROMFSDIR=$(TOPDIR)/output/target \
#		PROJECT_DIR="$(TOPDIR)/../../../../Source" base
# endef

# define RFD_INSTALL_TARGET_CMDS
#		$(MAKE) -C $(@D) \
#		CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" \
#		CROSS="$(TARGET_CROSS)" \
#		STRIP="$(TARGET_STRIP)" \
#		TOPDIR="$(TOPDIR)" \
#		ROMFSINST="$(TOPDIR)/../../../../BuildTools/romfs-inst.sh" \
#		ROMFSDIR=$(TOPDIR)/output/target base_install
# endef

$(eval $(generic-package))
