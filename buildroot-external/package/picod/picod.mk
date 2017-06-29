#############################################################
#
# Pico UPS Support (pimodules.com)
#
#############################################################
PICOD_VERSION = 3.0
PICOD_COMMIT = 55458477aa48b1ccccbb8b09175dd81fd3512ebf
PICOD_SITE = $(call github,ef-gy,rpi-ups-pico,$(PICOD_COMMIT))
PICOD_LICENSE = MIT
PICOD_LICENSE_FILES = LICENSE

define PICOD_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) CFLAGS+="-I../i2c-tools-v3.1.2/include/" -C $(@D) all
endef

define PICOD_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt/picod
	cp -a $(@D)/picod $(TARGET_DIR)/opt/picod/
	cp -a $(@D)/pico-i2cd $(TARGET_DIR)/opt/picod/
endef

$(eval $(generic-package))
