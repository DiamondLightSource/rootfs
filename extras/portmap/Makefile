TOP = $(CURDIR)/../..
include ../COMMON

portmap_VERSION ?= 6.0

TAR_EXTENSION = .tgz
SOURCE_SEPARATOR = _
SOURCE_DIR_NAME = $(COMPONENT)_$(version)

MD5_SUM_6.0 = ac108ab68bf0f34477f8317791aaf1ff

PATCHES_6.0 = exclude-libwrap-6.0.patch out-of-tree.patch

PORTMAP_PROGRAMS = portmap pmap_dump pmap_set


build:
	make -C $(O) -f $(srcdir)/Makefile $(PORTMAP_PROGRAMS) \
            srcdir=$(srcdir) VPATH=$(srcdir) \
            CC=$(COMPILER_PREFIX)-gcc CFLAGS='$(CFLAGS)' NO_TCP_WRAPPER=y

install:
	$(install) -s -m-w $(PORTMAP_PROGRAMS:%=$(O)/%) /sbin
	$(startup) $(CURDIR)/portmap S180


include ../RULES
