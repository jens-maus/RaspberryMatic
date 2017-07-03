#############################################################
#
# CloudMatic/meine-homematic.de support
#
#############################################################
CLOUDMATIC_VERSION = 2017020901
CLOUDMATIC_COMMIT = 2b48ddb52d224ecc1945041cc6eb9eb6888da8fc
CLOUDMATIC_SITE = $(call github,EasySmartHome,CloudMatic-CCUAddon,$(CLOUDMATIC_COMMIT))
CLOUDMATIC_LICENSE = PROPERITARY

define CLOUDMATIC_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt/mh
	cp -a $(@D)/install.tcl $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/startup.sh $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/openvpn $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/user $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/www $(TARGET_DIR)/opt/mh/
	mv $(TARGET_DIR)/opt/mh/user/nginx.pi $(TARGET_DIR)/opt/mh/user/nginx
endef

$(eval $(generic-package))
