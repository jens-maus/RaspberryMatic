################################################################################
#
# OpenCCU-Base package
#
################################################################################

OPENCCU_BASE_VERSION = bde93606c6c52a3c9dafea65f5abf6c13afc20e4
OPENCCU_BASE_COMPAT_VERSION = 3.89.8
OPENCCU_BASE_SITE = https://github.com/OpenCCU/OpenCCU-Base
OPENCCU_BASE_SITE_METHOD = git
OPENCCU_BASE_LICENSE = HMSL-2.0 and mixed
OPENCCU_BASE_LICENSE_FILES = licenses/licenses.md licenses/HMSL2.txt \
	licenses/gpl-2.0.txt licenses/lgpl-2.1.txt
OPENCCU_BASE_DEPENDENCIES = host-python3 host-python-html2text libusb host-libusb
OPENCCU_BASE_BUILD_OPTS = --target package
OPENCCU_BASE_ROOTFS_PATCH_DIR = \
	$(OPENCCU_BASE_PKGDIR)/rootfs-patches
OPENCCU_BASE_ENABLE_ROOTFS_PATCHING ?= YES

OPENCCU_BASE_CONF_OPTS = \
	-DDEPLOY_TO_REPO=OFF \
	-DBUILD_TCL_MODULES=ON \
	-DBUILD_WEBUI_AND_DEVICETYPES=ON \
	-DHAS_USB_SUPPORT=ON \
	-DROOTFS_DIR=$(@D)/build/rootfs

ifeq ($(BR2_aarch64),y)
OPENCCU_BASE_TARGET_PLATFORM = aarch64-linux-gnu
endif

ifeq ($(BR2_x86_64),y)
OPENCCU_BASE_TARGET_PLATFORM = x86_64-linux-gnu
endif

OPENCCU_BASE_CONF_OPTS += \
	-DTARGET_PLATFORM=$(OPENCCU_BASE_TARGET_PLATFORM) \
	-DCROSS_PREFIX=$(TARGET_CROSS)

# Keep build/rootfs as the canonical, pristine input for the post-build patch
# series. Do not remove the complete staging directory here: incremental CMake
# builds do not necessarily re-stage binaries and libraries that are already
# up to date.
define OPENCCU_BASE_PREPARE_ROOTFS_PATCH_INPUTS
	rm -rf \
		"$(@D)/build/rootfs/www" \
		"$(@D)/build/rootfs/opt" \
		"$(@D)/build/rootfs/firmware" \
		"$(@D)/build/rootfs/usr/lib/tcl8.2/homematic"
	rm -f \
		"$(@D)/build/rootfs/bin/hm_autoconf" \
		"$(@D)/build/rootfs/bin/hm_deldev" \
		"$(@D)/build/rootfs/bin/hm_startup" \
		"$(@D)/build/rootfs/.applied_patches_list"
	$(INSTALL) -d -m 0755 "$(@D)/build/rootfs/bin"
	for file in hm_autoconf hm_deldev hm_startup; do \
		$(INSTALL) -m 0755 "$(@D)/bin/$$file" \
			"$(@D)/build/rootfs/bin/$$file"; \
	done
	$(INSTALL) -d -m 0755 "$(@D)/build/rootfs/firmware"
	cp -a "$(@D)/firmware/." "$(@D)/build/rootfs/firmware/"
endef
OPENCCU_BASE_PRE_BUILD_HOOKS += OPENCCU_BASE_PREPARE_ROOTFS_PATCH_INPUTS

# Apply the OpenCCU rootfs patch stack after CMake has generated the WebUI and
# device types, but before any files are installed into TARGET_DIR.
define OPENCCU_BASE_APPLY_ROOTFS_PATCHES
	test -s "$(@D)/build/rootfs/www/webui/webui.js"
	test -s "$(@D)/build/rootfs/www/webui/style.css"
	test -s "$(@D)/build/rootfs/www/config/st_values.cgi"
	test -s "$(@D)/build/rootfs/opt/HMServer/pages/AvailableFirmware.ftl"
	test -s "$(@D)/build/rootfs/bin/hm_autoconf"
	test -s "$(@D)/build/rootfs/usr/lib/tcl8.2/homematic/homematic.tcl"
	# Legacy patches expect the generated template strings at the beginning of
	# webui.js to be split into individual lines.
	$(SHELL) "$(OPENCCU_BASE_ROOTFS_PATCH_DIR)/prepare_patch_input.sh" \
		"$(@D)/build/rootfs"
	rm -f "$(@D)/build/rootfs/.applied_patches_list"
	$(APPLY_PATCHES) "$(@D)/build/rootfs" \
		"$(OPENCCU_BASE_ROOTFS_PATCH_DIR)" \*.patch
	rm -f "$(@D)/build/rootfs/.applied_patches_list"
endef
ifeq ($(OPENCCU_BASE_ENABLE_ROOTFS_PATCHING),YES)
OPENCCU_BASE_POST_BUILD_HOOKS += OPENCCU_BASE_APPLY_ROOTFS_PATCHES
endif

define OPENCCU_BASE_INSTALL_TARGET_CMDS

	# override stuff via rootfs-overlay
	cp -av "$(OPENCCU_BASE_PKGDIR)/rootfs-overlay/." "$(TARGET_DIR)/"

	# generate /bin
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/bin

	# collect own compiled binaries from $(@D)/build/rootfs/bin
	for file in SetInterfaceClock crypttool eq3configcmd eq3configd hs485d hs485dLoader hss_led multimacd rfd ssdpd; do \
		$(INSTALL) -m 0755 "$(@D)/build/rootfs/bin/$$file" "$(TARGET_DIR)/bin/$$file"; \
	done
	# collect staged scripts/bins from $(@D)/build/rootfs/bin
	for file in hm_autoconf hm_deldev hm_startup; do \
		$(INSTALL) -m 0755 "$(@D)/build/rootfs/bin/$$file" "$(TARGET_DIR)/bin/$$file"; \
	done
	# collect some pre-compiled binaries from $(@D)/bin/$(OPENCCU_BASE_TARGET_PLATFORM)
	for file in ReGaHss; do \
		$(INSTALL) -m 0755 "$(@D)/bin/$(OPENCCU_BASE_TARGET_PLATFORM)/$$file" "$(TARGET_DIR)/bin/$$file"; \
	done

	# generate /lib
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/lib

	# collect own compiled libraries from $(@D)/build/rootfs/lib
	for lib in libLanDeviceUtils.so libUnifiedLanComm.so libXmlRpc.so libelvutils.so libeq3config.so libhsscomm.so libxmlparser.so; do \
		$(INSTALL) -m 0644 "$(@D)/build/rootfs/lib/$$lib" "$(TARGET_DIR)/lib/$$lib"; \
	done

	# collect own compiled WebUI from $(@D)/build/rootfs/www
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/www
	cp -av "$(@D)/build/rootfs/www/." "$(TARGET_DIR)/www/"

	# copy homematic tcl package to target dir
	$(INSTALL) -d -m 0755 "$(TARGET_DIR)/usr/lib/tcl8.6/homematic"
	cp -av "$(@D)/build/rootfs/usr/lib/tcl8.2/homematic/." \
		"$(TARGET_DIR)/usr/lib/tcl8.6/homematic/"

	# copy all static /etc stuff from main and build directory
	$(INSTALL) -d -m 0755 "$(TARGET_DIR)/etc"
	cp -av "$(@D)/etc/." "$(TARGET_DIR)/etc/"
	cp -av "$(@D)/build/rootfs/etc/." "$(TARGET_DIR)/etc/"

	# copy the complete staged /firmware tree
	$(INSTALL) -d -m 0755 "$(TARGET_DIR)/firmware"
	cp -av "$(@D)/build/rootfs/firmware/." "$(TARGET_DIR)/firmware/"

	# copy the complete staged /opt tree
	$(INSTALL) -d -m 0755 "$(TARGET_DIR)/opt"
	cp -av "$(@D)/build/rootfs/opt/." "$(TARGET_DIR)/opt/"

	# patch XXX-WEBUI-VERSION-XXX and XXX-PRODUCT-XXX templates
	grep -rl 'XXX-WEBUI-VERSION-XXX' $(TARGET_DIR)/www | xargs sed -i 's/XXX-WEBUI-VERSION-XXX/$(PRODUCT_VERSION)/g' || true
	grep -rl 'XXX-PRODUCT-XXX' $(TARGET_DIR)/www | xargs sed -i 's/XXX-PRODUCT-XXX/$(PRODUCT)/g' || true
endef

define OPENCCU_BASE_FINALIZE_TARGET
	# setup /usr/local/etc/config
	mkdir -p $(TARGET_DIR)/usr/local/etc/config
	rm -rf $(TARGET_DIR)/etc/config
	ln -snf ../usr/local/etc/config $(TARGET_DIR)/etc/

	# shadow file setup
	touch $(TARGET_DIR)/usr/local/etc/config/shadow
	chmod 0640 $(TARGET_DIR)/usr/local/etc/config/shadow
	rm -f $(TARGET_DIR)/etc/shadow
	ln -snf config/shadow $(TARGET_DIR)/etc/

	# relink /run to /var/run
	rm -rf $(TARGET_DIR)/run $(TARGET_DIR)/var/run
	mkdir -p $(TARGET_DIR)/var/run
	ln -snf var/run $(TARGET_DIR)/

	# relink resolv.conf to /var/etc
	rm -f $(TARGET_DIR)/etc/resolv.conf
	ln -snf ../var/etc/resolv.conf $(TARGET_DIR)/etc/

	# remove the local wpa_supplicant config
	rm -f $(TARGET_DIR)/etc/wpa_supplicant.conf

	# relink the NUT config files
	rm -f $(TARGET_DIR)/etc/upssched.conf.sample
	ln -snf config/nut/upssched.conf $(TARGET_DIR)/etc/
	rm -f $(TARGET_DIR)/etc/upsmon.conf.sample
	ln -snf config/nut/upsmon.conf $(TARGET_DIR)/etc/
	rm -f $(TARGET_DIR)/etc/upsd.conf.sample
	ln -snf config/nut/upsd.conf $(TARGET_DIR)/etc/
	rm -f $(TARGET_DIR)/etc/upsd.users.sample
	ln -snf config/nut/upsd.users $(TARGET_DIR)/etc/
	rm -f $(TARGET_DIR)/etc/ups.conf.sample
	ln -snf config/nut/ups.conf $(TARGET_DIR)/etc/
	rm -f $(TARGET_DIR)/etc/nut.conf.sample
	ln -snf config/nut/nut.conf $(TARGET_DIR)/etc/

	# link timezone information files
	ln -snf config/localtime $(TARGET_DIR)/etc/
	ln -snf config/timezone $(TARGET_DIR)/etc/

	# link /etc/firmware to /lib/firmware
	ln -snf ../lib/firmware $(TARGET_DIR)/etc/

	# link /bin/tclsh to /usr/bin/tclsh
	ln -snf /usr/bin/tclsh $(TARGET_DIR)/bin/tclsh

	# fix permissions
	chmod 755 $(TARGET_DIR)/www/config/fileupload.ccc

	# remove obsolete init.d jobs
	rm -f $(TARGET_DIR)/etc/init.d/S01logging
	rm -f $(TARGET_DIR)/etc/init.d/S20urandom
	rm -f $(TARGET_DIR)/etc/init.d/S01syslogd
	rm -f $(TARGET_DIR)/etc/init.d/S02klogd
	rm -f $(TARGET_DIR)/etc/init.d/S49chronyd

	# remove obsolete config templates
	rm -f $(TARGET_DIR)/etc/config_templates/hmip_networkkey.conf

	# remove obsolete lighttpd config files
	rm -f $(TARGET_DIR)/etc/lighttpd/lighttpd_ssl.conf

	# make sure ReGaHss.* is deleted
	rm -f $(TARGET_DIR)/bin/ReGaHss.*

	# make sure no /etc/ntp.conf is there anymore (chrony used)
	rm -f $(TARGET_DIR)/etc/ntp.conf

	# extract license infos from JAR files
	$(HOST_DIR)/bin/python3 $(OPENCCU_BASE_PKGDIR)/scripts/createLicenseForJar.py \
		--packagedir=$(TARGET_DIR)/opt/HMServer \
		--jarfile=HMIPServer.jar \
		--output=$(@D)/HMIPServer.jar-JARLICENSEINFO.txt
	$(HOST_DIR)/bin/python3 $(OPENCCU_BASE_PKGDIR)/scripts/createLicenseForJar.py \
		--packagedir=$(TARGET_DIR)/opt/HMServer \
		--jarfile=HMServer.jar \
		--output=$(@D)/HMServer.jar-JARLICENSEINFO.txt
	$(HOST_DIR)/bin/python3 $(OPENCCU_BASE_PKGDIR)/scripts/createLicenseForJar.py \
		--packagedir=$(TARGET_DIR)/opt/HmIP \
		--jarfile=hmip-copro-update.jar \
		--output=$(@D)/hmip-copro-update.jar-JARLICENSEINFO.txt
	$(HOST_DIR)/bin/python3 $(OPENCCU_BASE_PKGDIR)/scripts/createLicenseForJar.py \
		--packagedir=$(TARGET_DIR)/opt/HMServer/coupling \
		--jarfile=ESHBridge.jar \
		--output=$(@D)/ESHBridge.jar-JARLICENSEINFO.txt

	# create licenseinfo.htm
	$(HOST_DIR)/bin/python3 $(OPENCCU_BASE_PKGDIR)/scripts/createLicenseHtml.py \
		--build-dir=$(BUILD_DIR)/../ \
		--jar-license-info=$(@D)/HMIPServer.jar-JARLICENSEINFO.txt \
		--jar-license-info=$(@D)/HMServer.jar-JARLICENSEINFO.txt \
		--jar-license-info=$(@D)/hmip-copro-update.jar-JARLICENSEINFO.txt \
		--jar-license-info=$(@D)/ESHBridge.jar-JARLICENSEINFO.txt \
		--output=$(TARGET_DIR)/www/rega/licenseinfo.htm
endef
ifeq ($(BR2_PACKAGE_OPENCCU_BASE),y)
TARGET_FINALIZE_HOOKS += OPENCCU_BASE_FINALIZE_TARGET
endif

define OPENCCU_BASE_USERS
	-      -1 hm     -1 * - - -      homematic access group
	-      -1 status -1 * - - -      status access group
	hssled -1 hssled -1 * - - status hss_led user
endef

$(eval $(cmake-package))
