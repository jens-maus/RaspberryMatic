################################################################################
#
# wiringpi for ODROID (https://github.com/hardkernel/wiringPi)
#
################################################################################

WIRINGPI_ODROID_VERSION = 58cea616e0a450fbcb8c148824f67609cce37b3d
WIRINGPI_ODROID_SITE = $(call github,hardkernel,wiringPi,$(WIRINGPI_ODROID_VERSION))

WIRINGPI_ODROID_LICENSE = LGPL-3.0+
WIRINGPI_ODROID_LICENSE_FILES = COPYING.LESSER
WIRINGPI_ODROID_INSTALL_STAGING = YES
WIRINGPI_ODROID_AUTORECONF = YES
WIRINGPI_ODROID_CONF_OPTS += --bindir=/usr/bin --sbindir=/usr/bin --libdir=/usr/lib
WIRINGPI_ODROID_CONF_ENV += LIBS="-lcrypt -lgpiod"

$(eval $(autotools-package))
