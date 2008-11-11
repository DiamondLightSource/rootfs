TOP = $(CURDIR)/../..
include ../COMMON

autoconf_VERSION ?= 2.63

MD5_SUM_2.63 = 7565809ed801bb5726da0631ceab3699


config: 
	cd $(O)  &&  \
        M4=$(TOOLKIT_BIN)/m4 $(srcdir)/configure --prefix=$(OBJECT_ROOT) 

build:
	make -C $(O)

install: config build
	make -C $(O) install


include ../RULES
