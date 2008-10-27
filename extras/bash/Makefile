TOP = $(CURDIR)/../..
include ../COMMON

bash_VERSION ?= 3.2

TAR_EXTENSION = .tar.gz
MD5_SUM_3.2 = 00bfa16d58e034e3c2aa27f390390d30


config: 
	cd $(srcdir)  &&  ./configure --host=$(COMPILER_PREFIX) 

build:
	make -C $(srcdir)

install:
	$(install) $(srcdir)/bash /bin

# EXTRA_LIBS = libdl


include ../RULES
