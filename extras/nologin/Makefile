TOP = $(CURDIR)/../..
include ../COMMON
include ../EXTRAS

nologin_VERSION = local

CFLAGS ?= -O2

config: 
	mkdir -p $(O)

$(O)nologin: nologin.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

build: $(O)nologin

install:
	$(install) -m 555 $(O)/nologin /sbin



include ../RULES
