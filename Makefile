PRODUCT=raspmatic_rpi3
# PRODUCT=raspmatic_rpi0
# PRODUCT=raspmatic_tinkerboard
# PRODUCT=raspmatic_docker
BUILDROOT_VERSION=2018.02.1
VERSION=$(shell cat ./VERSION)
BOARD=$(shell echo $(PRODUCT) | cut -d'_' -f2)

.PHONY: all
all: usage

.PHONY: usage
usage:
	@echo "HomeMatic Build Environment"
	@echo "Usage:"
	@echo "	$(MAKE) dist: install buildroot and create default image"
	@echo "	$(MAKE) release: create image and corresponding release archive"
	@echo "	$(MAKE) install of=/dev/sdX: write image to SD card under /dev/sdX"
	@echo "	$(MAKE) distclean: clean everything"

buildroot-$(BUILDROOT_VERSION).tar.bz2:
	wget https://buildroot.org/downloads/buildroot-$(BUILDROOT_VERSION).tar.bz2
	wget https://buildroot.org/downloads/buildroot-$(BUILDROOT_VERSION).tar.bz2.sign
	cat buildroot-$(BUILDROOT_VERSION).tar.bz2.sign | grep SHA1: | sed 's/^SHA1: //' | shasum -c

BUILDROOT_PATCHES=$(wildcard buildroot-patches/*.patch)

buildroot-$(BUILDROOT_VERSION): | buildroot-$(BUILDROOT_VERSION).tar.bz2
	if [ ! -d $@ ]; then tar xf buildroot-$(BUILDROOT_VERSION).tar.bz2; for p in $(BUILDROOT_PATCHES); do patch -d buildroot-$(BUILDROOT_VERSION) -p1 < $${p}; done; fi

build-$(PRODUCT): | buildroot-$(BUILDROOT_VERSION) download
	mkdir -p build-$(PRODUCT)

download: buildroot-$(BUILDROOT_VERSION)
	mkdir -p download

build-$(PRODUCT)/.config: | build-$(PRODUCT)
	cd build-$(PRODUCT) && $(MAKE) O=$(shell pwd)/build-$(PRODUCT) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external $(PRODUCT)_defconfig

.PHONY: dist
dist: | buildroot-$(BUILDROOT_VERSION) build-$(PRODUCT)/.config
	cd build-$(PRODUCT) && $(MAKE) O=$(shell pwd)/build-$(PRODUCT) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external

.PHONY: release
release: dist
	cp -a build-$(PRODUCT)/images/sdcard.img ./release/RaspberryMatic-$(VERSION)-$(BOARD).img
	cd ./release && sha256sum RaspberryMatic-$(VERSION)-$(BOARD).img >RaspberryMatic-$(VERSION)-$(BOARD).img.sha256
	rm -f ./release/RaspberryMatic-$(VERSION)-$(BOARD).zip
	cd ./release && zip ./RaspberryMatic-$(VERSION)-$(BOARD).zip ./RaspberryMatic-$(VERSION)-$(BOARD).img ./RaspberryMatic-$(VERSION)-$(BOARD).img.sha256 ../LICENSE
	cd ./release && sha256sum RaspberryMatic-$(VERSION)-$(BOARD).zip >RaspberryMatic-$(VERSION)-$(BOARD).zip.sha256

.PHONY: updateFile
updateFile: dist
	cd buildroot-external/package/eq3-updatefile; tar cvf ../../../build-$(PRODUCT)/images/$(PRODUCT)-$(VERSION).tar -T files-package.txt
	cd build-$(PRODUCT)/images; tar uvf $(PRODUCT)-$(VERSION).tar -T ../../buildroot-external/package/eq3-updatefile/files-images.txt
	cd build-$(PRODUCT)/images; gzip $(PRODUCT)-$(VERSION).tar; mv $(PRODUCT)-$(VERSION).tar.gz $(PRODUCT)-$(VERSION).tgz

.PHONY: clean
clean:
	rm -rf build-$(PRODUCT) buildroot-$(BUILDROOT_VERSION)

.PHONY: distclean
distclean: clean
	rm -f buildroot-$(BUILDROOT_VERSION).tar.bz2
	rm -rf download

.PHONY: mount
mount:
	sudo kpartx -av build-$(PRODUCT)/images/sdcard.img
	sudo mkdir -p /mnt/p2
	sudo mount /dev/mapper/loop0p2 /mnt/p2

.PHONY: unmount
umount:
	sudo umount /mnt/p2
	sudo kpartx -dv build-$(PRODUCT)/images/sdcard.img

.PHONY: install
install:
	sudo dd if=build-$(PRODUCT)/images/sdcard.img of=$(of) bs=1M conv=fsync status=progress

.PHONY: menuconfig
menuconfig: buildroot-$(BUILDROOT_VERSION) build-$(PRODUCT)
	cd build-$(PRODUCT) && $(MAKE) O=$(shell pwd)/build-$(PRODUCT) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external menuconfig

.PHONY: xconfig
xconfig: buildroot-$(BUILDROOT_VERSION) build-$(PRODUCT)
	cd build-$(PRODUCT) && $(MAKE) O=$(shell pwd)/build-$(PRODUCT) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external xconfig

.PHONY: savedefconfig
savedefconfig: buildroot-$(BUILDROOT_VERSION) build-$(PRODUCT)
	cd build-$(PRODUCT) && $(MAKE) O=$(shell pwd)/build-$(PRODUCT) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external savedefconfig BR2_DEFCONFIG=../buildroot-external/configs/$(PRODUCT)_defconfig

# Create a fallback target (%) to forward all unknown target calls to the build Makefile.
# This includes:
#   linux-menuconfig
#   linux-update-defconfig
#   busybox-menuconfig
#   busybox-update-config
#   uboot-menuconfig
#   uboot-update-defconfig
%:
	@$(MAKE) -C build-$(PRODUCT) $@
