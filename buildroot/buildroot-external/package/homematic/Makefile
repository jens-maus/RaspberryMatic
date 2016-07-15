# 
# homematic Makefile
#

install_rfd_arch:
	cp -R $(OCCU_ARCH)/packages-eQ-3/RFD/* $(TARGET_DIR)

install_hs485d_arch:
	cp -R $(OCCU_ARCH)/packages-eQ-3/HS485D/* $(TARGET_DIR)

install_webui_arch:
	cp -R $(OCCU_ARCH)/packages-eQ-3/WebUI/* $(TARGET_DIR)

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
