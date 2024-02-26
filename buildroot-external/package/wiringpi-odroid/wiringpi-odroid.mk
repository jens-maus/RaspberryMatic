################################################################################
#
# wiringpi for ODROID (https://github.com/hardkernel/wiringPi)
#
################################################################################

WIRINGPI_ODROID_VERSION = fb3fe0a2a74c5a2dc97185d253d2c667a6344cc9
WIRINGPI_ODROID_SITE = $(call github,hardkernel,wiringPi,$(WIRINGPI_ODROID_VERSION))

WIRINGPI_ODROID_LICENSE = LGPL-3.0+
WIRINGPI_ODROID_LICENSE_FILES = COPYING.LESSER
WIRINGPI_ODROID_INSTALL_STAGING = YES
WIRINGPI_ODROID_AUTORECONF = YES
WIRINGPI_ODROID_CONF_OPTS += --bindir=/usr/bin --sbindir=/usr/bin --libdir=/usr/lib
WIRINGPI_ODROID_CONF_ENV += LIBS="-lcrypt -lgpiod"

$(eval $(autotools-package))
