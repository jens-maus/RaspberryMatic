#############################################################
#
# homematic by eQ-3 
#
#############################################################

HOMEMATIC_OCCU_VERSION = 2.26.x
HOMEMATIC_VERSION = 0bb903aa96351fccdfc67d3ada01f376103f45ed
HOMEMATIC_SITE = $(call github,eq-3,occu,$(HOMEMATIC_VERSION))

HOMEMATIC_MODULE_SUBDIRS = kernel-modules/bcm2835_raw_uart kernel-modules/eq3_char_loop

# HOMEMATIC_DEPENDENCIES = rpi-firmware

# ifeq ($(BR2_PACKAGE_RFD_PLATFORM),"SDK")
#	RFD_DEPENDENCIES += libusb
# endif

ifeq ($(BR2_PACKAGE_HOMEMATIC),y)

define HOMEMATIC_PRE_PATCH
	cp $(HOMEMATIC_PKGDIR)/Makefile $(@D)
	cp -R $(HOMEMATIC_PKGDIR)/kernel-modules $(@D)
endef
HOMEMATIC_PRE_PATCH_HOOKS += HOMEMATIC_PRE_PATCH

define HOMEMATIC_FINALIZE_TARGET
	mkdir -p $(TARGET_DIR)/usr/local/etc/config
	rm -rf $(TARGET_DIR)/etc/config
	ln -snf ../usr/local/etc/config $(TARGET_DIR)/etc/config
	touch $(TARGET_DIR)/usr/local/etc/config/shadow
	rm -f $(TARGET_DIR)/etc/shadow
	ln -snf config/shadow $(TARGET_DIR)/etc/shadow
	rm -f $(TARGET_DIR)/etc/resolv.conf
	ln -snf ../var/etc/resolv.conf $(TARGET_DIR)/etc/resolv.conf
	rm -f $(TARGET_DIR)/etc/init.d/S20urandom
	rm -f $(TARGET_DIR)/etc/init.d/S49ntp
endef
TARGET_FINALIZE_HOOKS += HOMEMATIC_FINALIZE_TARGET

endif

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
		$(MAKE) HOMEMATIC_VERSION=$(HOMEMATIC_OCCU_VERSION) \
			HOMEMATIC_RF_PROTOCOL=$(HOMEMATIC_RF_PROTOCOL) \
			HOMEMATIC_ARCH=$(HOMEMATIC_ARCH) \
			-C $(@D) install 
endef

$(eval $(kernel-module))
$(eval $(generic-package))


