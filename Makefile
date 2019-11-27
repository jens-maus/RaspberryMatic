PRODUCT=raspmatic_rpi3
BUILDROOT_VERSION=2019.08.2
BUILDROOT_EXTERNAL=buildroot-external
DEFCONFIG_DIR=$(BUILDROOT_EXTERNAL)/configs
VERSION=$(shell cat ./VERSION)
BOARD=$(shell echo $(PRODUCT) | cut -d'_' -f2)
PRODUCTS:=$(notdir $(patsubst %_defconfig,%,$(wildcard $(DEFCONFIG_DIR)/*_defconfig)))

.NOTPARALLEL: all
.PHONY: all build release clean distclean help

all: build

buildroot-$(BUILDROOT_VERSION).tar.bz2:
	@echo "[downloading buildroot-$(BUILDROOT_VERSION).tar.bz2]"
	wget https://buildroot.org/downloads/buildroot-$(BUILDROOT_VERSION).tar.bz2
	wget https://buildroot.org/downloads/buildroot-$(BUILDROOT_VERSION).tar.bz2.sign
	cat buildroot-$(BUILDROOT_VERSION).tar.bz2.sign | grep SHA1: | sed 's/^SHA1: //' | shasum -c

buildroot-$(BUILDROOT_VERSION): | buildroot-$(BUILDROOT_VERSION).tar.bz2
	@echo "[patching $(BUILDROOT_VERSION)]"
	if [ ! -d $@ ]; then tar xf buildroot-$(BUILDROOT_VERSION).tar.bz2; for p in $(wildcard buildroot-patches/*.patch); do patch -d buildroot-$(BUILDROOT_VERSION) -p1 < $${p}; done; fi

build-$(PRODUCT): | buildroot-$(BUILDROOT_VERSION) download
	mkdir -p build-$(PRODUCT)

download: buildroot-$(BUILDROOT_VERSION)
	mkdir -p download

build-$(PRODUCT)/.config: | build-$(PRODUCT)
	cd build-$(PRODUCT) && $(MAKE) O=$(shell pwd)/build-$(PRODUCT) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../$(BUILDROOT_EXTERNAL) PRODUCT=$(PRODUCT) $(PRODUCT)_defconfig

build: | buildroot-$(BUILDROOT_VERSION) build-$(PRODUCT)/.config
	@echo "[building: $(PRODUCT)]"
	cd build-$(PRODUCT) && $(MAKE) O=$(shell pwd)/build-$(PRODUCT) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../$(BUILDROOT_EXTERNAL) PRODUCT=$(PRODUCT)

release: build
	@echo "[createing release: $(PRODUCT)]"
	cp -a build-$(PRODUCT)/images/sdcard.img ./release/RaspberryMatic-$(VERSION)-$(BOARD).img
	cd ./release && sha256sum RaspberryMatic-$(VERSION)-$(BOARD).img >RaspberryMatic-$(VERSION)-$(BOARD).img.sha256
	rm -f ./release/RaspberryMatic-$(VERSION)-$(BOARD).zip
	cd ./release && zip --junk-paths ./RaspberryMatic-$(VERSION)-$(BOARD).zip ./RaspberryMatic-$(VERSION)-$(BOARD).img ./RaspberryMatic-$(VERSION)-$(BOARD).img.sha256 ../LICENSE ./updatepkg/$(PRODUCT)/EULA.*
	cd ./release && sha256sum RaspberryMatic-$(VERSION)-$(BOARD).zip >RaspberryMatic-$(VERSION)-$(BOARD).zip.sha256

.PHONY: updatePkg
updatePkg:
	rm -rf /tmp/$(PRODUCT)-$(VERSION) 2>/dev/null; mkdir -p /tmp/$(PRODUCT)-$(VERSION)
	for f in `cat release/updatepkg/$(PRODUCT)/files-package.txt`; do ln -s $(shell pwd)/release/updatepkg/$(PRODUCT)/$${f} /tmp/$(PRODUCT)-$(VERSION)/; done
	for f in `cat release/updatepkg/$(PRODUCT)/files-images.txt`; do gzip -c $(shell pwd)/build-$(PRODUCT)/images/$${f} >/tmp/$(PRODUCT)-$(VERSION)/$${f}.gz; done
	cd /tmp/$(PRODUCT)-$(VERSION); sha256sum * >$(PRODUCT)-$(VERSION).sha256
	cd ./release; tar -C /tmp/$(PRODUCT)-$(VERSION) --owner=root --group=root -cvzhf $(PRODUCT)-$(VERSION).tgz `ls /tmp/$(PRODUCT)-$(VERSION)`

.PHONY: clean
clean:
	rm -rf build-$(PRODUCT) buildroot-$(BUILDROOT_VERSION)

.PHONY: distclean
distclean: clean
	rm -f buildroot-$(BUILDROOT_VERSION).tar.bz2
	rm -rf download

.PHONY: menuconfig
menuconfig: buildroot-$(BUILDROOT_VERSION) build-$(PRODUCT)
	cd build-$(PRODUCT) && $(MAKE) O=$(shell pwd)/build-$(PRODUCT) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../$(BUILDROOT_EXTERNAL) PRODUCT=$(PRODUCT) menuconfig

.PHONY: xconfig
xconfig: buildroot-$(BUILDROOT_VERSION) build-$(PRODUCT)
	cd build-$(PRODUCT) && $(MAKE) O=$(shell pwd)/build-$(PRODUCT) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../$(BUILDROOT_EXTERNAL) PRODUCT=$(PRODUCT) xconfig

.PHONY: savedefconfig
savedefconfig: buildroot-$(BUILDROOT_VERSION) build-$(PRODUCT)
	cd build-$(PRODUCT) && $(MAKE) O=$(shell pwd)/build-$(PRODUCT) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../$(BUILDROOT_EXTERNAL) PRODUCT=$(PRODUCT) savedefconfig BR2_DEFCONFIG=../$(DEFCONFIG_DIR)/$(PRODUCT)_defconfig

# Create a fallback target (%) to forward all unknown target calls to the build Makefile.
# This includes:
#   linux-menuconfig
#   linux-update-defconfig
#   busybox-menuconfig
#   busybox-update-config
#   uboot-menuconfig
#   uboot-update-defconfig
%:
	@$(MAKE) -C build-$(PRODUCT) PRODUCT=$(PRODUCT) $@

help:
	@echo "Usage:"
	@echo "  $(MAKE) PRODUCT=<product> dist: install buildroot and create default image"
	@echo "  $(MAKE) PRODUCT=<product> release: create image and corresponding release archive"
	@echo "  $(MAKE) distclean: clean everything"
	@echo
	@echo "Supported products: $(PRODUCTS)"
