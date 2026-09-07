include $(BR2_EXTERNAL_RECOVERY_SYSTEM_PATH)/../../packages.mk
include $(sort $(wildcard $(BR2_EXTERNAL_RECOVERY_SYSTEM_PATH)/package/*/*.mk))
