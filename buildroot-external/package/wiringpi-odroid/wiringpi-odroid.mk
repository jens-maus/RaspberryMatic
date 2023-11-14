################################################################################
#
# wiringpi for ODROID (https://github.com/hardkernel/wiringPi)
#
################################################################################

WIRINGPI_ODROID_VERSION = 84e3f6d04dbd30488430e6aec8eec7cf0444e843
WIRINGPI_ODROID_SITE = $(call github,hardkernel,wiringPi,$(WIRINGPI_ODROID_VERSION))

WIRINGPI_ODROID_LICENSE = LGPL-3.0+
WIRINGPI_ODROID_LICENSE_FILES = COPYING.LESSER
WIRINGPI_ODROID_INSTALL_STAGING = YES
WIRINGPI_ODROID_AUTORECONF = YES
WIRINGPI_ODROID_CONF_OPTS += --bindir=/usr/bin --sbindir=/usr/bin --libdir=/usr/lib
WIRINGPI_ODROID_CONF_ENV += LIBS="-lcrypt -lgpiod"

$(eval $(autotools-package))
