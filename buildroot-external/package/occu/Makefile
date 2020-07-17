# 
# OCCU package Makefile
#

OCCU_ROOT=

install_rfd_arch:
	mkdir -p $(TARGET_DIR)/bin
	mkdir -p $(TARGET_DIR)/lib
	mkdir -p $(TARGET_DIR)/etc/config_templates
	mkdir -p $(TARGET_DIR)/www/config
	mkdir -p $(TARGET_DIR)/firmware
	cp -R $(OCCU_ARCH)/packages-eQ-3/RFD/bin/* $(TARGET_DIR)/bin/
	cp -R $(OCCU_ARCH)/packages-eQ-3/RFD/lib/* $(TARGET_DIR)/lib/
	cp -a $(OCCU_ARCH)/packages-eQ-3/RFD/etc/init.d/S61rfd $(TARGET_DIR)/etc/init.d/
	cp -R $(OCCU_ARCH)/packages-eQ-3/RFD/etc/config_templates/* $(TARGET_DIR)/etc/config_templates/
	cp -R $(OCCU_ARCH)/packages-eQ-3/RFD/www/config/* $(TARGET_DIR)/www/config/
	cp -R firmware/* $(TARGET_DIR)/firmware
ifneq (,$(filter $(OCCU_RF_PROTOCOL), HM_HMIP HMIP))
	cp -a $(OCCU_ARCH)/packages-eQ-3/RFD/etc/init.d/S60multimacd $(TARGET_DIR)/etc/init.d/
	cp -a $(OCCU_ARCH)/packages-eQ-3/RFD/bin/multimacd $(TARGET_DIR)/bin/
	cp -a $(OCCU_ARCH)/packages-eQ-3/RFD/etc/crRFD.conf $(TARGET_DIR)/etc/config_templates/
endif

install_hs485d_arch:
	cp -R $(OCCU_ARCH)/packages-eQ-3/HS485D/* $(TARGET_DIR)/

install_webui_arch:
	rm -f $(OCCU_ARCH)/packages-eQ-3/WebUI/config
	rm -rf $(OCCU_ARCH)/packages-eQ-3/WebUI/etc/config
	cp -R $(OCCU_ARCH)/packages-eQ-3/WebUI/* $(TARGET_DIR)/
	cp -R WebUI/* $(TARGET_DIR)/
	mv $(TARGET_DIR)/bin/ReGaHss.community $(TARGET_DIR)/bin/ReGaHss
ifeq ($(OCCU_WEBUI_REGAHSS_BETA), y)
	cp -R $(OCCU_ARCH)/packages-eQ-3/WebUI-Beta/* $(TARGET_DIR)/
endif

install_linuxbasis_arch:
	cp -av $(OCCU_ARCH)/packages-eQ-3/LinuxBasis/bin/* $(TARGET_DIR)/bin/
	cp -av $(OCCU_ARCH)/packages-eQ-3/LinuxBasis/lib/* $(TARGET_DIR)/lib/

install_lighttpd_arch:
	mkdir -p $(TARGET_DIR)/etc/lighttpd
	cp -R $(OCCU_ARCH)/packages/lighttpd/etc/lighttpd/conf.d $(TARGET_DIR)/etc/lighttpd/
	cp -a $(OCCU_ARCH)/packages/lighttpd/etc/lighttpd/lighttpd.conf $(TARGET_DIR)/etc/lighttpd/
	cp -a $(OCCU_ARCH)/packages/lighttpd/etc/lighttpd/modules.conf $(TARGET_DIR)/etc/lighttpd/
	rm -f $(TARGET_DIR)/etc/lighttpd/conf.d/global.conf
	rm -f $(TARGET_DIR)/etc/lighttpd/conf.d/headers.conf
	chmod 644 $(TARGET_DIR)/etc/lighttpd/conf.d/*

install_hmserver:
	mkdir -p $(TARGET_DIR)/opt/HMServer
	cp -R HMserver/etc/config_templates/* $(TARGET_DIR)/etc/config_templates/
	cp -R HMserver/opt/HMServer/groups $(TARGET_DIR)/opt/HMServer/
	cp -R HMserver/opt/HMServer/measurement $(TARGET_DIR)/opt/HMServer/
	cp -R HMserver/opt/HMServer/pages $(TARGET_DIR)/opt/HMServer/
	cp -a HMserver/etc/init.d/S62HMServer $(TARGET_DIR)/etc/init.d/
	chmod a+rx $(TARGET_DIR)/etc/init.d/S62HMServer
ifneq (,$(filter $(OCCU_RF_PROTOCOL), HM_HMIP HMIP))
	cp -a HMserver/opt/HMServer/HMIPServer.jar $(TARGET_DIR)/opt/HMServer/
	cp -a HMserver/opt/HmIP $(TARGET_DIR)/opt/
	cp -a HMserver/opt/HMServer/HMServer.jar $(TARGET_DIR)/opt/HMServer/
endif

update_webui:
	ln -sf /usr/local/.firmwareUpdate/EULA.de             $(TARGET_DIR)/www/rega/EULA.de
	ln -sf /usr/local/.firmwareUpdate/EULA.en             $(TARGET_DIR)/www/rega/EULA.en
	ln -sf /usr/local/.firmwareUpdate/EULA.tr             $(TARGET_DIR)/www/rega/EULA.tr
	ln -sf ${OCCU_ROOT}/www/tcl/extern/cgi.tcl            $(TARGET_DIR)/www/cgi.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3_old/common.tcl        $(TARGET_DIR)/www/common.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3_old/session.tcl       $(TARGET_DIR)/www/session.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3_old/once.tcl          $(TARGET_DIR)/www/once.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3_old/user.tcl          $(TARGET_DIR)/www/user.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3_old/verifysid.cgi     $(TARGET_DIR)/www/verifysid.cgi

	ln -sf ${OCCU_ROOT}/www/tcl/extern/cgi.tcl            $(TARGET_DIR)/www/config/cgi.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3_old/common.tcl        $(TARGET_DIR)/www/config/common.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3_old/session.tcl       $(TARGET_DIR)/www/config/session.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3_old/once.tcl          $(TARGET_DIR)/www/config/once.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3_old/user.tcl          $(TARGET_DIR)/www/config/user.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3_old/verifysid.cgi     $(TARGET_DIR)/www/config/verifysid.cgi

	ln -sf ${OCCU_ROOT}/www/tcl/extern/cgi.tcl            $(TARGET_DIR)/www/config/display/cgi.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3_old/once.tcl          $(TARGET_DIR)/www/config/display/once.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3_old/common.tcl        $(TARGET_DIR)/www/config/display/common.tcl

	ln -sf ${OCCU_ROOT}/www/tcl/eq3/rega.tcl              $(TARGET_DIR)/www/pda/eq3/rega.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3/session.tcl           $(TARGET_DIR)/www/pda/eq3/session.tcl

	ln -sf ${OCCU_ROOT}/www/tcl/eq3/rega.tcl              $(TARGET_DIR)/www/api/eq3/rega.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3/session.tcl           $(TARGET_DIR)/www/api/eq3/session.tcl

	ln -sf ${OCCU_ROOT}/www/tcl/extern/cgi.tcl            $(TARGET_DIR)/www/tools/cgi.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3_old/once.tcl          $(TARGET_DIR)/www/tools/once.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3_old/session.tcl       $(TARGET_DIR)/www/tools/session.tcl
	ln -sf ${OCCU_ROOT}/www/tcl/eq3_old/common.tcl        $(TARGET_DIR)/www/tools/common.tcl

	ln -snf ${OCCU_ROOT}/etc/config/addons/www            $(TARGET_DIR)/www/addons

	chmod a+rx $(TARGET_DIR)/www/config/fileupload.ccc

	grep -rl 'XXX-WEBUI-VERSION-XXX' $(TARGET_DIR)/www | xargs sed -i 's/XXX-WEBUI-VERSION-XXX/$(PRODUCT_VERSION)/g'
	grep -rl 'XXX-PRODUCT-XXX' $(TARGET_DIR)/www | xargs sed -i 's/XXX-PRODUCT-XXX/$(PRODUCT)/g'

install:
	make install_rfd_arch OCCU_ARCH=$(OCCU_ARCH)
	make install_hs485d_arch OCCU_ARCH=$(OCCU_ARCH)
	make install_webui_arch OCCU_ARCH=$(OCCU_ARCH)
	make install_linuxbasis_arch OCCU_ARCH=$(OCCU_ARCH)
	make install_lighttpd_arch OCCU_ARCH=$(OCCU_ARCH)
	make install_hmserver
	make update_webui

all: 
	@echo "do nothing"
