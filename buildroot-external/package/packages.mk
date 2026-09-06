# Load the Base version before generic-package freezes the versions of the
# nested builds. Keep the revision in openccu-base.mk for the update tooling.
OPENCCU_PACKAGE_DIR := $(dir $(lastword $(MAKEFILE_LIST)))
include $(OPENCCU_PACKAGE_DIR)openccu-base/openccu-base.mk
include $(sort $(filter-out %/openccu-base/openccu-base.mk, \
	$(wildcard $(OPENCCU_PACKAGE_DIR)*/*.mk)))
