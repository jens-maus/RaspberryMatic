#############################################################
#
# CloudMatic/meine-homematic.de support
#
#############################################################
CLOUDMATIC_VERSION = 2017020901
CLOUDMATIC_COMMIT = 4964e9cf81b5bb76016a89b044194168de28025a
CLOUDMATIC_SITE = $(call github,EasySmartHome,CloudMatic-CCUAddon,$(CLOUDMATIC_COMMIT))
CLOUDMATIC_LICENSE = PROPERITARY

define CLOUDMATIC_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt/mh
	cp -a $(@D)/install.tcl $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/startup.sh $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/openvpn $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/user $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/www $(TARGET_DIR)/opt/mh/
endef

$(eval $(generic-package))
