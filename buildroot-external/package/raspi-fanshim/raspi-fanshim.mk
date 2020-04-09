################################################################################
#
# raspi-fanshim for RaspberryPi (https://github.com/flobernd/raspi-fanshim)
#
################################################################################

RASPI_FANSHIM_VERSION = 9e4a79a28ff7b0d56674584f0f49f8c68c7eac36
RASPI_FANSHIM_SITE = git://github.com/flobernd/raspi-fanshim.git
RASPI_FANSHIM_GIT_SUBMODULES = YES
RASPI_FANSHIM_CONF_OPTS = -DRASPI_FANSHIM_BUILD_EXAMPLES=ON

RASPI_FANSHIM_LICENSE = MIT
RASPI_FANSHIM_LICENSE_FILES = LICENSE
RASPI_FANSHIM_INSTALL_STAGING = YES
RASPI_FANSHIM_DEPENDENCIES = wiringpi

define RASPI_FANSHIM_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt/raspi-fanshim
	$(INSTALL) -D -m 0755 $(@D)/FanshimService $(TARGET_DIR)/opt/raspi-fanshim/FanshimService
	$(INSTALL) -D -m 0755 $(RASPI_FANSHIM_PKGDIR)/S51raspi-fanshim $(TARGET_DIR)/etc/init.d/S51raspi-fanshim
endef

$(eval $(cmake-package))
