TOP = $(CURDIR)/../..
include ../COMMON

procinfo-ng_VERSION ?= 2.0.217

MD5_SUM_2.0.217 = 7c1c05a462988731b0165f0a789f2669

PATCHES_2.0.217 = makefile-2.0.217.patch


config: 
	cd $(O)  &&  \
        $(srcdir)/configure --host=$(COMPILER_PREFIX) CFLAGS='$(CFLAGS)' 

build:
	make -C $(O) VPATH=$(srcdir)

install:
	$(install) -m 555 $(O)/procinfo /usr/bin 


include ../RULES
