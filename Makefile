BOARD=raspmatic_rpi3
# BOARD=raspmatic_rpi0
# BOARD=raspmatic_tinkerboard
# BOARD=raspmatic_docker
BUILDROOT_VERSION=2017.11.2
VERSION=$(shell cat ./VERSION)

.PHONY: all
all: usage

usage:
	@echo "HomeMatic Build Environment"
	@echo "Usage:"
	@echo "	make dist: install buildroot and create default image"
	@echo "	make release: create image and corresponding release archive"
	@echo "	make install of=/dev/sdX: write image to SD card under /dev/sdX"
	@echo "	make distclean: clean everything"

buildroot-$(BUILDROOT_VERSION).tar.bz2:
	wget https://buildroot.org/downloads/buildroot-$(BUILDROOT_VERSION).tar.bz2
	wget https://buildroot.org/downloads/buildroot-$(BUILDROOT_VERSION).tar.bz2.sign
	cat buildroot-$(BUILDROOT_VERSION).tar.bz2.sign | grep SHA1: | sed 's/^SHA1: //' | shasum -c

BUILDROOT_PATCHES=$(wildcard buildroot-patches/*.patch)

buildroot-$(BUILDROOT_VERSION): | buildroot-$(BUILDROOT_VERSION).tar.bz2
	if [ ! -d $@ ]; then tar xf buildroot-$(BUILDROOT_VERSION).tar.bz2; for p in $(BUILDROOT_PATCHES); do patch -d buildroot-$(BUILDROOT_VERSION) -p1 < $${p}; done; fi

build-$(BOARD): | buildroot-$(BUILDROOT_VERSION) download
	mkdir -p build-$(BOARD)

download: buildroot-$(BUILDROOT_VERSION)
	mkdir -p download

build-$(BOARD)/.config: | build-$(BOARD) buildroot-external/configs/$(BOARD)_defconfig
	cd build-$(BOARD) && make O=$(shell pwd)/build-$(BOARD) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external $(BOARD)_defconfig

dist: | buildroot-$(BUILDROOT_VERSION) build-$(BOARD)/.config
	cd build-$(BOARD) && make O=$(shell pwd)/build-$(BOARD) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external

release: dist
	cp -a build-$(BOARD)/images/sdcard.img ./release/RaspberryMatic-$(VERSION)-$(BOARD).img
	sha256sum ./release/RaspberryMatic-$(VERSION)-$(BOARD).img >./release/RaspberryMatic-$(VERSION)-$(BOARD).img.sha256
	rm -f ./release/RaspberryMatic-$(VERSION)-$(BOARD).zip
	cd ./release && zip ./RaspberryMatic-$(VERSION)-$(BOARD).zip ./RaspberryMatic-$(VERSION)-$(BOARD).img ./RaspberryMatic-$(VERSION)-$(BOARD).img.sha256 ../LICENSE
	sha256sum ./release/RaspberryMatic-$(VERSION)-$(BOARD).zip >./release/RaspberryMatic-$(VERSION)-$(BOARD).zip.sha256

clean:
	rm -rf build-$(BOARD) buildroot-$(BUILDROOT_VERSION)

distclean: clean
	rm -f buildroot-$(BUILDROOT_VERSION).tar.bz2
	rm -rf download

mount:
	sudo kpartx -av build-$(BOARD)/images/sdcard.img
	sudo mkdir -p /mnt/p2
	sudo mount /dev/mapper/loop0p2 /mnt/p2

umount:
	sudo umount /mnt/p2
	sudo kpartx -dv build-$(BOARD)/images/sdcard.img

install:
	sudo dd if=build-$(BOARD)/images/sdcard.img of=$(of) bs=1M conv=fsync status=progress

menuconfig: buildroot-$(BUILDROOT_VERSION) build-$(BOARD)
	cd build-$(BOARD) && make O=$(shell pwd)/build-$(BOARD) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external menuconfig

savedefconfig: buildroot-$(BUILDROOT_VERSION) build-$(BOARD)
	cd build-$(BOARD) && make O=$(shell pwd)/build-$(BOARD) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external savedefconfig BR2_DEFCONFIG=../buildroot-external/configs/$(BOARD)_defconfig

linux-menuconfig: buildroot-$(BUILDROOT_VERSION) build-$(BOARD)
	cd build-$(BOARD) && make linux-menuconfig

linux-update-defconfig: buildroot-$(BUILDROOT_VERSION) build-$(BOARD)
	cd build-$(BOARD) && make linux-update-defconfig

busybox-menuconfig: buildroot-$(BUILDROOT_VERSION) build-$(BOARD)
	cd build-$(BOARD) && make busybox-menuconfig

busybox-update-config: buildroot-$(BUILDROOT_VERSION) build-$(BOARD)
	cd build-$(BOARD) && make busybox-update-config
