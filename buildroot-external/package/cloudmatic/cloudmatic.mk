#############################################################
#
# CloudMatic/meine-homematic.de support
#
#############################################################
CLOUDMATIC_VERSION = 90e303bb3c86b5969f6825385ce0dae258215e0c
CLOUDMATIC_SITE = $(call github,EasySmartHome,CloudMatic-CCUAddon,$(CLOUDMATIC_VERSION))
CLOUDMATIC_LICENSE = PROPERITARY

define CLOUDMATIC_INSTALL_TARGET_CMDS
  $(INSTALL) -d -m 0755 $(TARGET_DIR)/opt/mh
  $(INSTALL) -D -m 0755 $(@D)/install.tcl $(TARGET_DIR)/opt/mh/
  $(INSTALL) -D -m 0755 $(@D)/startup.sh $(TARGET_DIR)/opt/mh/
  rm -f $(TARGET_DIR)/opt/mh/openvpn
  ln -s /usr/sbin/openvpn $(TARGET_DIR)/opt/mh/
  cp -a $(@D)/user $(TARGET_DIR)/opt/mh/
  cp -a $(@D)/www $(TARGET_DIR)/opt/mh/
  rm -f $(TARGET_DIR)/opt/mh/user/nginx.pi
  $(INSTALL) -m 0755 $(@D)/user/nginx.pi $(TARGET_DIR)/opt/mh/nginx
  $(INSTALL) -D -m 0755 $(CLOUDMATIC_PKGDIR)/S97CloudMatic $(TARGET_DIR)/etc/init.d
endef

$(eval $(generic-package))
