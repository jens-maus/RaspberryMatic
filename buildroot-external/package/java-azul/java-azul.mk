#############################################################
#
# Azul java runtime
#
# http://www.azul.com/downloads/zulu-embedded/
#
#############################################################
ifeq ($(call qstrip,$(BR2_ARCH)),arm)
JAVA_AZUL_VERSION = 8.44.0.213-ca-jdk1.8.0_242
JAVA_AZUL_SOURCE = zulu$(JAVA_AZUL_VERSION)-linux_aarch32hf.tar.gz
JAVA_AZUL_SITE = http://cdn.azul.com/zulu-embedded/bin
else ifeq ($(call qstrip,$(BR2_ARCH)),i686)
JAVA_AZUL_VERSION = 8.46.0.19-ca-jdk8.0.252
JAVA_AZUL_SOURCE = zulu$(JAVA_AZUL_VERSION)-linux_i686.tar.gz
JAVA_AZUL_SITE = http://cdn.azul.com/zulu/bin
endif
JAVA_AZUL_DEPENDENCIES = fontconfig dejavu liberation

define JAVA_AZUL_PRE_PATCH
	cp $(JAVA_AZUL_PKGDIR)/Makefile $(@D)
endef

JAVA_AZUL_PRE_PATCH_HOOKS += JAVA_AZUL_PRE_PATCH

define JAVA_AZUL_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) install 
endef

$(eval $(generic-package))
