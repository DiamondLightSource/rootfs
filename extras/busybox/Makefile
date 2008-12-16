TOP = $(CURDIR)/../..
include ../COMMON

busybox_VERSION ?= 1.12.3

MD5_SUM_1.11.1 = c64bbb5c0c3e19f12892941a0ae86c48
MD5_SUM_1.12.0 = 427a4802f27f04484e0833307f0a7844
MD5_SUM_1.12.1 = dc2e5e00d6fee8229ae92884c68733a7
MD5_SUM_1.12.2 = 1a47c00828c7b38b7516f6fdc35800e2
MD5_SUM_1.12.3 = cc4cb0b131e2789ab099edf2b94b2976

# These are all bugfixes downloaded from the busybox site:
#   http://busybox.net/downloads/fixes-1.12.1/
PATCHES_1.12.1 = \
    busybox-1.12.1-basename.patch   \
    busybox-1.12.1-modprobe.patch   \
    busybox-1.12.1-grep.patch       \
    busybox-1.12.1-standalone.patch \
    busybox-1.12.1-lineedit.patch   \
    busybox-1.12.1-vi.patch         \
    busybox-1.12.1-login.patch

# Patches downloaded from http://busybox.net/downloads/fixes-1.12.2/
PATCHES_1.12.2 = \
    busybox-1.12.2-lineedit.patch   \
    busybox-1.12.2-getopt.patch

# Patches downloaded from http://busybox.net/downloads/fixes-1.12.3/
PATCHES_1.12.3 = \
    busybox-1.13.1-printf.patch


# If no config specified, use one we prepared earlier.
busybox_CONFIG ?= $(CURDIR)/busybox-default.config

INETD_ENABLE ?= Y


config:
	cp $(busybox_CONFIG) $(O)/.config
	make O=$(O) -C $(srcdir) oldconfig

build: 
	CFLAGS='$(CFLAGS)' make -C $(O)
	make -C $(O) busybox.links

menuconfig: untar
	make O=$(O) -C $(srcdir) menuconfig

install:
        # 4555 = rx,u+s
	$(install) -m 4555 $(O)/busybox /bin 
	cat $(O)/busybox.links | \
        while read -r; do \
            ln -s /bin/busybox $(sysroot)/$$REPLY  ||  exit 1; \
        done

ifneq ($(INETD_ENABLE),)
	$(install) $(CURDIR)/inetd /etc/init.d
	$(startup) $(CURDIR)/inetd S200
endif


include ../RULES
