TOP = $(CURDIR)/../..
include ../COMMON

nano_VERSION ?= 2.0.9

TAR_EXTENSION = .tar.gz
MD5_SUM_2.0.9 = 2be94dc43fb60fff4626a2401a977220


config: 
	cd $(srcdir)  &&  ./configure --host=$(COMPILER_PREFIX) 

build:
	make -C $(srcdir)

install:
	$(install) -m 555 $(srcdir)/src/nano /usr/bin 


include ../RULES
