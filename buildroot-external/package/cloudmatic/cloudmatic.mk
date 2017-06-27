#############################################################
#
# CloudMatic/meine-homematic.de support
#
#############################################################
CLOUDMATIC_VERSION = 2017020901
CLOUDMATIC_COMMIT = aad53fa975b7ce05c4e81d1434ea7bb3e1826db5
CLOUDMATIC_SITE = $(call github,EasySmartHome,CloudMatic-CCUAddon,$(CLOUDMATIC_COMMIT))
CLOUDMATIC_LICENSE = PROPERITARY

define CLOUDMATIC_INSTALL_TARGET_CMDS
	mkdir $(TARGET_DIR)/opt/mh
	cp -a $(@D)/install.tcl $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/startup.sh $(TARGET_DIR)/opt/mh/
	ln -s /usr/sbin/openvpn $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/user $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/www $(TARGET_DIR)/opt/mh/
endef

$(eval $(generic-package))
