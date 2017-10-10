#############################################################
#
# CloudMatic/meine-homematic.de support
#
#############################################################
CLOUDMATIC_VERSION = 90e303bb3c86b5969f6825385ce0dae258215e0c
CLOUDMATIC_SITE = $(call github,EasySmartHome,CloudMatic-CCUAddon,$(CLOUDMATIC_VERSION))
CLOUDMATIC_LICENSE = PROPERITARY

define CLOUDMATIC_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt/mh
	cp -a $(@D)/install.tcl $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/startup.sh $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/openvpn $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/user $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/www $(TARGET_DIR)/opt/mh/
	rm -f $(TARGET_DIR)/opt/mh/user/nginx.pi
	cp -a $(@D)/user/nginx.pi $(TARGET_DIR)/opt/mh/nginx
endef

$(eval $(generic-package))
