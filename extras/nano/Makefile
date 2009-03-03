TOP = $(CURDIR)/../..
include ../COMMON

nano_VERSION ?= 2.0.9

TAR_EXTENSION = .tar.gz
MD5_SUM_2.0.9 = 2be94dc43fb60fff4626a2401a977220

config:
	cd $(O)  &&  \
        $(srcdir)/configure CFLAGS='$(CFLAGS)' \
            --host=$(COMPILER_PREFIX) --build=$(BUILD_TYPE)

build:
	make -C $(O)

install:
	$(install) -s -m-w $(O)/src/nano /usr/bin


include ../RULES
