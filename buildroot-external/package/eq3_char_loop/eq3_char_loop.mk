################################################################################
#
# eQ-3 char loopback kernel module for HomeMatic/homematicIP
# dual stack implementations for the RPI-RF-MOD/HM-MOD-RPI-PCB
#
# Copyright (c) 2015 by eQ-3 Entwicklung GmbH
# https://github.com/OpenCCU/OpenCCU-Base/tree/main/src/eq3_char_loop
#
################################################################################

EQ3_CHAR_LOOP_VERSION = $(OPENCCU_BASE_VERSION)
EQ3_CHAR_LOOP_SOURCE = $(OPENCCU_BASE_SOURCE)
EQ3_CHAR_LOOP_SITE = $(OPENCCU_BASE_SITE)
EQ3_CHAR_LOOP_SITE_METHOD = $(OPENCCU_BASE_SITE_METHOD)
EQ3_CHAR_LOOP_DL_SUBDIR = openccu-base
EQ3_CHAR_LOOP_LICENSE = GPL-2.0+
EQ3_CHAR_LOOP_LICENSE_FILES = licenses/gpl-2.0.txt
EQ3_CHAR_LOOP_MODULE_SUBDIRS = src/eq3_char_loop

$(eval $(kernel-module))
$(eval $(generic-package))
