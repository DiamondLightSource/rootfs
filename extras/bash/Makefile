TOP = $(CURDIR)/../..
include ../COMMON

bash_VERSION ?= 3.2

TAR_EXTENSION = .tar.gz
MD5_SUM_3.2 = 00bfa16d58e034e3c2aa27f390390d30


config: 
	cd $(O)  &&  \
        $(srcdir)/configure --host=$(COMPILER_PREFIX) CFLAGS='$(CFLAGS)' 

build:
	make -C $(O)

install:
	$(install) $(O)/bash /bin

# EXTRA_LIBS = libdl


include ../RULES
