#############################################################
#
# Recovery Image Package
#
#############################################################

RECOVERY_IMAGE_VERSION = 1.0.0
RECOVERY_IMAGE_BUILDROOT = 2018.02
RECOVERY_IMAGE_SITE = $(call github,buildroot,buildroot,$(RECOVERY_IMAGE_BUILDROOT))
RECOVERY_IMAGE_LICENSE = Apache-2.0

define RECOVERY_IMAGE_PRE_PATCH
	for p in $(wildcard ../buildroot-patches/*.patch); do \
		patch -p1 -d $(@D) <$${p}; \
  done
endef
RECOVERY_IMAGE_PRE_PATCH_HOOKS += RECOVERY_IMAGE_PRE_PATCH

define RECOVERY_IMAGE_BUILD_CMDS
	$(MAKE) -C $(@D) BR2_EXTERNAL=$(RECOVERY_IMAGE_PKGDIR)/external $(BR2_PACKAGE_RECOVERY_IMAGE_CONFIG)
	$(MAKE) -C $(@D) BR2_EXTERNAL=$(RECOVERY_IMAGE_PKGDIR)/external
endef

define RECOVERY_IMAGE_INSTALL_TARGET_CMDS
	cp -a $(@D)/output/images/rootfs.ext2 $(BINARIES_DIR)/recoveryfs.ext4
endef

$(eval $(generic-package))
