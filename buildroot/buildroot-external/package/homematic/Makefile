# 
# homematic Makefile
#

install_rfd_arch:
	mkdir -p $(TARGET_DIR)/bin
	mkdir -p $(TARGET_DIR)/lib
	mkdir -p $(TARGET_DIR)/etc/config_templates
	mkdir -p $(TARGET_DIR)/firmware
	cp -R $(OCCU_ARCH)/packages-eQ-3/RFD/bin/* $(TARGET_DIR)/bin
	cp -R $(OCCU_ARCH)/packages-eQ-3/RFD/lib/* $(TARGET_DIR)/lib
	cp -R $(OCCU_ARCH)/packages-eQ-3/RFD/etc/config_templates/* $(TARGET_DIR)/etc/config_templates
	cp -R firmware/* $(TARGET_DIR)/firmware

install_hs485d_arch:
	cp -R $(OCCU_ARCH)/packages-eQ-3/HS485D/* $(TARGET_DIR)

install_webui_arch:
	cp -R $(OCCU_ARCH)/packages-eQ-3/WebUI/* $(TARGET_DIR)
	cp -R WebUI/* $(TARGET_DIR)/

install_linuxbasis_arch:
	cp -R $(OCCU_ARCH)/packages-eQ-3/LinuxBasis/* $(TARGET_DIR)

install_lighttpd_arch:
	cp -R $(OCCU_ARCH)/packages/lighttpd/* $(TARGET_DIR)

install:
	make install_rfd_arch OCCU_ARCH=arm-gnueabihf
	make install_hs485d_arch OCCU_ARCH=arm-gnueabihf
	make install_webui_arch OCCU_ARCH=arm-gnueabihf
	make install_linuxbasis_arch OCCU_ARCH=arm-gnueabihf
	make install_lighttpd_arch OCCU_ARCH=arm-gnueabihf

all: 
	@echo "do nothing"
