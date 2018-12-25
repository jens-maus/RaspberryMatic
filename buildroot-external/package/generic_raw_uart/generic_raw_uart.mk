#############################################################
#
# Generic RAW UART kernel module
#
# Alexander Reinert <alex@areinert.de>
# https://github.com/alexreinert/piVCCU/tree/master/kernel
#
#############################################################

GENERIC_RAW_UART_VERSION = 5cbdb4076298016753691473f2d658fe63f5d2ea
GENERIC_RAW_UART_SITE = $(call github,alexreinert,piVCCU,$(GENERIC_RAW_UART_VERSION))
GENERIC_RAW_UART_LICENSE = GPL
GENERIC_RAW_UART_DEPENDENCIES = host-dtc
#GENERIC_RAW_UART_LICENSE_FILES = LICENSE
GENERIC_RAW_UART_MODULE_SUBDIRS = kernel
GENERIC_RAW_UART_INSTALL_IMAGES = YES

define GENERIC_RAW_UART_BUILD_CMDS
  for dts in $(@D)/dts/*.dts; do \
    $(HOST_DIR)/bin/dtc -@ -I dts -O dtb -W no-unit_address_vs_reg -o $${dts%.dts}.dtbo $${dts}; \
  done
endef

define GENERIC_RAW_UART_INSTALL_IMAGES_CMDS
  for dtbo in $(@D)/dts/*.dtbo; do \
    $(INSTALL) -D -m 0644 $${dtbo} $(BINARIES_DIR)/; \
  done
endef

$(eval $(kernel-module))
$(eval $(generic-package))
