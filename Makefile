BOARD=rpi3
# BOARD=rpi0
# BOARD=docker
BUILDROOT_VERSION=2017.05
RBE_VERSION=0.1.0

.PHONY: all
all: usage

usage:
	@echo "RaspberryMatic Build Environment (RBE) Version ${RBE_VERSION}"
	@echo "Usage:"
	@echo "	make dist: install buildroot and create default RaspberryMatic Image"
	@echo "	make install of=/dev/sdX: write image to SD card under /dev/sdX"
	@echo "	make distclean: clean everything"

buildroot-$(BUILDROOT_VERSION).tar.bz2:
	wget http://git.buildroot.net/buildroot/snapshot/buildroot-$(BUILDROOT_VERSION).tar.bz2

BUILDROOT_PATCHES=$(wildcard buildroot-patches/*.patch)

buildroot-$(BUILDROOT_VERSION): | buildroot-$(BUILDROOT_VERSION).tar.bz2
	if [ ! -d $@ ]; then tar xf buildroot-$(BUILDROOT_VERSION).tar.bz2; for p in $(BUILDROOT_PATCHES); do patch -d buildroot-$(BUILDROOT_VERSION) -p1 < $${p}; done; fi

build-raspmatic_$(BOARD): | buildroot-$(BUILDROOT_VERSION) download
	mkdir -p build-raspmatic_$(BOARD)

download: buildroot-$(BUILDROOT_VERSION)
	mkdir -p download

build-raspmatic_$(BOARD)/.config: | build-raspmatic_$(BOARD) buildroot-external/configs/raspmatic_$(BOARD)_defconfig
	cd build-raspmatic_$(BOARD) && make O=`pwd` -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external raspmatic_$(BOARD)_defconfig

dist: | buildroot-$(BUILDROOT_VERSION) build-raspmatic_$(BOARD)/.config
	cd build-raspmatic_$(BOARD) && make O=`pwd` -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external

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
	sudo -- /bin/sh -c 'dd if=build-raspmatic_$(BOARD)/images/sdcard.img of=$(of) bs=4096 && sync'

menuconfig: buildroot-$(BUILDROOT_VERSION) build-raspmatic_$(BOARD)
	cd build-raspmatic_$(BOARD) && make O=`pwd` -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external menuconfig

savedefconfig: buildroot-$(BUILDROOT_VERSION) build-raspmatic_$(BOARD)
	cd build-raspmatic_$(BOARD) && make O=`pwd` -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external savedefconfig BR2_DEFCONFIG=../buildroot-external/configs/raspmatic_$(BOARD)_defconfig

linux-menuconfig: buildroot-$(BUILDROOT_VERSION) build-raspmatic_$(BOARD)
	cd build-raspmatic_$(BOARD) && make linux-menuconfig

linux-update-defconfig: buildroot-$(BUILDROOT_VERSION) build-raspmatic_$(BOARD)
	cd build-raspmatic_$(BOARD) && make linux-update-defconfig

busybox-menuconfig: buildroot-$(BUILDROOT_VERSION) build-raspmatic_$(BOARD)
	cd build-raspmatic_$(BOARD) && make busybox-menuconfig

busybox-update-config: buildroot-$(BUILDROOT_VERSION) build-raspmatic_$(BOARD)
	cd build-raspmatic_$(BOARD) && make busybox-update-config
