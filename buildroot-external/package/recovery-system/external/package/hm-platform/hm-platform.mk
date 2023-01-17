#############################################################
#
# HomeMatic platform support package to add necessary
# binaries for the recovery system only.
#
#############################################################

HM_PLATFORM_VERSION = $(OCCU_VERSION)
HM_PLATFORM_SITE = $(call github,jens-maus,occu,$(OCCU_VERSION))

ifeq ($(BR2_arm),y)
	HM_PLATFORM_ARCH=arm-gnueabihf-gcc8
endif

ifeq ($(BR2_aarch64),y)
	HM_PLATFORM_ARCH=arm-gnueabihf-gcc8
endif

ifeq ($(BR2_i386),y)
	HM_PLATFORM_ARCH=X86_32_GCC8
endif

ifeq ($(BR2_x86_64),y)
	HM_PLATFORM_ARCH=X86_32_GCC8
endif

define HM_PLATFORM_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/$(HM_PLATFORM_ARCH)/packages-eQ-3/LinuxBasis/bin/ssdpd $(TARGET_DIR)/bin/ssdpd
	$(INSTALL) -D -m 0755 $(@D)/$(HM_PLATFORM_ARCH)/packages-eQ-3/LinuxBasis/bin/eq3configcmd $(TARGET_DIR)/bin/eq3configcmd
	$(INSTALL) -D -m 0755 $(@D)/$(HM_PLATFORM_ARCH)/packages-eQ-3/LinuxBasis/bin/eq3configd $(TARGET_DIR)/bin/eq3configd
	$(INSTALL) -D -m 0755 $(@D)/$(HM_PLATFORM_ARCH)/packages-eQ-3/LinuxBasis/lib/libeq3config.so $(TARGET_DIR)/lib/libeq3config.so
	$(INSTALL) -D -m 0755 $(@D)/$(HM_PLATFORM_ARCH)/packages-eQ-3/RFD/bin/crypttool $(TARGET_DIR)/bin/crypttool
	$(INSTALL) -D -m 0755 $(@D)/$(HM_PLATFORM_ARCH)/packages-eQ-3/RFD/lib/libLanDeviceUtils.so $(TARGET_DIR)/lib/libLanDeviceUtils.so
	$(INSTALL) -D -m 0755 $(@D)/$(HM_PLATFORM_ARCH)/packages-eQ-3/RFD/lib/libUnifiedLanComm.so $(TARGET_DIR)/lib/libUnifiedLanComm.so
	$(INSTALL) -D -m 0755 $(@D)/$(HM_PLATFORM_ARCH)/packages-eQ-3/RFD/lib/libelvutils.so $(TARGET_DIR)/lib/libelvutils.so
	cp -a $(HM_PLATFORM_PKGDIR)/rootfs-overlay/* $(TARGET_DIR)/
endef

define HM_PLATFORM_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(HM_PLATFORM_PKGDIR)/S50eq3configd \
		$(TARGET_DIR)/etc/init.d/S50eq3configd
endef

$(eval $(generic-package))
