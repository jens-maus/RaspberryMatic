BUILDROOT_VERSION=2020.05
BUILDROOT_EXTERNAL=buildroot-external
DEFCONFIG_DIR=$(BUILDROOT_EXTERNAL)/configs
OCCU_VERSION=$(shell grep "OCCU_VERSION =" buildroot-external/package/occu/occu.mk | cut -d' ' -f3 | cut -d'-' -f1)
DATE=$(shell date +%Y%m%d)
PRODUCT=
PRODUCT_VERSION=${OCCU_VERSION}.${DATE}
PRODUCTS:=$(sort $(notdir $(patsubst %_defconfig,%,$(wildcard $(DEFCONFIG_DIR)/*_defconfig))))
BR2_DL_DIR="../download"

ifneq ($(PRODUCT),)
	PRODUCTS:=$(PRODUCT)
else
	PRODUCT:=$(firstword $(PRODUCTS))
endif

.NOTPARALLEL: $(PRODUCTS) $(addsuffix -release, $(PRODUCTS)) $(addsuffix -clean, $(PRODUCTS)) build-all clean-all release-all
.PHONY: all build release clean cleanall distclean help updatePkg

all: help

buildroot-$(BUILDROOT_VERSION).tar.bz2:
	@echo "[downloading buildroot-$(BUILDROOT_VERSION).tar.bz2]"
	wget https://buildroot.org/downloads/buildroot-$(BUILDROOT_VERSION).tar.bz2
	wget https://buildroot.org/downloads/buildroot-$(BUILDROOT_VERSION).tar.bz2.sign
	cat buildroot-$(BUILDROOT_VERSION).tar.bz2.sign | grep SHA1: | sed 's/^SHA1: //' | shasum -c

buildroot-$(BUILDROOT_VERSION): | buildroot-$(BUILDROOT_VERSION).tar.bz2
	@echo "[patching buildroot-$(BUILDROOT_VERSION)]"
	if [ ! -d $@ ]; then tar xf buildroot-$(BUILDROOT_VERSION).tar.bz2; for p in $(wildcard buildroot-patches/*.patch); do patch -d buildroot-$(BUILDROOT_VERSION) -p1 < $${p}; done; fi

build-$(PRODUCT): | buildroot-$(BUILDROOT_VERSION) download
	mkdir -p build-$(PRODUCT)

download: buildroot-$(BUILDROOT_VERSION)
	mkdir -p download

build-$(PRODUCT)/.config: | build-$(PRODUCT)
	@echo "[config $@]"
	cd build-$(PRODUCT) && $(MAKE) O=$(shell pwd)/build-$(PRODUCT) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../$(BUILDROOT_EXTERNAL) BR2_DL_DIR=$(BR2_DL_DIR) PRODUCT=$(PRODUCT) PRODUCT_VERSION=$(PRODUCT_VERSION) $(PRODUCT)_defconfig

build-all: $(PRODUCTS)
$(PRODUCTS): %:
	@echo "[build: $@]"
	@$(MAKE) PRODUCT=$@ PRODUCT_VERSION=$(PRODUCT_VERSION) build

build: | buildroot-$(BUILDROOT_VERSION) build-$(PRODUCT)/.config
	@echo "[build: $(PRODUCT)]"
	cd build-$(PRODUCT) && $(MAKE) O=$(shell pwd)/build-$(PRODUCT) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../$(BUILDROOT_EXTERNAL) BR2_DL_DIR=$(BR2_DL_DIR) PRODUCT=$(PRODUCT) PRODUCT_VERSION=$(PRODUCT_VERSION)

release-all: $(addsuffix -release, $(PRODUCTS))
$(addsuffix -release, $(PRODUCTS)): %:
	@$(MAKE) PRODUCT=$(subst -release,,$@) PRODUCT_VERSION=$(PRODUCT_VERSION) release

release: build
	@echo "[creating release: $(PRODUCT)]"
	$(eval BOARD := $(shell echo $(PRODUCT) | cut -d'_' -f2))
	cp -a build-$(PRODUCT)/images/sdcard.img ./release/RaspberryMatic-$(PRODUCT_VERSION)-$(BOARD).img
	cd ./release && sha256sum RaspberryMatic-$(PRODUCT_VERSION)-$(BOARD).img >RaspberryMatic-$(PRODUCT_VERSION)-$(BOARD).img.sha256
	rm -f ./release/RaspberryMatic-$(PRODUCT_VERSION)-$(BOARD).zip
	cd ./release && zip --junk-paths ./RaspberryMatic-$(PRODUCT_VERSION)-$(BOARD).zip ./RaspberryMatic-$(PRODUCT_VERSION)-$(BOARD).img ./RaspberryMatic-$(PRODUCT_VERSION)-$(BOARD).img.sha256 ../LICENSE ./updatepkg/$(PRODUCT)/EULA.*
	cd ./release && sha256sum RaspberryMatic-$(PRODUCT_VERSION)-$(BOARD).zip >RaspberryMatic-$(PRODUCT_VERSION)-$(BOARD).zip.sha256

updatePkg:
	rm -rf /tmp/$(PRODUCT)-$(PRODUCT_VERSION) 2>/dev/null; mkdir -p /tmp/$(PRODUCT)-$(PRODUCT_VERSION)
	for f in `cat release/updatepkg/$(PRODUCT)/files-package.txt`; do ln -s $(shell pwd)/release/updatepkg/$(PRODUCT)/$${f} /tmp/$(PRODUCT)-$(PRODUCT_VERSION)/; done
	for f in `cat release/updatepkg/$(PRODUCT)/files-images.txt`; do gzip -c $(shell pwd)/build-$(PRODUCT)/images/$${f} >/tmp/$(PRODUCT)-$(PRODUCT_VERSION)/$${f}.gz; done
	cd /tmp/$(PRODUCT)-$(PRODUCT_VERSION); sha256sum * >$(PRODUCT)-$(PRODUCT_VERSION).sha256
	cd ./release; tar -C /tmp/$(PRODUCT)-$(PRODUCT_VERSION) --owner=root --group=root -cvzhf $(PRODUCT)-$(PRODUCT_VERSION).tgz `ls /tmp/$(PRODUCT)-$(PRODUCT_VERSION)`

clean-all: $(addsuffix -clean, $(PRODUCTS))
$(addsuffix -clean, $(PRODUCTS)): %:
	@$(MAKE) PRODUCT=$(subst -clean,,$@) PRODUCT_VERSION=$(PRODUCT_VERSION) clean

clean:
	@echo "[clean $(PRODUCT)]"
	@rm -rf build-$(PRODUCT)

distclean: clean-all
	@echo "[distclean]"
	@rm -rf buildroot-$(BUILDROOT_VERSION)
	@rm -f buildroot-$(BUILDROOT_VERSION).tar.bz2
	@rm -rf download

.PHONY: menuconfig
menuconfig: buildroot-$(BUILDROOT_VERSION) build-$(PRODUCT)
	cd build-$(PRODUCT) && $(MAKE) O=$(shell pwd)/build-$(PRODUCT) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../$(BUILDROOT_EXTERNAL) BR2_DL_DIR=$(BR2_DL_DIR) PRODUCT=$(PRODUCT) PRODUCT_VERSION=$(PRODUCT_VERSION) menuconfig

.PHONY: xconfig
xconfig: buildroot-$(BUILDROOT_VERSION) build-$(PRODUCT)
	cd build-$(PRODUCT) && $(MAKE) O=$(shell pwd)/build-$(PRODUCT) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../$(BUILDROOT_EXTERNAL) BR2_DL_DIR=$(BR2_DL_DIR) PRODUCT=$(PRODUCT) PRODUCT_VERSION=$(PRODUCT_VERSION) xconfig

.PHONY: savedefconfig
savedefconfig: buildroot-$(BUILDROOT_VERSION) build-$(PRODUCT)
	cd build-$(PRODUCT) && $(MAKE) O=$(shell pwd)/build-$(PRODUCT) -C ../buildroot-$(BUILDROOT_VERSION) BR2_EXTERNAL=../$(BUILDROOT_EXTERNAL) BR2_DL_DIR=$(BR2_DL_DIR) PRODUCT=$(PRODUCT) PRODUCT_VERSION=$(PRODUCT_VERSION) savedefconfig BR2_DEFCONFIG=../$(DEFCONFIG_DIR)/$(PRODUCT)_defconfig

# Create a fallback target (%) to forward all unknown target calls to the build Makefile.
# This includes:
#   linux-menuconfig
#   linux-update-defconfig
#   busybox-menuconfig
#   busybox-update-config
#   uboot-menuconfig
#   uboot-update-defconfig
linux-menuconfig linux-update-defconfig busybox-menuconfig busybox-update-config uboot-menuconfig uboot-update-defconfig:
	@echo "[$@ $(PRODUCT)]"
	@$(MAKE) -C build-$(PRODUCT) PRODUCT=$(PRODUCT) PRODUCT_VERSION=$(PRODUCT_VERSION) $@

help:
	@echo "HomeMatic/CCU Build Environment"
	@echo
	@echo "Usage:"
	@echo "  $(MAKE) <product>: build+create image for selected product"
	@echo "  $(MAKE) build-all: run build for all supported products"
	@echo
	@echo "  $(MAKE) <product>-release: build+create release archive for product"
	@echo "  $(MAKE) release-all: build+create release archive for all supported products"
	@echo
	@echo "  $(MAKE) <product>-clean: remove build directory for product"
	@echo "  $(MAKE) clean-all: remove build directories for all supproted platforms"
	@echo
	@echo "  $(MAKE) distclean: clean everything (all build dirs and buildroot sources)"
	@echo
	@echo "Supported products: $(PRODUCTS)"
