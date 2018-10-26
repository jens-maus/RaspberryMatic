#############################################################
#
# CloudMatic/meine-homematic.de support
#
#############################################################
CLOUDMATIC_VERSION = 87ad087243dea1042fb95860aa3545af04340bbf
CLOUDMATIC_SITE = $(call github,jens-maus,CloudMatic-CCUAddon,$(CLOUDMATIC_VERSION))
CLOUDMATIC_LICENSE = PROPERITARY

define CLOUDMATIC_INSTALL_TARGET_CMDS
  $(INSTALL) -d -m 0755 $(TARGET_DIR)/opt/mh
  $(INSTALL) -D -m 0755 $(@D)/install.tcl $(TARGET_DIR)/opt/mh/
  $(INSTALL) -D -m 0755 $(@D)/startup.sh $(TARGET_DIR)/opt/mh/
  rm -f $(TARGET_DIR)/opt/mh/openvpn
  ln -s /usr/sbin/openvpn $(TARGET_DIR)/opt/mh/
  cp -a $(@D)/user $(TARGET_DIR)/opt/mh/
  cp -a $(@D)/www $(TARGET_DIR)/opt/mh/
  rm -f $(TARGET_DIR)/opt/mh/user/nginx.pi $(TARGET_DIR)/opt/mh/user/nginx
  $(INSTALL) -m 0755 $(@D)/user/nginx.pi $(TARGET_DIR)/opt/mh/user/nginx
  $(INSTALL) -D -m 0755 $(CLOUDMATIC_PKGDIR)/S97CloudMatic $(TARGET_DIR)/etc/init.d
endef

$(eval $(generic-package))
