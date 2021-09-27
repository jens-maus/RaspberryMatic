################################################################################
#
# Tailscale Zero config VPN - https://tailscale.com/
#
################################################################################

TAILSCALE_VERSION = 1.14.3
TAILSCALE_SITE = https://pkgs.tailscale.com/stable
ifeq ($(call qstrip,$(BR2_ARCH)),arm)
TAILSCALE_SOURCE = tailscale_$(TAILSCALE_VERSION)_arm.tgz
else ifeq ($(call qstrip,$(BR2_ARCH)),aarch64)
TAILSCALE_SOURCE = tailscale_$(TAILSCALE_VERSION)_arm64.tgz
else ifeq ($(call qstrip,$(BR2_ARCH)),i686)
TAILSCALE_SOURCE = tailscale_$(TAILSCALE_VERSION)_386.tgz
else ifeq ($(call qstrip,$(BR2_ARCH)),x86_64)
TAILSCALE_SOURCE = tailscale_$(TAILSCALE_VERSION)_amd64.tgz
endif
TAILSCALE_LICENSE = BSD3

define TAILSCALE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/tailscale $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/tailscaled $(TARGET_DIR)/usr/sbin/
endef

define TAILSCALE_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(TAILSCALE_PKGDIR)/S46tailscaled \
		$(TARGET_DIR)/etc/init.d/S46tailscaled
endef

$(eval $(generic-package))
