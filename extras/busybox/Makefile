TOP = $(CURDIR)/../..
include ../COMMON

export CROSS_COMPILE

TAR_FILE = busybox-$(busybox_VERSION).tar.bz2
SOURCE_DIR_NAME = busybox-$(busybox_VERSION)

MD5_SUM_1.11.1 = c64bbb5c0c3e19f12892941a0ae86c48
MD5_SUM_1.12.0 = 427a4802f27f04484e0833307f0a7844

# If no config specified, use one we prepared earlier.
busybox_CONFIG ?= $(CURDIR)/configs/busybox-$(busybox_VERSION).config


config: 
	cp $(busybox_CONFIG) $(O)/.config
	make O=$(O) -C $(srcdir) oldconfig

build: 
	make -C $(O)
	make -C $(O) busybox.links

menuconfig: untar
	make O=$(O) -C $(srcdir) menuconfig

install:
	make -C $(O) CONFIG_PREFIX=$(sysroot) install
	chmod 555 $(sysroot)/bin/busybox
	chmod u+s $(sysroot)/bin/busybox


include ../RULES
