#############################################################
#
# detect_radio_module
#
# Alexander Reinert <alex@areinert.de>
# https://github.com/alexreinert/piVCCU/tree/master/detect_radio_module
#
#############################################################

DETECT_RADIO_MODULE_VERSION = aae8612e4c43619fcee3ac8b01752c98c1dc6f1d
DETECT_RADIO_MODULE_SITE = $(call github,alexreinert,piVCCU,$(DETECT_RADIO_MODULE_VERSION))
DETECT_RADIO_MODULE_LICENSE = Apache-2.0

define DETECT_RADIO_MODULE_BUILD_CMDS
  $(TARGET_MAKE_ENV) $(MAKE) CXX="$(TARGET_CXX)" \
    CXXFLAGS="$(TARGET_CXXFLAGS) -pthread" \
    LDFLAGS="$(TARGET_LDFLAGS) -pthread" -C $(@D)/detect_radio_module
endef

define DETECT_RADIO_MODULE_INSTALL_TARGET_CMDS
  $(INSTALL) -D -m 0755 $(@D)/detect_radio_module/detect_radio_module $(TARGET_DIR)/bin/detect_radio_module
endef

$(eval $(generic-package))
