#############################################################
#
# Epson RX8130CE real time clock
#
#############################################################

RX8130_RTC_VERSION = 1.1.0
RX8130_RTC_LICENSE = GPL2
#RX8130_RTC_LICENSE_FILES = COPYING
RX8130_RTC_SITE = $(BR2_EXTERNAL_EQ3_PATH)/package/rx8130-rtc
RX8130_RTC_SITE_METHOD = local
RX8130_RTC_MODULE_SUBDIRS = kernel-modules/rtc_rx8130ce

$(eval $(kernel-module))
$(eval $(generic-package))
