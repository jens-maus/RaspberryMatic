#############################################################
#
# Recovery Image Package
#
#############################################################

RECOVERY_SYSTEM_VER = 1.9.0
RECOVERY_SYSTEM_VERSION = $(RECOVERY_SYSTEM_VER)-$(BR2_VERSION)
RECOVERY_SYSTEM_SOURCE =
RECOVERY_SYSTEM_LICENSE = Apache-2.0

define RECOVERY_SYSTEM_CONFIGURE_CMDS
	mkdir -p $(@D)/output/build
	rsync -a --delete-after --exclude '.stamp_target_installed' --exclude ".stamp_staging_installed" --exclude '.stamp_images_installed' --exclude '.stamp_installed' --exclude 'recovery-system-*' $(@D)/../ $(@D)/output/build/
	mkdir -p $(@D)/output/host
	rsync -a --delete-after $(@D)/../../host/ $(@D)/output/host/
endef

define RECOVERY_SYSTEM_BUILD_CMDS
	$(MAKE) O=$(@D)/output -C $(TOPDIR) BR2_EXTERNAL=$(RECOVERY_SYSTEM_PKGDIR)external $(BR2_PACKAGE_RECOVERY_SYSTEM_CONFIG)
	$(MAKE) O=$(@D)/output -C $(TOPDIR) BR2_EXTERNAL=$(RECOVERY_SYSTEM_PKGDIR)external BR2_RECOVERY_SYSTEM_VERSION=$(PRODUCT_VERSION)-$(RECOVERY_SYSTEM_VER) BR2_PACKAGE_PSPLASH_PATCH=$(BR2_PACKAGE_PSPLASH_PATCH)
endef

define RECOVERY_SYSTEM_INSTALL_TARGET_CMDS
	test -f $(@D)/output/images/rootfs.cpio.uboot && cp -a $(@D)/output/images/rootfs.cpio.uboot $(BINARIES_DIR)/recoveryfs-initrd || cp -a $(@D)/output/images/rootfs.cpio.lz4 $(BINARIES_DIR)/recoveryfs-initrd
	test -f $(@D)/output/images/bzImage && cp -a $(@D)/output/images/bzImage $(BINARIES_DIR)/recoveryfs-zImage || true
	test -f $(@D)/output/images/zImage && cp -a $(@D)/output/images/zImage $(BINARIES_DIR)/recoveryfs-zImage || true
	test -f $(@D)/output/images/Image && cp -a $(@D)/output/images/Image $(BINARIES_DIR)/recoveryfs-Image || true
endef

$(eval $(generic-package))
