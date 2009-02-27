TOP = $(CURDIR)/../..
include ../COMMON

procinfo_VERSION ?= 18

TAR_EXTENSION = .tar.gz
MD5_SUM_18 = 27658d0a69040aca05a65b9888599d50


build:
	make -C $(O) -f $(srcdir)/Makefile \
            CFLAGS='$(CFLAGS)' CC=$(COMPILER_PREFIX)-gcc VPATH=$(srcdir) \
            LDLIBS=-lncurses

install:
	$(install) -m 555 $(O)/procinfo /usr/bin


include ../RULES
