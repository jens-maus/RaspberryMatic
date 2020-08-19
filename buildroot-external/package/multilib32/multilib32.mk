#############################################################
#
# Multlib32 Package
#
#############################################################

MULTILIB32_VERSION = 1.0.0
MULTILIB32_SITE = $(TOPDIR)
MULTILIB32_SITE_METHOD = local

define MULTILIB32_BUILD_CMDS
	$(MAKE) -C $(@D) BR2_EXTERNAL=$(MULTILIB32_PKGDIR)external $(BR2_PACKAGE_MULTILIB32_DEFCONFIG)
	$(MAKE) -C $(@D) BR2_EXTERNAL=$(MULTILIB32_PKGDIR)external
endef

define MULTILIB32_INSTALL_TARGET_CMDS
	tar xvf $(@D)/output/images/rootfs.tar --transform='s/.\/lib\//lib32\//' -C $(TARGET_DIR)/ --wildcards --show-transformed-names "./lib/*.so*"
	tar xvf $(@D)/output/images/rootfs.tar --transform='s/.\/usr\/lib\//usr\/lib32\//' -C $(TARGET_DIR)/ --wildcards --show-transformed-names "./usr/lib/*.so*"
	echo "export LD_LIBRARY_PATH=/lib32:/usr/lib32:${LD_LIBRARY_PATH}" >$(TARGET_DIR)/etc/profile.d/multilib32.sh
	ln -sf /lib32/ld-linux.so.2 $(TARGET_DIR)/lib/
endef

$(eval $(generic-package))
