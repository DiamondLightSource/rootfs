TOP = $(CURDIR)/../..
include ../COMMON

strace_VERSION ?= 4.5.17

MD5_SUM_4.5.17 = 60f50358eeb19cadabef53b548df2732
MD5_SUM_4.5.18 = e9449fcee97e6a8ed73934c883c870e0

PATCHES_4.5.17 = strace-4.5.17-arm.patch


config:
	cd $(O)  &&  \
        $(srcdir)/configure CFLAGS='$(CFLAGS)' \
            --host=$(COMPILER_PREFIX) --build=$(BUILD_TYPE)

build:
	make -C $(O)

install:
	$(install) -m 555 $(O)/strace /usr/bin


include ../RULES
