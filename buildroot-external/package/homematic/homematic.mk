#############################################################
#
# homematic by eQ-3 
#
#############################################################

HOMEMATIC_VERSION = 2.21.10
#HOMEMATIC_OCCU_BRANCH = $(HOMEMATIC_OCCU_BRANCH)
HOMEMATIC_OCCU_BRANCH = 28045df83480122f90ab92f7c6e625f9bf3b61aa
HOMEMATIC_SITE = $(call github,eq-3,occu,$(HOMEMATIC_OCCU_BRANCH))

HOMEMATIC_MODULE_SUBDIRS = kernel-modules/bcm2835_raw_uart kernel-modules/eq3_char_loop

# HOMEMATIC_DEPENDENCIES = rpi-firmware

# ifeq ($(BR2_PACKAGE_RFD_PLATFORM),"SDK")
#	RFD_DEPENDENCIES += libusb
# endif

define HOMEMATIC_PRE_PATCH
	cp $(HOMEMATIC_PKGDIR)/Makefile $(@D)
	cp -R $(HOMEMATIC_PKGDIR)/kernel-modules $(@D)
endef

HOMEMATIC_PRE_PATCH_HOOKS += HOMEMATIC_PRE_PATCH

ifeq ($(BR2_PACKAGE_HOMEMATIC_RF_PROTOCOL_HM_ONLY),y) 
	HOMEMATIC_RF_PROTOCOL=HM
endif

ifeq ($(BR2_PACKAGE_HOMEMATIC_RF_PROTOCOL_HMIP_ONLY),y) 
	HOMEMATIC_RF_PROTOCOL=HMIP
endif

ifeq ($(BR2_PACKAGE_HOMEMATIC_RF_PROTOCOL_HM_HMIP),y) 
	HOMEMATIC_RF_PROTOCOL=HM_HMIP
endif

ifeq ($(BR2_PACKAGE_HOMEMATIC_ARCH_ARM),y) 
	HOMEMATIC_ARCH=arm-gnueabihf
endif

ifeq ($(BR2_PACKAGE_HOMEMATIC_ARCH_X86_32),y) 
	HOMEMATIC_ARCH=X86_32_Debian_Wheezy
endif

define HOMEMATIC_INSTALL_TARGET_CMDS
		$(MAKE) HOMEMATIC_VERSION=$(HOMEMATIC_VERSION) \
			HOMEMATIC_RF_PROTOCOL=$(HOMEMATIC_RF_PROTOCOL) \
			HOMEMATIC_ARCH=$(HOMEMATIC_ARCH) \
			-C $(@D) install 
endef

$(eval $(kernel-module))
$(eval $(generic-package))
