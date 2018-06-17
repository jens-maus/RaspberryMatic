#############################################################
#
# BCM2835 RAW UART kernel module
#
#############################################################

BCM2835_RAW_UART_VERSION = 1.2
BCM2835_RAW_UART_SITE = $(BR2_EXTERNAL_EQ3_PATH)/package/bcm2835_raw_uart
BCM2835_RAW_UART_SITE_METHOD = local
BCM2835_RAW_UART_LICENSE = GPL
BCM2835_RAW_UART_DEPENDENCIES = host-dtc
#BCM2835_RAW_UART_LICENSE_FILES = LICENSE
BCM2835_RAW_UART_INSTALL_IMAGES = YES
BCM2835_RAW_UART_MODULE_SUBDIRS = .

define BCM2835_RAW_UART_BUILD_CMDS
  for dts in $(@D)/*.dts; do \
    $(HOST_DIR)/bin/dtc -@ -I dts -O dtb -W no-unit_address_vs_reg -o $${dts%.dts}.dtbo $${dts}; \
  done
endef

define BCM2835_RAW_UART_INSTALL_IMAGES_CMDS
  for dtbo in $(@D)/*.dtbo; do \
    $(INSTALL) -D -m 0644 $${dtbo} $(BINARIES_DIR)/; \
  done
endef

$(eval $(kernel-module))
$(eval $(generic-package))
