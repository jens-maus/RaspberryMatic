# 
# homematic Makefile
#

HM_ROOT=

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
	cp -R $(OCCU_ARCH)/packages/lighttpd/bin/* $(TARGET_DIR)/usr/sbin
	cp -R $(OCCU_ARCH)/packages/lighttpd/lib/* $(TARGET_DIR)/usr/lib
	cp -R $(OCCU_ARCH)/packages/lighttpd/etc/* $(TARGET_DIR)/etc

install_hmserver:
	mkdir -p $(TARGET_DIR)/opt/HMServer
	cp -R HMserver/opt/HMServer/* $(TARGET_DIR)/opt/HMServer
	cp -R HMserver/etc/config_templates/* $(TARGET_DIR)/etc/config_templates
	cp -R HMserver/HMServer.jar $(TARGET_DIR)/opt/HMServer

update_webui:
	ln -sf /var/EULA.de                            $(TARGET_DIR)/www/rega/EULA.de
	ln -sf /var/EULA.en                            $(TARGET_DIR)/www/rega/EULA.en
	ln -sf /var/EULA.tr                            $(TARGET_DIR)/www/rega/EULA.tr
	ln -sf ${HM_ROOT}/www/tcl/extern/cgi.tcl        $(TARGET_DIR)/www/cgi.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3_old/common.tcl    $(TARGET_DIR)/www/common.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3_old/session.tcl   $(TARGET_DIR)/www/session.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3_old/once.tcl      $(TARGET_DIR)/www/once.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3_old/user.tcl      $(TARGET_DIR)/www/user.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3_old/verifysid.cgi $(TARGET_DIR)/www/verifysid.cgi

	ln -sf ${HM_ROOT}/www/tcl/extern/cgi.tcl        $(TARGET_DIR)/www/config/cgi.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3_old/common.tcl    $(TARGET_DIR)/www/config/common.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3_old/session.tcl   $(TARGET_DIR)/www/config/session.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3_old/once.tcl      $(TARGET_DIR)/www/config/once.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3_old/user.tcl      $(TARGET_DIR)/www/config/user.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3_old/verifysid.cgi $(TARGET_DIR)/www/config/verifysid.cgi

	ln -sf ${HM_ROOT}/www/tcl/extern/cgi.tcl        $(TARGET_DIR)/www/config/display/cgi.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3_old/once.tcl      $(TARGET_DIR)/www/config/display/once.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3_old/common.tcl    $(TARGET_DIR)/www/config/display/common.tcl

	ln -sf ${HM_ROOT}/www/tcl/extern/cgi.tcl            $(TARGET_DIR)/www/pda/extern/cgi.tcl
	ln -sf ${HM_ROOT}/www/tcl/extern/tmpl_parser.tcl    $(TARGET_DIR)/www/pda/extern/tmpl_parser.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3/rega.tcl              $(TARGET_DIR)/www/pda/eq3/rega.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3/session.tcl           $(TARGET_DIR)/www/pda/eq3/session.tcl

	ln -sf ${HM_ROOT}/www/tcl/eq3/rega.tcl              $(TARGET_DIR)/www/api/eq3/rega.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3/session.tcl           $(TARGET_DIR)/www/api/eq3/session.tcl

	ln -sf ${HM_ROOT}/www/tcl/extern/cgi.tcl       $(TARGET_DIR)/www/tools/cgi.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3_old/once.tcl     $(TARGET_DIR)/www/tools/once.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3_old/session.tcl  $(TARGET_DIR)/www/tools/session.tcl
	ln -sf ${HM_ROOT}/www/tcl/eq3_old/common.tcl   $(TARGET_DIR)/www/tools/common.tcl

	ln -snf ${HM_ROOT}/etc/config/addons/www   $(TARGET_DIR)/www/addons


install:
	make install_rfd_arch OCCU_ARCH=$(HOMEMATIC_ARCH)
	make install_hs485d_arch OCCU_ARCH=$(HOMEMATIC_ARCH)
	make install_webui_arch OCCU_ARCH=$(HOMEMATIC_ARCH)
	make install_linuxbasis_arch OCCU_ARCH=$(HOMEMATIC_ARCH)
	make install_lighttpd_arch OCCU_ARCH=$(HOMEMATIC_ARCH)
	make install_hmserver
	sed -i -e 's/\/opt\/hm\//\//g' $(TARGET_DIR)/etc/lighttpd/lighttpd.conf
	sed -i -e 's/\/opt\/hm\//\//g' $(TARGET_DIR)/etc/lighttpd/conf.d/cgi.conf
	make update_webui
	mkdir -p $(TARGET_DIR)/boot
	echo "VERSION=$(HOMEMATIC_VERSION)" > $(TARGET_DIR)/boot/VERSION

all: 
	@echo "do nothing"
