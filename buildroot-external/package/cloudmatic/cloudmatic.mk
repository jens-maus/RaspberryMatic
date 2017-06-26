#############################################################
#
# CloudMatic/meine-homematic.de support
#
#############################################################
CLOUDMATIC_VERSION = 2017020901
CLOUDMATIC_COMMIT = 1de8d7ec25f8a8a4ae44b21cc2d8e651ab6df7f0
CLOUDMATIC_SITE = $(call github,EasySmartHome,CloudMatic-CCUAddon,$(CLOUDMATIC_COMMIT))
CLOUDMATIC_LICENSE = PROPERITARY

define CLOUDMATIC_INSTALL_TARGET_CMDS
	mkdir $(TARGET_DIR)/opt/mh
	cp -a $(@D)/install.tcl $(TARGET_DIR)/opt/mh/
	chmod a+rx $(TARGET_DIR)/opt/mh/install.tcl
	cp -a $(@D)/startup.sh $(TARGET_DIR)/opt/mh/
	chmod a+rx $(TARGET_DIR)/opt/mh/startup.sh
	ln -s /usr/sbin/openvpn $(TARGET_DIR)/opt/mh/
	cp -a $(@D)/user $(TARGET_DIR)/opt/mh/
	chmod a+rx $(TARGET_DIR)/opt/mh/user/*
	chmod a+rx $(TARGET_DIR)/opt/mh/user/scripts/*
	cp -a $(@D)/www $(TARGET_DIR)/opt/mh/
	chmod a+rx $(TARGET_DIR)/opt/mh/www/*.cgi
endef

$(eval $(generic-package))
