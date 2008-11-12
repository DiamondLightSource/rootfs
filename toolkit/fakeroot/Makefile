TOP = $(CURDIR)/../..
include ../COMMON

fakeroot_VERSION ?= 1.7.1

TAR_FILE = fakeroot_$(version).tar.gz
MD5_SUM_1.7.1  = 3654bbbf01deeb0d804df194e1b1a2b3
MD5_SUM_1.10.1 = 052a1b5474b3681bc5f3167d2b3711a8


config: 
	cd $(O)  &&  $(srcdir)/configure --prefix=$(TOOLKIT_ROOT)

build:
	make -C $(O)

install: config build
        # Actually we probably only want fakeroot libfakeroot-0.so.
	make -C $(O) install
	cp $(srcdir)/config.guess $(TOOLKIT_ROOT)/bin


include ../RULES
