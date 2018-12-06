#############################################################
#
# Recovery Image Package
#
#############################################################

RECOVERY_SYSTEM_VERSION = 1.5.0
RECOVERY_SYSTEM_BUILDROOT = 2018.08.2
RECOVERY_SYSTEM_SITE = $(call github,buildroot,buildroot,$(RECOVERY_SYSTEM_BUILDROOT))
RECOVERY_SYSTEM_LICENSE = Apache-2.0

define RECOVERY_SYSTEM_PRE_PATCH
	for p in $(wildcard ../buildroot-patches/*.patch); do \
		patch -p1 -d $(@D) <$${p}; \
  done
endef
RECOVERY_SYSTEM_PRE_PATCH_HOOKS += RECOVERY_SYSTEM_PRE_PATCH

define RECOVERY_SYSTEM_BUILD_CMDS
	$(MAKE) -C $(@D) BR2_EXTERNAL=$(RECOVERY_SYSTEM_PKGDIR)external $(BR2_PACKAGE_RECOVERY_SYSTEM_CONFIG)
	$(MAKE) -C $(@D) BR2_EXTERNAL=$(RECOVERY_SYSTEM_PKGDIR)external BR2_RECOVERY_SYSTEM_VERSION=$(shell cat ../VERSION)-$(RECOVERY_SYSTEM_VERSION) BR2_PACKAGE_PSPLASH_PATCH=$(BR2_PACKAGE_PSPLASH_PATCH)
endef

define RECOVERY_SYSTEM_INSTALL_TARGET_CMDS
	cp -a $(@D)/output/images/rootfs.cpio.uboot $(BINARIES_DIR)/recoveryfs-initrd
	cp -a $(@D)/output/images/zImage $(BINARIES_DIR)/recoveryfs-zImage
endef

$(eval $(generic-package))
