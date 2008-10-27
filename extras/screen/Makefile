TOP = $(CURDIR)/../..
include ../COMMON

screen_VERSION ?= 4.0.3

TAR_EXTENSION = .tar.gz
MD5_SUM_4.0.3 = 8506fd205028a96c741e4037de6e3c42

PATCHES_4.0.3 = 100-cross_compile_fix.patch


config: 
	cd $(srcdir)  &&  ./configure --host=$(COMPILER_PREFIX)

build:
	make -C $(srcdir)

install:
	$(install) $(srcdir)/screen /usr/bin 


include ../RULES
