#############################################################
#
# Multlib32 Package
#
#############################################################

MULTILIB32_VERSION = 1.0.0
MULTILIB32_SOURCE =

define MULTILIB32_BUILD_CMDS
	mkdir -p $(@D)/output
	$(MAKE) O=$(@D)/output -C $(TOPDIR) BR2_EXTERNAL=$(MULTILIB32_PKGDIR)external $(BR2_PACKAGE_MULTILIB32_DEFCONFIG)
	$(MAKE) O=$(@D)/output -C $(TOPDIR) BR2_EXTERNAL=$(MULTILIB32_PKGDIR)external
endef

define MULTILIB32_INSTALL_TARGET_CMDS
	tar xvf $(@D)/output/images/rootfs.tar --transform='s/.\/lib\//lib32\//' -C $(TARGET_DIR)/ --wildcards --show-transformed-names "./lib/*.so*"
	tar xvf $(@D)/output/images/rootfs.tar --transform='s/.\/usr\/lib\//usr\/lib32\//' -C $(TARGET_DIR)/ --wildcards --show-transformed-names "./usr/lib/*.so*"
	mkdir -p $(TARGET_DIR)/etc/ld.so.conf.d
	echo -e "/lib32\n/usr/lib32\n/usr/local/lib32" >$(TARGET_DIR)/etc/ld.so.conf.d/lib32.conf
	if [[ $(BR2_ARCH) == "x86_64" ]]; then ln -sf ../lib32/ld-linux.so.2 $(TARGET_DIR)/lib/ ; fi
	if [[ $(BR2_ARCH) == "aarch64" ]]; then ln -sf ../lib32/ld-linux-armhf.so.3 $(TARGET_DIR)/lib/ ; fi
endef

$(eval $(generic-package))
