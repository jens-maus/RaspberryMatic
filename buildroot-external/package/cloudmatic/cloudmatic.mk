#############################################################
#
# CloudMatic/meine-homematic.de support
#
#############################################################
CLOUDMATIC_VERSION = 4216d1955a288d34c9d1a9dad861da3165eedc24
CLOUDMATIC_SITE = $(call github,jens-maus,CloudMatic-CCUAddon,$(CLOUDMATIC_VERSION))
CLOUDMATIC_LICENSE = PROPERITARY

ifeq ($(BR2_arm),y)
	NGINX_BIN=nginx.pi
	ZABBIX_BIN=zabbix_agentd
endif

ifeq ($(BR2_i386),y)
	NGINX_BIN=nginx.i686
	ZABBIX_BIN=zabbix_agentd.i686
endif

define CLOUDMATIC_INSTALL_TARGET_CMDS
  $(INSTALL) -d -m 0755 $(TARGET_DIR)/opt/mh
  $(INSTALL) -D -m 0755 $(@D)/install.tcl $(TARGET_DIR)/opt/mh/
  $(INSTALL) -D -m 0755 $(@D)/startup.sh $(TARGET_DIR)/opt/mh/
  rm -f $(TARGET_DIR)/opt/mh/openvpn
  ln -s /usr/sbin/openvpn $(TARGET_DIR)/opt/mh/
  cp -a $(@D)/user $(TARGET_DIR)/opt/mh/
  cp -a $(@D)/www $(TARGET_DIR)/opt/mh/
  rm -f $(TARGET_DIR)/opt/mh/user/nginx.pi $(TARGET_DIR)/opt/mh/user/nginx $(TARGET_DIR)/opt/mh/user/nginx.i686 $(TARGET_DIR)/opt/mh/user/zabbix_agentd $(TARGET_DIR)/opt/mh/user/zabbix_agentd.i686
  [[ -n "$(NGINX_BIN)" ]] && $(INSTALL) -m 0755 $(@D)/user/$(NGINX_BIN) $(TARGET_DIR)/opt/mh/user/nginx || true
  [[ -n "$(ZABBIX_BIN)" ]] && $(INSTALL) -m 0755 $(@D)/user/$(ZABBIX_BIN) $(TARGET_DIR)/opt/mh/user/zabbix_agentd || true
  $(INSTALL) -D -m 0755 $(CLOUDMATIC_PKGDIR)/S97CloudMatic $(TARGET_DIR)/etc/init.d
endef

$(eval $(generic-package))
