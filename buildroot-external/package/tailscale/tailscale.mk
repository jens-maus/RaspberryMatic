################################################################################
#
# Tailscale Zero config VPN - https://tailscale.com/
#
################################################################################

TAILSCALE_VERSION = 1.16.1
TAILSCALE_SITE = $(call github,tailscale,tailscale,v$(TAILSCALE_VERSION))
TAILSCALE_LICENSE = BSD-3-Clause
TAILSCALE_LICENSE_FILES = LICENSE

TAILSCALE_GO_ENV = GOPROXY= GOFLAGS="-mod=readonly"

TAILSCALE_GOMOD = tailscale.com

TAILSCALE_BUILD_TARGETS = \
	cmd/tailscale \
	cmd/tailscaled

TAILSCALE_LDFLAGS = \
	-X tailscale.com/version.Long=$(TAILSCALE_VERSION) \
	-X tailscale.com/version.Short=$(TAILSCALE_VERSION) \
	-X tailscale.com/version.GitCommit=$(TAILSCALE_VERSION)

define TAILSCALE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/bin/tailscale $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0755 $(@D)/bin/tailscaled $(TARGET_DIR)/usr/sbin/
endef

define TAILSCALE_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(TAILSCALE_PKGDIR)/S46tailscaled \
		$(TARGET_DIR)/etc/init.d/S46tailscaled
endef

$(eval $(golang-package))
