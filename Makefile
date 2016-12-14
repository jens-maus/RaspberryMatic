BOARD=raspberrypi3
# BOARD=X86_32_docker
BUILDROOT_VERSION=2016.05
RBE_VERSION=0.1.0

all: usage

usage:
	@echo "RaspberryMatic Build Environment (RBE) Version ${RBE_VERSION}"
	@echo "Usage:"
	@echo "	make dist: install buildroot and create default RaspberryMatic Image"
	@echo "	make distclean: clean everything"

buildroot-$(BUILDROOT_VERSION).tar.bz2:
	wget http://git.buildroot.net/buildroot/snapshot/buildroot-$(BUILDROOT_VERSION).tar.bz2

BUILDROOT_PATCHES=$(wildcard patches/*.patch)

buildroot-$(BUILDROOT_VERSION): buildroot-$(BUILDROOT_VERSION).tar.bz2
	if [ ! -d $@ ]; then tar xf buildroot-$(BUILDROOT_VERSION).tar.bz2; patch -d buildroot-$(BUILDROOT_VERSION) -p1 < $(BUILDROOT_PATCHES); fi

build-$(BOARD)/.config: buildroot-$(BUILDROOT_VERSION)
	mkdir -p build-$(BOARD)
	mkdir -p download
	cp Config.$(BOARD) build-$(BOARD)/.config

dist: buildroot-$(BUILDROOT_VERSION) build-$(BOARD)/.config
	cd build-$(BOARD) && make O=`pwd` -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external

clean:
	rm -rf build-$(BOARD) buildroot-$(BUILDROOT_VERSION)

distclean: clean
	rm -f buildroot-$(BUILDROOT_VERSION).tar.bz2

mount:
	sudo kpartx -av build-$(BOARD)/images/sdcard.img
	sudo mkdir -p /mnt/p2
	sudo mount /dev/mapper/loop0p2 /mnt/p2

umount:
	sudo umount /mnt/p2
	sudo kpartx -dv build-$(BOARD)/images/sdcard.img

xconfig: buildroot-$(BUILDROOT_VERSION) build-$(BOARD)/.config
	cd build-$(BOARD) && make O=`pwd` -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external xconfig && cp .config ../Config.$(BOARD)

menuconfig: buildroot-$(BUILDROOT_VERSION) build-$(BOARD)/.config
	cd build-$(BOARD) && make O=`pwd` -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external menuconfig && cp .config ../Config.$(BOARD)
