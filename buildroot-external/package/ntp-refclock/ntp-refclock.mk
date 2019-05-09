#############################################################
#
# ntp-refclock from https://github.com/mlichvar/ntp-refclock
#
#############################################################

NTP_REFCLOCK_VERSION = 64cb80b25836c9240c776782525c78eaadb47583
NTP_REFCLOCK_SITE = $(call github,mlichvar,ntp-refclock,$(NTP_REFCLOCK_VERSION))
NTP_REFCLOCK_LICENSE_FILES = COPYRIGHT.ntp-refclock
NTP_REFCLOCK_EXTRA_DOWNLOADS = https://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2.8p13.tar.gz

define NTP_REFCLOCK_BUILD_CMDS
	rm -rf $(@D)/ntpd
	mkdir $(@D)/ntpd
	tar -C $(@D)/ntpd -xf $(NTP_REFCLOCK_DL_DIR)/ntp-4.2.8p13.tar.gz --strip-components=1
	( cd $(@D)/ntpd; $(TARGET_CONFIGURE_OPTS) ./configure --host=arm-buildroot-linux-gnueabihf --enable-all-clocks --enable-parse-clocks --disable-ATOM --disable-SHM --disable-LOCAL-CLOCK --without-crypto --without-threads --without-sntp; $(TARGET_MAKE_ENV) $(MAKE) )
	$(TARGET_MAKE_ENV) $(TARGET_CONFIGURE_OPTS) $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" CFLAGS="$(TARGET_CFLAGS)" LDFLAGS="$(TARGET_LDFLAGS)" -C $(@D) NTP_SRC=$(@D)/ntpd DEFAULT_USER=root DEFAULT_ROOTDIR=/
endef

define NTP_REFCLOCK_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/ntp-refclock $(TARGET_DIR)/usr/sbin/ntp-refclock
endef

$(eval $(generic-package))
