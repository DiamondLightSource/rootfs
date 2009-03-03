TOP = $(CURDIR)/../..
include ../COMMON

screen_VERSION ?= 4.0.3

TAR_EXTENSION = .tar.gz
MD5_SUM_4.0.3 = 8506fd205028a96c741e4037de6e3c42

PATCHES_4.0.3 = configure-4.0.3.patch


config:
	cd $(srcdir)  &&  $(AUTOCONF) -o $(O)/configure
	cd $(O)  &&  \
        ./configure --srcdir=$(srcdir) CFLAGS='$(CFLAGS)' \
            --host=$(COMPILER_PREFIX) --build=$(BUILD_TYPE)

build:
	make -C $(O)

install:
	$(install) -s -m-w $(O)/screen /usr/bin


include ../RULES
