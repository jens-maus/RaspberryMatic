#############################################################
#
# Generic RAW UART kernel module
#
#############################################################

GENERIC_RAW_UART_VERSION = 1.2
GENERIC_RAW_UART_TAG = 1bec8b24bdf9b1b3a2511a0f1b888eb9f59724dd
GENERIC_RAW_UART_SITE = $(call github,alexreinert,piVCCU,$(GENERIC_RAW_UART_TAG))
GENERIC_RAW_UART_LICENSE = GPL
#GENERIC_RAW_UART_LICENSE_FILES = LICENSE
GENERIC_RAW_UART_MODULE_SUBDIRS = kernel

$(eval $(kernel-module))
$(eval $(generic-package))
