################################################################################
#
# Pico UPS Support (pimodules.com)
#
################################################################################

PICOD_VERSION = 3.0
PICOD_COMMIT = 55458477aa48b1ccccbb8b09175dd81fd3512ebf
PICOD_SITE = $(call github,ef-gy,rpi-ups-pico,$(PICOD_COMMIT))
PICOD_LICENSE = MIT
PICOD_LICENSE_FILES = LICENSE

define PICOD_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) CFLAGS+="-I../i2c-tools-4.0/include/" LDFLAGS+="-L../i2c-tools-4.0/lib -li2c" -C $(@D) all
endef

define PICOD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/picod $(TARGET_DIR)/opt/picod/picod
	$(INSTALL) -D -m 0755 $(@D)/pico-i2cd $(TARGET_DIR)/opt/picod/pico-i2cd
	$(INSTALL) -D -m 0755 $(PICOD_PKGDIR)/picod.sh $(TARGET_DIR)/opt/picod/picod.sh
endef

define PICOD_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(PICOD_PKGDIR)/S51picod \
		$(TARGET_DIR)/etc/init.d/S51picod
endef

$(eval $(generic-package))
