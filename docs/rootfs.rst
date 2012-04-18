.. _rootfs:
.. default-role:: literal

Root File System Builder
========================

Introduction to the rootfs distribution builder.  This document should be the
first reference when using and developing Linux distributions using the rootfs
builder.  See the following further references, or jump straight to
:ref:`quick-start` if you are impatient.

* :doc:`extras`.  This is a list of all the available packages currently
  available in the rootfs.

* :doc:`options`.  The detailed configuration of the rootfs is managed through
  "options".

* :doc:`build-extras`.  This describes in some detail how the build process for
  packages works and what needs to be done to add a new package to the list.

* :doc:`notes`.

* :doc:`internals`.

* :doc:`glibc`.  Some notes on the glibc libraries and how rootfs handles them.


Introduction
------------

The **rootfs** system is intended to provide a simple to manage mechanism for
building a complete but minimal bootable Linux distribution, excluding the
kernel which must be built separately.  Building a rootfs involves the
following steps, all of which are automated by this set of scripts.

1.  Building packages to be installed on the target system.  The process assumes
    that `busybox` is one of the packages installed.

2.  Assembling a complete rootfs image, consisting of a complete system
    directory tree following (though not conforming to) the `Filesystem
    Hierarchy Standard <http://www.pathname.com/fhs/>`_.  This involves the
    following steps:

    - Create directory tree skeleton.
    - Install all selected packages in the directory tree.
    - Install the necessary libraries from glic.
    - Complete the configuration of the rootfs including startup script
      configuration.

3.  Building the bootstrap package and deploying to the selected target
    location.

The rootfs scripts assume that the following have already been generated:

1.  Toolchain, consisting of cross-compiler and associated tools, and complete
    run-time library.  The toolchain is specified as part of target
    configuration by specifying two symbols: `BINUTILS_DIR` and
    `COMPILER_PREFIX`, or a predefined toolkit can be selected from the
    `toolchain` directory.

2.  Kernel.  The kernel is not managed by the rootfs builder, but depending on
    the precise bootstrap mechanism the target configuration can specify
    information about the kernel.

Configuration and specification of a rootfs build requires that the following
be specified:

* File locations for rootfs, including workspace and toolkit locations.  This is
  specified in a configuration file (`CONFIG.local`) that is either placed in
  the root directory of the rootfs builder, or is specified (as the symbol
  `ROOTFS_CONFIG`) on the command line or as an environment variable.

* Package specifications (largely already integrated into `rootfs`).

* Target configuration, including toolchain specification.  The target
  configuration specifies in turn the list of packages to be included in a built
  rootfs and the toolchain to be used to build the packages.


.. _quick-start:

Quick Start
-----------

We'll go through the process of building an existing example rootfs, called
`example` in this case.  To build this, change to a convenient working directory
and execute the following commands::

    svn co $SVN_ROOT/diamond/trunk/targetOS/rootfs
    cd rootfs
    cp CONFIG.example CONFIG.local
    ./rootfs toolkit
    ./rootfs all
    ./rootfs make

`svn co $SVN_ROOT/diamond/trunk/targetOS/rootfs`
    Note that the rootfs is designed to be run without modifying any local
    files, so that if a "production" release of rootfs exists this can be used
    instead of checking out a local copy.  See the note on `CONFIG.local` first,
    though.

`cp CONFIG.example CONFIG.local`
    The `CONFIG.local` file can be used to override some of the default
    behaviour of the `rootfs` command, in particular here we want to specify
    where `rootfs` will place its working files (configured by the `ROOTFS_ROOT`
    symbol definition) and the default `TARGET`.

    If running `rootfs` out of a read only directory then a local copy of
    `CONFIG.local` can be created and used by running the commands below before
    running `rootfs`::

        export ROOTFS_ROOT=~/local/path/CONFIG.local
        cp /path/to/rootfs/CONFIG.example $ROOTFS_ROOT

`./rootfs toolkit`
    The rootfs needs a "toolkit" of useful utilities.  This only needs to be
    built once for any given `ROOTFS_ROOT`.

`./rootfs all`
    This executes the first step of assembling the rootfs: all the packages
    required by the target (in this case, just busybox) will be built for the
    selected target.  To build for a different target, specify `TARGET` on the
    command line, for example::

        ./rootfs all TARGET=colibri

    Note that when changing the configuration of a selected rootfs it is not
    normally necessary to rebuild the packages.

`./rootfs make`
    This completes the assembly of the rootfs and pushes it out to the selected
    boot target.  In this case two u-boot images, including a script, are pushed
    out to the configured tftp server: see `configs/example/CONFIG` for details.



Running the Rootfs Builder
--------------------------

The rootfs builder is run through the `rootfs` command in the top directory of
the rootfs builder.  This command is a very thin wrapper over the makefiles in
the `scripts` directory which do all the work.

Running the rootfs builder requires the following steps.

* Specify rootfs file locations.
* Build the toolkit components.
* Build the selected target packages.
* Build the selected target.

For the final two steps a target configuration must be specified by setting
the symbol `TARGET`, either in the `CONFIG.local` file or on the command line.


`rootfs` Command
~~~~~~~~~~~~~~~~

The `rootfs` command supports the operations listed below.  One of the most
important actions of this command is to ensure that the symbol `ROOTFS_TOP` is
set to the directory containing the rootfs build system.  This allows `rootfs`
to be invoked from outside the directory, and so allows extra packages and
configurations to be added at build time.

`rootfs help`
    Shows help text.

`rootfs toolkit`
    Builds the toolkit prerequisites.  This should only need to be done once for
    any particular `ROOTFS_ROOT` configuration.

`rootfs docs`
    Builds the documentation (runs `make` in the `docs` directory).

`rootfs package` *<package>*
    Builds the named *<package>* for the configured target.

`rootfs all`
    Builds all packages for the configured target.

`rootfs make`
    Assembles the configured rootfs for the selected target.

`rootfs imagename`
    Prints the full path to the generated rootfs .cpio image file.


The following extra parameters can be passed on the command line to many of
the commands above to override the default makefile definitions.

`ROOTFS_CONFIG`
    Location of the rootfs configuration file.  This should define any further
    overrides needed.  If no `ROOTFS_CONFIG` is specifed then configuration will
    be read from a `CONFIG.local` file in the root directory of the rootfs if
    present.

`TARGET`
    A default build target can be specified in the `CONFIG.local` file, but this
    can be overridden by passing a `TARGET` definition on the command line.
    This can be given in one of two formats:

    `TARGET=`\ *<target-name>*
        If the *<target-name>* is not a path (does not contain a `/` character)
        it must name one of the configurations in the rootfs `configs`
        directory.

    `TARGET=`\ *<target-path>*
        If *<target-path>* is a path it should name a directory containing a
        target description, and in this case the last component on the path will
        be used to name the build.

    Note that `TARGET` has no meaning for the `rootfs toolkit` command and will
    be ignored in this case.


Configuring the Rootfs
~~~~~~~~~~~~~~~~~~~~~~

A number of directories and other make symbols must be specified for the
rootfs builder to operate.  As noted above, these can be overridden or updated
in a `CONFIG.local` file (read from `$(ROOTFS_TOP)/CONFIG.local` or specified on
the command line).  The list below documents some symbols that can be specified
in this file and their default values.


`ROOTFS_ROOT = /scratch/tmp/rootfs`
    This specifies the root of the workspace used by rootfs.  By default all
    rootfs files are built under this directory.

`TOOLKIT_ROOT = $(ROOTFS_ROOT)/toolkit`
    This contains local installations of the tools required for the operation of
    rootfs.

`SOURCE_ROOT = $(ROOTFS_ROOT)/src`
    All source files, including both package and toolkit sources, will be
    extracted to this directory and patched in-place.  All builds will treat
    this directory as read-only, and will be "out of tree".

`TARGET_ROOT = $(ROOTFS_ROOT)/targets/$(TARGET)`
    This is where the entire target specific rootfs build will take place.

`TAR_DIRS = /dls_sw/prod/targetOS/tar-files`
    All source packages will be searched for in directories specified by this
    symbol.


Building the Toolkit
~~~~~~~~~~~~~~~~~~~~

This is simply a matter of running the command `rootfs toolkit` in the rootfs
top level directory.  This will populate the configured toolkit directory with
the necessary tools required for a reproducible build, including the following
components:

`fakeroot`
    This is needed to assemble the target filesystem (the "rootfs").

`autoconf`, `automake`, `libtool`, `m4`
    These tools are needed by some packages after patching configuration files.


Building Target Packages
~~~~~~~~~~~~~~~~~~~~~~~~

The `rootfs` sub-commands `all` and `package` support the building of packages,
see :doc:`build-extras` for details.  The simplest usage is to invoke `rootfs
all` which will ensure that all packages are built.

Note that the target package building process is not particularly intelligent
about detecting whether a package has already been built, and in general
packages will be rebuilt from scratch when the appropriate command is invoked.

The general form of these commands is::

    rootfs all [<target>] [ROOTFS_CONFIG=<config>] [TARGET=<target>]
    rootfs package <package> [<target>] [ROOTFS_CONFIG=<config>] [TARGET=<target>]


Possible values for '<target>' are:

`default`
    Default selection if no target specified: invokes `untar`, `config`, `build`
    and `install-lib`.

`untar`
    Extracts sources for the selected package (or packages) into
    `$(SOURCE_ROOT)` and applies any configured patches.

`config`
    Runs the configured configure step, necessary preparation for building.

`build`
    Compiles the selected package.

`install-lib`
    If the package generates libraries needed by other packages, this installs
    the libraries in `$(LIB_PREFIX)` ready to be used.

The following targets are useful for tidying things up.

`clean`
    Removes all built files including all configured settings.

`clean-src`
    Removes the extracted and patched source directory.

`clean-all`
    Invoked `clean` and `clean-src`.


Building Target System
~~~~~~~~~~~~~~~~~~~~~~

This is literally simply a matter of running the command `rootfs make`.  The
resulting rootfs is assembled into a `.cpio` file which is placed in
`$(TARGET_ROOT)/imagefile.cpio`.  Depending on how the `BOOT` parameter is
configured in the target configuration, this is then packaged for booting and
possibly copied to a testing destination.


Specifying a Target Configuration
---------------------------------

Target configurations can be quite complicated.  Here we discuss the
configuration in `configs/example/CONFIG` in a little detail.  The configuration
here is this::

    TOOLCHAIN = arm-xscale
    PACKAGES += busybox
    busybox_VERSION = 1.14.3
    OPTIONS += network-mtd
    ROOTFS_VERSION = Example rootfs
    CONSOLE_BAUD = 9600
    CONSOLE_TTY = ttyS0
    ROOT_PASSWORD = example
    TERMS = xterm xterm-color screen vt100 vt102
    BOOT = initramfs
    BOOT_LOADER = u-boot
    MKIMAGE = /dls_sw/targetOS/u-boot/colibri/mkimage
    KERNEL_NAME = uImage-colibri
    KERNEL_ADDR = a0001000
    IMAGE_ADDR = a2000000
    TFTP_SERVER = serv3:/tftpboot

The individual settings here are discussed in detail below.

`TOOLCHAIN`
    The toolchain used to build the components of the rootfs must be specified.
    Possible values are any entry in the `toolchain` directory, or alternatively
    the symbols `COMPILER_PREFIX` and `BINUTILS_DIR` can be specified.

`PACKAGES`
    This is set to a list of all the packages to be included in the rootfs
    build.  The `busybox` package **must** be included.  A package specification
    can be any directory name in the `packages` directory, or a path to a
    directory containing a package specification.  See :doc:`build-extras` for
    details on configuring packages.

    Installing `dropbear` as well is normally a good idea.

`busybox_VERSION`
    Each package specifies a default version, or as shown in this example, the
    version can be overridden by a statement of this form.

`OPTIONS`
    This is set to a list of "options" used to configure the detailed behaviour
    of the rootfs.  In this case we have selected the `network-mtd` option which
    configures the network from u-boot settings on the target device.

    An option can be any entry in the `options` directory.

`ROOTFS_VERSION`
    This is set to a string used to identify the build version.  This string is
    written to `/etc/version` in the target rootfs.

`CONSOLE_BAUD`, `CONSOLE_TTY`
    These are used to configure the console tty, and must be set to values
    compatible with the boot loader and kernel configuration, otherwise output
    from the console will vanish as soon as the console login tty is started!

`ROOT_PASSWORD`
    The root password for the target system.

`TERMS`
    List of terminal configurations installed on the target system.

`BOOT`
    This configures what happens to the rootfs after the serialised image
    `imagefile.cpio` has been generated, and can be set to any value (except for
    `COMMON`) in the `boot` directory.

    In this case the `initramfs` option selects a ramfs boot from the configured
    TFTP server, and all the parameters below are used by this particular boot
    option.

`BOOT_LOADER`
    This states that the target system uses u-boot as its boot loader.
    Currently this is the only boot loader supported by rootfs, but not all
    `BOOT` configurations require this symbol.  In this case we expect the
    target system to have the following configuration::

        baudrate=9600
        gatewayip=172.23.240.254
        netmask=255.255.240.0
        serverip=172.23.240.3
        bootargs=console=ttyS0,9600n8
        hostname=example
        ipaddr=172.23.252.19
        bootcmd=tftpboot a0000000 boot-script-example.image && autoscr a0000000

`MKIMAGE`
    Specifies the program used to create u-boot images.

`KERNEL_NAME`
    Name of the kernel image to be loaded from the TFTP server.

`KERNEL_ADDR`, `IMAGE_ADDR`
    Locations in system memory used by u-boot to load the kernel and rootfs
    images.

`TFTP_SERVER`
    TFTP server to which the generated files will be written.


Creating a Release
------------------

Released snapshots of rootfs are installed under `/dls_sw/prod/targetOS/rootfs`
and include prebuilt copies of the toolkit in a hidden `.toolkit` subdirectory.
To create a release run the command::

    scripts/release/release $VERSION

where `$VERSION` is the release number to be created.  Note that the release
process uses the `queue-job` command.
