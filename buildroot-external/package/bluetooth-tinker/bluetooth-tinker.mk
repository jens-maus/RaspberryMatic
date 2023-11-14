################################################################################
#
# Support for Bluetooth for the ASUS Tinkerboard
#
################################################################################

BLUETOOTH_TINKER_VERSION = 1.0.0
BLUETOOTH_TINKER_SOURCE =
BLUETOOTH_TINKER_LICENSE = Apache-2.0

define BLUETOOTH_TINKER_INSTALL_TARGET_CMDS
	cp -a $(BLUETOOTH_TINKER_PKGDIR)/rootfs-overlay/* $(TARGET_DIR)/
endef

$(eval $(generic-package))
