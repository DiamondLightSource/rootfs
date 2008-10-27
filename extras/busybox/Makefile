TOP = $(CURDIR)/../..
include ../COMMON

busybox_VERSION ?= 1.12.0

MD5_SUM_1.11.1 = c64bbb5c0c3e19f12892941a0ae86c48
MD5_SUM_1.12.0 = 427a4802f27f04484e0833307f0a7844
# If no config specified, use one we prepared earlier.
busybox_CONFIG ?= $(CURDIR)/configs/busybox-$(version).config

INETD_ENABLE ?= Y


export CROSS_COMPILE = $(COMPILER_PREFIX)-

config: 
	mkdir -p $(O)
	cp $(busybox_CONFIG) $(O)/.config
	make O=$(O) -C $(srcdir) oldconfig

build: 
	make -C $(O)
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
