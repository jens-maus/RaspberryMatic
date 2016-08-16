# 
# homematic Makefile
#

HM_ROOT=

install_jre:
	mkdir -p $(TARGET_DIR)/opt/java-azul
	cp -R jre/* $(TARGET_DIR)/opt/java-azul
	ln -s /opt/java-azul $(TARGET_DIR)/opt/java

install:
	make install_jre

all: 
	@echo "do nothing"
