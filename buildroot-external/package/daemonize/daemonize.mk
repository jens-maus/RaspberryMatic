################################################################################
#
# daemonize - https://github.com/bmc/daemonize
#
################################################################################

DAEMONIZE_VERSION = release-1.7.8
DAEMONIZE_SITE = $(call github,bmc,daemonize,$(DAEMONIZE_VERSION))
DAEMONIZE_LICENSE = BSD-2-Clause
DAEMONIZE_LICENSE_FILES = LICENSE.md

DAEMONIZE_CONF_OPTS = --prefix=/

$(eval $(autotools-package))
