#############################################################
#
# Azul java runtime
#
# http://www.azul.com/downloads/zulu-embedded/
#
#############################################################
JAVA_AZUL_VERSION = 11.1.8-ca-jdk11-c2
JAVA_AZUL_SOURCE=zulu$(JAVA_AZUL_VERSION)-linux_aarch32hf.tar.gz
JAVA_AZUL_SITE = http://cdn.azul.com/zulu-embedded/bin
JAVA_AZUL_DEPENDENCIES = fontconfig dejavu liberation

define JAVA_AZUL_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/opt/java-azul
	cp -a $(@D)/bin $(TARGET_DIR)/opt/java-azul/
	cp -a $(@D)/lib $(TARGET_DIR)/opt/java-azul/
	rm -f $(TARGET_DIR)/opt/java-azul/lib/src.zip
	cp -a $(@D)/jmods $(TARGET_DIR)/opt/java-azul/
	cp -a $(@D)/conf $(TARGET_DIR)/opt/java-azul/
	cp -a $(@D)/legal $(TARGET_DIR)/opt/java-azul/
	cp -a $(@D)/LICENSE $(TARGET_DIR)/opt/java-azul/
	cp -a $(@D)/DISCLAIMER $(TARGET_DIR)/opt/java-azul/
	rm -f $(TARGET_DIR)/opt/java
	ln -s java-azul $(TARGET_DIR)/opt/java
endef

$(eval $(generic-package))
