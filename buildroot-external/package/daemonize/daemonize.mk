#############################################################
#
# daemonize from https://github.com/bmc/daemonize
#
#############################################################

DAEMONIZE_VERSION = 1.7.7
DAEMONIZE_SITE = $(call github,bmc,daemonize,release-$(DAEMONIZE_VERSION))
DAEMONIZE_LICENSE = BSD-2c
DAEMONIZE_LICENSE_FILES = LICENSE.md

$(eval $(autotools-package))
