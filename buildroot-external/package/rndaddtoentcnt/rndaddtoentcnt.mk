#############################################################
#
# rndaddtoentcnt from https://github.com/jumpnow/rndaddtoentcnt
#
# See https://jumpnowtek.com/linux/Speeding-up-initialization-of-the-Linux-RNG.html
#
#############################################################

RNDADDTOENTCNT_VERSION = master
RNDADDTOENTCNT_SITE = $(call github,jumpnow,rndaddtoentcnt,$(RNDADDTOENTCNT_VERSION))
RNDADDTOENTCNT_LICENSE = MIT
RNDADDTOENTCNT_LICENSE_FILES = LICENSE

define RNDADDTOENTCNT_BUILD_CMDS
  $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" CFLAGS="$(TARGET_CFLAGS)" -C $(@D)
endef

define RNDADDTOENTCNT_INSTALL_TARGET_CMDS
  $(INSTALL) -D -m 0755 $(@D)/rndaddtoentcnt $(TARGET_DIR)/bin
endef

$(eval $(generic-package))
