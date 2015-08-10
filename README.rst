Root Filesystem Building Tool
=============================

This software package consists of a set of scripts and packages for building a
minimal Linux distribution.  This system is used at Diamond Light Source (DLS)
for a number of ARM and PowerPC based embedded systems.

This system is very much in the spirit of buildroot, not as well developed,
quite a lot smaller, and about the same age!  Alas, the current version of this
tool has a number of DLS dependencies hard-wired, but this is published in the
hope that it may be of more general use.

A target configuration is a simple set of assignments in makefile macro syntax,
for example::

    TOOLCHAIN = arm-xscale

    PACKAGES += busybox

    CONSOLE_TTY = ttyS0
    CONSOLE_BAUD = 115200

Building this, with the command ``./rootfs TARGET=minimal``, will create a
complete bootable root file system using the default busybox configuration with
the controlling terminal as configured.

The resulting build is pretty small, less than 4MB.  A smaller build could be
achieved with the use of uClibc, but we've not had a requirement for this.

To get started:

1.  Run ``make -C docs`` to build the detailed documentation.  You are welcome
    to contact the author with questions and bug reports.

2.  Copy ``CONFIG.example`` to ``CONFIG.local`` and edit ``ROOTFS_ROOT`` and
    ``TAR_DIRS`` to point to sensible locations.

    ``ROOTFS_ROOT``
        The entire build process will be done under this directory, and the
        final build will be placed in::

        $(ROOTFS_ROOT)/targets/$(TARGET)/image/imagefile.cpio

    ``TAR_DIRS``
        The rootfs build scripts will not make any attempt to download the
        sources, instead they need to be available in one of the directories
        defined by this symbol.

3.  Populate ``$(TAR_DIRS)``.  As a minimum, the following files (as of the time
    of writing) will need to be downloaded from their appropriate download
    locations:

        autoconf-2.69.tar.gz, automake-1.15.tar.gz, libtool-2.4.6.tar.gz,
        m4-1.4.17.tar.gz, pkg-config-0.28.tar.gz, busybox-1.23.2.tar.bz2

    together with the sources for any other packages needed.

4.  Run ``./rootfs make``.

As this tool has been developed to run on an enterprise system with quite old
tools (Red Hat Enterprise Linux 6), it is necessary to make our own builds of a
number of standard tools to help with building some packages.
