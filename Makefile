BOARD=rpi3
# BOARD=rpi0
# BOARD=tinkerboard
# BOARD=docker
BUILDROOT_VERSION=2017.08.1
VERSION=$(shell cat ./VERSION)

.PHONY: all
all: usage

usage:
	@echo "RaspberryMatic Build Environment"
	@echo "Usage:"
	@echo "	make dist: install buildroot and create default RaspberryMatic image"
	@echo "	make release: create RaspberryMatic image and corresponding release archive"
	@echo "	make install of=/dev/sdX: write image to SD card under /dev/sdX"
	@echo "	make distclean: clean everything"

buildroot-$(BUILDROOT_VERSION).tar.bz2:
	wget https://buildroot.org/downloads/buildroot-$(BUILDROOT_VERSION).tar.bz2
	wget https://buildroot.org/downloads/buildroot-$(BUILDROOT_VERSION).tar.bz2.sign
	cat buildroot-$(BUILDROOT_VERSION).tar.bz2.sign | grep SHA1: | sed 's/^SHA1: //' | shasum -c

BUILDROOT_PATCHES=$(wildcard buildroot-patches/*.patch)

buildroot-$(BUILDROOT_VERSION): | buildroot-$(BUILDROOT_VERSION).tar.bz2
	if [ ! -d $@ ]; then tar xf buildroot-$(BUILDROOT_VERSION).tar.bz2; for p in $(BUILDROOT_PATCHES); do patch -d buildroot-$(BUILDROOT_VERSION) -p1 < $${p}; done; fi

build-raspmatic_$(BOARD): | buildroot-$(BUILDROOT_VERSION) download
	mkdir -p build-raspmatic_$(BOARD)

download: buildroot-$(BUILDROOT_VERSION)
	mkdir -p download

build-raspmatic_$(BOARD)/.config: | build-raspmatic_$(BOARD) buildroot-external/configs/raspmatic_$(BOARD)_defconfig
	cd build-raspmatic_$(BOARD) && make O=$(shell pwd)/build-raspmatic_$(BOARD) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external raspmatic_$(BOARD)_defconfig

dist: | buildroot-$(BUILDROOT_VERSION) build-raspmatic_$(BOARD)/.config
	cd build-raspmatic_$(BOARD) && make O=$(shell pwd)/build-raspmatic_$(BOARD) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external

release: dist
	cp -a build-raspmatic_$(BOARD)/images/sdcard.img ./release/RaspberryMatic-$(VERSION)-$(BOARD).img
	sha256sum ./release/RaspberryMatic-$(VERSION)-$(BOARD).img >./release/RaspberryMatic-$(VERSION)-$(BOARD).img.sha256
	rm -f ./release/RaspberryMatic-$(VERSION)-$(BOARD).zip
	cd ./release && zip ./RaspberryMatic-$(VERSION)-$(BOARD).zip ./RaspberryMatic-$(VERSION)-$(BOARD).img ./RaspberryMatic-$(VERSION)-$(BOARD).img.sha256 ../LICENSE
	sha256sum ./release/RaspberryMatic-$(VERSION)-$(BOARD).zip >./release/RaspberryMatic-$(VERSION)-$(BOARD).zip.sha256

clean:
	rm -rf build-raspmatic_$(BOARD) buildroot-$(BUILDROOT_VERSION)

distclean: clean
	rm -f buildroot-$(BUILDROOT_VERSION).tar.bz2
	rm -rf download

mount:
	sudo kpartx -av build-raspmatic_$(BOARD)/images/sdcard.img
	sudo mkdir -p /mnt/p2
	sudo mount /dev/mapper/loop0p2 /mnt/p2

umount:
	sudo umount /mnt/p2
	sudo kpartx -dv build-raspmatic_$(BOARD)/images/sdcard.img

install:
	sudo dd if=build-raspmatic_$(BOARD)/images/sdcard.img of=$(of) bs=8K conv=sync status=progress

menuconfig: buildroot-$(BUILDROOT_VERSION) build-raspmatic_$(BOARD)
	cd build-raspmatic_$(BOARD) && make O=$(shell pwd)/build-raspmatic_$(BOARD) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external menuconfig

savedefconfig: buildroot-$(BUILDROOT_VERSION) build-raspmatic_$(BOARD)
	cd build-raspmatic_$(BOARD) && make O=$(shell pwd)/build-raspmatic_$(BOARD) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external savedefconfig BR2_DEFCONFIG=../buildroot-external/configs/raspmatic_$(BOARD)_defconfig

linux-menuconfig: buildroot-$(BUILDROOT_VERSION) build-raspmatic_$(BOARD)
	cd build-raspmatic_$(BOARD) && make linux-menuconfig

linux-update-defconfig: buildroot-$(BUILDROOT_VERSION) build-raspmatic_$(BOARD)
	cd build-raspmatic_$(BOARD) && make linux-update-defconfig

busybox-menuconfig: buildroot-$(BUILDROOT_VERSION) build-raspmatic_$(BOARD)
	cd build-raspmatic_$(BOARD) && make busybox-menuconfig

busybox-update-config: buildroot-$(BUILDROOT_VERSION) build-raspmatic_$(BOARD)
	cd build-raspmatic_$(BOARD) && make busybox-update-config
