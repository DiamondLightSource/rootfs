TOP = $(CURDIR)/../..
include ../COMMON

export CROSS_COMPILE = $(COMPILER_PREFIX)-

MD5_SUM_1.11.1 = c64bbb5c0c3e19f12892941a0ae86c48
MD5_SUM_1.12.0 = 427a4802f27f04484e0833307f0a7844

# If no config specified, use one we prepared earlier.
busybox_CONFIG ?= $(CURDIR)/configs/busybox-$(version).config


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
	$(install) /bin $(O)/busybox
	chmod 555 $(sysroot)/bin/busybox
	chmod u+s $(sysroot)/bin/busybox
	cat $(O)/busybox.links | \
        while read -r; do \
            ln -s /bin/busybox $(sysroot)/$$REPLY  ||  exit 1; \
        done


include ../RULES
