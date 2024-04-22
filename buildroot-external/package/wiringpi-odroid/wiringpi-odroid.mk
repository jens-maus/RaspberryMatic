################################################################################
#
# wiringpi for ODROID (https://github.com/hardkernel/wiringPi)
#
################################################################################

WIRINGPI_ODROID_VERSION = f3f2a2ff90a3356322b5c5b40aeca9579ad3393a
WIRINGPI_ODROID_SITE = $(call github,hardkernel,wiringPi,$(WIRINGPI_ODROID_VERSION))

WIRINGPI_ODROID_LICENSE = LGPL-3.0+
WIRINGPI_ODROID_LICENSE_FILES = COPYING.LESSER
WIRINGPI_ODROID_INSTALL_STAGING = YES
WIRINGPI_ODROID_AUTORECONF = YES
WIRINGPI_ODROID_CONF_OPTS += --bindir=/usr/bin --sbindir=/usr/bin --libdir=/usr/lib
WIRINGPI_ODROID_CONF_ENV += LIBS="-lcrypt -lgpiod"

$(eval $(autotools-package))
