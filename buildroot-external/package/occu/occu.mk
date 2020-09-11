#############################################################
#
# OCCU by eQ-3
#
#############################################################

OCCU_VERSION = 3.53.27-5
OCCU_SITE = $(call github,jens-maus,occu,$(OCCU_VERSION))

ifeq ($(BR2_PACKAGE_OCCU),y)

	define OCCU_PRE_PATCH
		cp $(OCCU_PKGDIR)/Makefile $(@D)
  endef
	OCCU_PRE_PATCH_HOOKS += OCCU_PRE_PATCH

	define OCCU_FINALIZE_TARGET
		# setup /usr/local/etc/config
		mkdir -p $(TARGET_DIR)/usr/local/etc/config
		rm -rf $(TARGET_DIR)/etc/config
		ln -snf ../usr/local/etc/config $(TARGET_DIR)/etc/

		# shadow file setup
		touch $(TARGET_DIR)/usr/local/etc/config/shadow
		rm -f $(TARGET_DIR)/etc/shadow
		ln -snf config/shadow $(TARGET_DIR)/etc/

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

		# remove obsolete init.d jobs
		rm -f $(TARGET_DIR)/etc/init.d/S01logging
		rm -f $(TARGET_DIR)/etc/init.d/S20urandom
		rm -f $(TARGET_DIR)/etc/init.d/S01syslogd
		rm -f $(TARGET_DIR)/etc/init.d/S02klogd

		# remove obsolete config templates
		rm -f $(TARGET_DIR)/etc/config_templates/hmip_networkkey.conf

		# remove obsolete lighttpd config files
		rm -f $(TARGET_DIR)/etc/lighttpd/lighttpd_ssl.conf

		# make sure ReGaHss.* is deleted
		rm -f $(TARGET_DIR)/bin/ReGaHss.*

		# make sure no /etc/ntp.conf is there anymore (chrony used)
		rm -f $(TARGET_DIR)/etc/ntp.conf
  endef
	TARGET_FINALIZE_HOOKS += OCCU_FINALIZE_TARGET

endif

ifeq ($(BR2_PACKAGE_OCCU_RF_PROTOCOL_HM_ONLY),y)
	OCCU_RF_PROTOCOL=HM
endif

ifeq ($(BR2_PACKAGE_OCCU_RF_PROTOCOL_HMIP_ONLY),y)
	OCCU_RF_PROTOCOL=HMIP
endif

ifeq ($(BR2_PACKAGE_OCCU_RF_PROTOCOL_HM_HMIP),y)
	OCCU_RF_PROTOCOL=HM_HMIP
endif

ifeq ($(BR2_PACKAGE_OCCU_WEBUI_REGAHSS_BETA),y)
	OCCU_WEBUI_REGAHSS_BETA=y
endif

ifeq ($(BR2_arm),y)
	OCCU_ARCH=arm-gnueabihf-gcc8
endif

ifeq ($(BR2_i386),y)
	OCCU_ARCH=X86_32_GCC8
endif

define OCCU_INSTALL_TARGET_CMDS
		$(MAKE) OCCU_RF_PROTOCOL=$(OCCU_RF_PROTOCOL) \
			OCCU_ARCH=$(OCCU_ARCH) \
			OCCU_WEBUI_REGAHSS_BETA=$(OCCU_WEBUI_REGAHSS_BETA) \
			-C $(@D) install 
endef

$(eval $(generic-package))
