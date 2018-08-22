#############################################################
#
# Azul java runtime
#
# http://www.azul.com/downloads/zulu-embedded/
#
#############################################################
JAVA_AZUL_VERSION = 8.31.1.122-jdk1.8.0_181
JAVA_AZUL_SOURCE=zulu$(JAVA_AZUL_VERSION)-linux_aarch32hf.tar.gz
JAVA_AZUL_SITE = http://cdn.azul.com/zulu-embedded/bin
JAVA_AZUL_DEPENDENCIES = fontconfig dejavu liberation

define JAVA_AZUL_PRE_PATCH
	cp $(JAVA_AZUL_PKGDIR)/Makefile $(@D)
endef

JAVA_AZUL_PRE_PATCH_HOOKS += JAVA_AZUL_PRE_PATCH

define JAVA_AZUL_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) install 
endef

$(eval $(generic-package))
