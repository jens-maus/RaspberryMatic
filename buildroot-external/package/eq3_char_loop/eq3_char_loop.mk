#############################################################
#
# EQ3 Char Loop kernel module
#
#############################################################

EQ3_CHAR_LOOP_VERSION = 1.0
EQ3_CHAR_LOOP_SITE = $(BR2_EXTERNAL_EQ3_PATH)/package/eq3_char_loop
EQ3_CHAR_LOOP_SITE_METHOD = local
EQ3_CHAR_LOOP_LICENSE = GPL
#EQ3_CHAR_LOOP_LICENSE_FILES = LICENSE
EQ3_CHAR_LOOP_MODULE_SUBDIRS = .

$(eval $(kernel-module))
$(eval $(generic-package))
