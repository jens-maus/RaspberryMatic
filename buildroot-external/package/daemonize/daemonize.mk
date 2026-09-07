################################################################################
#
# daemonize - https://github.com/bmc/daemonize
#
################################################################################

DAEMONIZE_VERSION = d29dc4ad02f080750597f1fe8e14a667ba43247f
DAEMONIZE_SITE = $(call github,bmc,daemonize,$(DAEMONIZE_VERSION))
DAEMONIZE_LICENSE = BSD-2-Clause
DAEMONIZE_LICENSE_FILES = LICENSE.md

DAEMONIZE_CONF_OPTS = --prefix=/

$(eval $(autotools-package))
