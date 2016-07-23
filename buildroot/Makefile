board=raspberrypi3
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

buildroot-$(BUILDROOT_VERSION): buildroot-$(BUILDROOT_VERSION).tar.bz2
	tar xf buildroot-$(BUILDROOT_VERSION).tar.bz2

build/.config: buildroot-$(BUILDROOT_VERSION)
	mkdir -p build
	cp Config.${board} build/.config

patch_buildroot:
	cp cmdline.txt buildroot-${BUILDROOT_VERSION}/package/rpi-firmware
#	cp Config.in buildroot-${BUILDROOT_VERSION}/package
#	ln -fs ${PWD}/packages/homematic buildroot-${BUILDROOT_VERSION}/package

dist: buildroot-$(BUILDROOT_VERSION) build/.config patch_buildroot
	cd build && make O=`pwd` -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external

clean:
	rm -rf build buildroot-$(BUILDROOT_VERSION)

distclean: clean
	rm -f buildroot-$(BUILDROOT_VERSION).tar.bz2

xconfig: buildroot-$(BUILDROOT_VERSION) build/.config patch_buildroot
	cd build && make O=`pwd` -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../buildroot-external xconfig
