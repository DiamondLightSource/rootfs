TOP = $(CURDIR)/../..
include ../COMMON

lsof_VERSION ?= 4.81

SEPARATOR = _
MD5_SUM_4.81 = c482bda0764a8e618f87682347b22a87

lsof_srcdir = $(srcdir)/lsof_$(version)_src

define untar-extra
tar xf $(lsof_srcdir).tar -C $(srcdir)
endef


# Using the proper ./Configure script is rather excruciating, and it just
# doesn't work out of tree.  So instead we hack the build environment
# horribly so that things work properly.
#
# This means at least that we don't have to do anything to the source tree,
# not even the smallest patch!

# It's a little tricky to see which configurations we need.  GLIBCV just
# needs to be defined (any value will do), and I think the _FILE_OFFSET_BITS
# flag tells us that off_t is 64 bits.
BUILD_CFGF = -DGLIBCV=207 -DHAS_STRFTIME -D_FILE_OFFSET_BITS=64

# The -iquote option below ensures that certain header files are not mistaken
# for system header files.
BUILD_ENV = \
    CC=$(CROSS_COMPILE)gcc \
    LIB=lib/liblsof.a \
    CFGF='$(BUILD_CFGF)' \
    CFGL='-L./lib -llsof' \
    DEBUG='$(CFLAGS)' \
    VPATH='$(lsof_srcdir):$(lsof_srcdir)/lib' \
    DINC='-iquote$(O)/lib -iquote$(O) -iquote$(lsof_srcdir)'

BUILD_LIB_ENV = \
    AR='ar cr $$(LIB) $$(OBJ)' \
    RANLIB='ranlib $$(LIB)' \
    CFLAGS='$$(CDEFS) $$(INCL) $$(DEBUG)'


config:
	mkdir -p $(O)/lib
	ln -sf $(lsof_srcdir)/dialects/linux/*.c $(O)
	ln -sf $(lsof_srcdir)/dialects/linux/*.h $(O)
	ln -sf $(lsof_srcdir)/lib/Makefile.skel $(O)/lib/Makefile
	echo ".ds VN $(version)" >$(O)/version

build:
	$(BUILD_ENV) $(BUILD_LIB_ENV) \
        make -C $(O) -f $(lsof_srcdir)/dialects/linux/Makefile

install:
	$(install) -s -m a-w,u+s $(O)/lsof /usr/bin


include ../RULES
