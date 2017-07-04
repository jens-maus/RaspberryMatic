#############################################################
#
# CloudMatic/meine-homematic.de support
#
#############################################################
CLOUDMATIC_VERSION = 2017020901
CLOUDMATIC_COMMIT = 28da6a8b56d2cf7a66d56489e2d87cda99be0fc7
CLOUDMATIC_SITE = $(call github,EasySmartHome,CloudMatic-CCUAddon,$(CLOUDMATIC_COMMIT))
CLOUDMATIC_LICENSE = PROPERITARY

define CLOUDMATIC_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt/mh
	cp -a $(@D)/install.tcl $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/startup.sh $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/openvpn $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/user $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/www $(TARGET_DIR)/opt/mh/
	rm -f $(TARGET_DIR)/opt/mh/user/nginx
	ln -s nginx.pi $(TARGET_DIR)/opt/mh/user/nginx
endef

$(eval $(generic-package))
