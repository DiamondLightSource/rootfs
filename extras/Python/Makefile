TOP = $(CURDIR)/../..
include ../COMMON

Python_VERSION ?= 2.6

MD5_SUM_2.5.2 = afb5451049eda91fbde10bd5a4b7fadc
MD5_SUM_2.6   = 837476958702cb386c657b5dba61cdc5

PATCHES_2.6 = Python2.6-configure.patch

# Python is rather tedious -- we need to build it twice!  The problem is, we
# need a working copy of Python for the target build.
O-target = $(O)/target
O-build = $(O)/build

config:
	mkdir -p $(O-target) $(O-build)

        # Configure the target.  For this we need to take the patched
        # configuration into account.
	cd $(srcdir)  &&  $(AUTOCONF) -o $(O-target)/configure
	cd $(O-target)  &&  \
        ./configure --srcdir=$(srcdir) CFLAGS='$(CFLAGS)' \
             --host=$(COMPILER_PREFIX) --build=$(BUILD_TYPE)

        # Also configure the build so we can make a local build.  For this we
        # can use the stock configuration.
	cd $(O-build)  &&  $(srcdir)/configure

$(O-build)/python:
	make -C $(O-build) python Parser/pgen

build: $(O-build)/python
	make -C $(O-target) \
            HOSTPYTHON=$(O-build)/python HOSTPGEN=$(O-build)/Parser/pgen \
            CROSS_COMPILE=yes

install:
	echo Don\'t know what to do here
	false



include ../RULES

# See here for notes on cross-compiling Python (all gleaned from google:
#   cross compiling python)
# http://whatschrisdoing.com/blog/2006/10/06/howto-cross-compile-python-25
# http://www.ailis.de/~k/archives/19-ARM-cross-compiling-howto.html
# http://kegel.com/crosstool/python.html

# Will need to fix up quite a few things which are tested on the local
# machine, for example have
#   AC_CHECK_FILE(/dev/ptmx, AC_DEFINE(HAVE_DEV_PTMX, 1))
# in 2.5 which seems to have mutated into an explicit
#   if test -r /dev/ptmx; then AC_DEFINE(HAVE_DEV_PTMX, 1)
#
# Need to define HAVE_DEV_PTMX and try and catch any others like this.  Maybe
# the simplest thing will be to fudge this test, but properly it should be
# overridden from outside.

# The current build works okish, but we don't know how to install it.
