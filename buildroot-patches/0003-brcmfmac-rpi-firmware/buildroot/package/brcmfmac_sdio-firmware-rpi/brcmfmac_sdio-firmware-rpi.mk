################################################################################
#
# brcmfmac_sdio-firmware-rpi
#
################################################################################

BRCMFMAC_SDIO_FIRMWARE_RPI_VERSION = 26ff205b45dc109b498a70aaf182804ad9dbfea5
BRCMFMAC_SDIO_FIRMWARE_RPI_SITE = $(call github,LibreELEC,brcmfmac_sdio-firmware-rpi,$(BRCMFMAC_SDIO_FIRMWARE_RPI_VERSION))
BRCMFMAC_SDIO_FIRMWARE_RPI_LICENSE = PROPRIETARY
BRCMFMAC_SDIO_FIRMWARE_RPI_LICENSE_FILES = LICENCE.broadcom_bcm43xx

# If you ever need to adjust the symlinks below, you may find handy the
# following one-liner (adjust "-not" and "-name" options as needed):
# find firmware/brcm/* -type l -not -name *.hcd -exec sh -c 'echo ln -sf $(readlink $1) \$\(TARGET_DIR\)/lib/$1' _ {} \;

ifeq ($(BR2_PACKAGE_BRCMFMAC_SDIO_FIRMWARE_RPI_BT),y)
define BRCMFMAC_SDIO_FIRMWARE_RPI_INSTALL_TARGET_BT
	$(INSTALL) -d $(TARGET_DIR)/lib/firmware/brcm
	$(INSTALL) -m 0644 $(@D)/firmware/brcm/BCM43430A1.hcd $(TARGET_DIR)/lib/firmware/brcm
	$(INSTALL) -m 0644 $(@D)/firmware/brcm/BCM43430B0.hcd $(TARGET_DIR)/lib/firmware/brcm
	$(INSTALL) -m 0644 $(@D)/firmware/brcm/BCM4345C0.hcd $(TARGET_DIR)/lib/firmware/brcm
	$(INSTALL) -m 0644 $(@D)/firmware/brcm/BCM4345C5.hcd $(TARGET_DIR)/lib/firmware/brcm
	ln -sf BCM43430A1.hcd $(TARGET_DIR)/lib/firmware/brcm/BCM43430A1.raspberrypi,3-model-b.hcd
	ln -sf ../synaptics/SYN43430A1.hcd $(TARGET_DIR)/lib/firmware/brcm/BCM43430A1.raspberrypi,model-zero-2-w.hcd
	ln -sf BCM43430A1.hcd $(TARGET_DIR)/lib/firmware/brcm/BCM43430A1.raspberrypi,model-zero-w.hcd
	ln -sf ../synaptics/SYN43430B0.hcd $(TARGET_DIR)/lib/firmware/brcm/BCM43430B0.raspberrypi,model-zero-2-w.hcd
	ln -sf BCM4345C0.hcd $(TARGET_DIR)/lib/firmware/brcm/BCM4345C0.raspberrypi,3-model-a-plus.hcd
	ln -sf BCM4345C0.hcd $(TARGET_DIR)/lib/firmware/brcm/BCM4345C0.raspberrypi,3-model-b-plus.hcd
	ln -sf BCM4345C0.hcd $(TARGET_DIR)/lib/firmware/brcm/BCM4345C0.raspberrypi,4-compute-module.hcd
	ln -sf BCM4345C0.hcd $(TARGET_DIR)/lib/firmware/brcm/BCM4345C0.raspberrypi,4-model-b.hcd
	ln -sf BCM4345C0.hcd $(TARGET_DIR)/lib/firmware/brcm/BCM4345C0.raspberrypi,5-model-b.hcd
	ln -sf BCM4345C5.hcd $(TARGET_DIR)/lib/firmware/brcm/BCM4345C5.raspberrypi,400.hcd
	ln -sf BCM4345C5.hcd $(TARGET_DIR)/lib/firmware/brcm/BCM4345C5.raspberrypi,4-compute-module.hcd
	$(INSTALL) -d $(TARGET_DIR)/lib/firmware/synaptics
	$(INSTALL) -m 0644 $(@D)/firmware/synaptics/*.hcd $(TARGET_DIR)/lib/firmware/synaptics
endef
endif

ifeq ($(BR2_PACKAGE_BRCMFMAC_SDIO_FIRMWARE_RPI_WIFI),y)
define BRCMFMAC_SDIO_FIRMWARE_RPI_INSTALL_TARGET_WIFI
	$(INSTALL) -d $(TARGET_DIR)/lib/firmware/brcm
	$(INSTALL) -m 0644 $(@D)/firmware/brcm/brcmfmac* $(TARGET_DIR)/lib/firmware/brcm
	ln -sf brcmfmac43436-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430b0-sdio.raspberrypi,model-zero-2-w.bin
	ln -sf brcmfmac43436-sdio.clm_blob $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430b0-sdio.raspberrypi,model-zero-2-w.clm_blob
	ln -sf brcmfmac43436-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430b0-sdio.raspberrypi,model-zero-2-w.txt
	ln -sf ../cypress/cyfmac43430-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.bin
	ln -sf ../cypress/cyfmac43430-sdio.clm_blob $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.clm_blob
	ln -sf ../cypress/cyfmac43430-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.raspberrypi,3-model-b.bin
	ln -sf ../cypress/cyfmac43430-sdio.clm_blob $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.raspberrypi,3-model-b.clm_blob
	ln -sf brcmfmac43430-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.raspberrypi,3-model-b.txt
	ln -sf brcmfmac43436s-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.raspberrypi,model-zero-2-w.bin
	ln -sf brcmfmac43436s-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.raspberrypi,model-zero-2-w.txt
	ln -sf ../cypress/cyfmac43430-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.raspberrypi,model-zero-w.bin
	ln -sf ../cypress/cyfmac43430-sdio.clm_blob $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.raspberrypi,model-zero-w.clm_blob
	ln -sf brcmfmac43430-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43430-sdio.raspberrypi,model-zero-w.txt
	ln -sf brcmfmac43436-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43436-sdio.raspberrypi,model-zero-2-w.bin
	ln -sf brcmfmac43436-sdio.clm_blob $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43436-sdio.raspberrypi,model-zero-2-w.clm_blob
	ln -sf brcmfmac43436-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43436-sdio.raspberrypi,model-zero-2-w.txt
	ln -sf brcmfmac43436s-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43436s-sdio.raspberrypi,model-zero-2-w.bin
	ln -sf brcmfmac43436s-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43436s-sdio.raspberrypi,model-zero-2-w.txt
	ln -sf ../cypress/cyfmac43455-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.bin
	ln -sf ../cypress/cyfmac43455-sdio.clm_blob $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.clm_blob
	ln -sf ../cypress/cyfmac43455-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,3-model-a-plus.bin
	ln -sf ../cypress/cyfmac43455-sdio.clm_blob $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,3-model-a-plus.clm_blob
	ln -sf brcmfmac43455-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,3-model-a-plus.txt
	ln -sf ../cypress/cyfmac43455-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.bin
	ln -sf ../cypress/cyfmac43455-sdio.clm_blob $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.clm_blob
	ln -sf brcmfmac43455-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.txt
	ln -sf ../cypress/cyfmac43455-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,4-compute-module.bin
	ln -sf ../cypress/cyfmac43455-sdio.clm_blob $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,4-compute-module.clm_blob
	ln -sf brcmfmac43455-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,4-compute-module.txt
	ln -sf ../cypress/cyfmac43455-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.bin
	ln -sf ../cypress/cyfmac43455-sdio.clm_blob $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.clm_blob
	ln -sf brcmfmac43455-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,4-model-b.txt
	ln -sf ../cypress/cyfmac43455-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,5-model-b.bin
	ln -sf ../cypress/cyfmac43455-sdio.clm_blob $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,5-model-b.clm_blob
	ln -sf brcmfmac43455-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43455-sdio.raspberrypi,5-model-b.txt
	ln -sf brcmfmac43456-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43456-sdio.raspberrypi,400.bin
	ln -sf brcmfmac43456-sdio.clm_blob $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43456-sdio.raspberrypi,400.clm_blob
	ln -sf brcmfmac43456-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43456-sdio.raspberrypi,400.txt
	ln -sf brcmfmac43456-sdio.bin $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43456-sdio.raspberrypi,4-compute-module.bin
	ln -sf brcmfmac43456-sdio.clm_blob $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43456-sdio.raspberrypi,4-compute-module.clm_blob
	ln -sf brcmfmac43456-sdio.txt $(TARGET_DIR)/lib/firmware/brcm/brcmfmac43456-sdio.raspberrypi,4-compute-module.txt
	$(INSTALL) -d $(TARGET_DIR)/lib/firmware/cypress
	$(INSTALL) -m 0644 $(@D)/firmware/cypress/cyfmac* $(TARGET_DIR)/lib/firmware/cypress
endef
endif

define BRCMFMAC_SDIO_FIRMWARE_RPI_INSTALL_TARGET_CMDS
	$(BRCMFMAC_SDIO_FIRMWARE_RPI_INSTALL_TARGET_BT)
	$(BRCMFMAC_SDIO_FIRMWARE_RPI_INSTALL_TARGET_WIFI)
endef

$(eval $(generic-package))
