TOP = $(CURDIR)/../..
include ../COMMON

portmap_VERSION ?= 6.0

TAR_EXTENSION = .tgz
SOURCE_DIR_NAME = $(COMPONENT)_$(version)

MD5_SUM_6.0 = ac108ab68bf0f34477f8317791aaf1ff

PATCHES_6.0 = exclude-libwrap-6.0.patch


build:
	make -C $(srcdir) CC=$(COMPILER_PREFIX)-gcc NO_TCP_WRAPPER=y

install:
	for file in portmap pmap_dump pmap_set; do \
            $(install) -m-w $(srcdir)/$$file /sbin; \
        done

	$(startup) $(CURDIR)/portmap S180


include ../RULES
