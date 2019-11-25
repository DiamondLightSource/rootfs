.. _build-packages:
.. default-role:: literal

Building and Specifying Packages
================================


Building Packages
-----------------

Packages are built by running the script `rootfs package` or `roofs all`.

`rootfs package` *<package-name>*
    Builds the named package.  This command can be followed by a makefile
    target, which can be one of the following:

    `untar`
        Extracts sources of named package into `$(SOURCE_ROOT)`.

    `build`
        Builds the target and installs in the staging area.  This is the default
        target.

    `clean`, `clean-src`, `clean-lib`, `clean-all`
        Various cleaning targets.  `clean` removes built files, `clean-src`
        removes the extracted and patched source tree, `clean-lib` removes all
        installed library files, and `clean-all` runs all cleaning targets.

    Don't use the `install` target, this is reserved for final rootfs assembly.

`rootfs all`
    Builds all packages configured for the selected target.  This can also be
    followed by a makefile target, which will be passed to each package in turn.
    Packages are built in the order in which they are specified in the target
    configuration.


Specifying a Package
--------------------

Building a package consists of the following steps:

* Extracting the sources and patching them.
* Configuring the build.
* Performing the build.
* Installing the package in the rootfs.

These steps are specified in the package description.  There are two
complications in building packages: building rootfs packages involves
cross-compiling, and the build must be "out of tree", which means that the
source directory should not be modified by the build process.  Achieving both of
these goals often requires patches to the source and configuration.


Specifying sources and patches
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The package description specifies enough information to identify the name of
the package sources.  This is expected to be a single compressed file in tar
gz, bz2 or zip format (see `scripts/extract-tar` for processing) located in
one of the directories specified by `TAR_DIRS`, and should extract into
a single subdirectory.

The default name of the "tar" file and the directory it expands is defined
by the following makefile definitions::

    TAR_EXTENSION = .tar.bz2
    SEPARATOR = -
    TAR_SEPARATOR = $(SEPARATOR)
    SOURCE_SEPARATOR = $(SEPARATOR)
    TAR_FILE = $(COMPONENT)$(TAR_SEPARATOR)$(version)$(TAR_EXTENSION)
    SOURCE_DIR_NAME = $(COMPONENT)$(SOURCE_SEPARATOR)$(version)
    untar-extra = @:
    patch-extra = @:

A package description should overwrite the minimum possible: typically only
`TAR_EXTENSION` needs to be overwritten.  The command `untar-extra` is invoked
immediately after extracting the sources, and can be used to repair source
directories with improper names, for example if the version number is not part
of the source tree name.  See `ntpclient` package for an example of this.
Similarly, `patch-extra` is invoked immediately after applying patches.

Package sources should be properly identified by version, in particular for each
version to be supported there needs to be a definition of the symbol
`MD5_SUM_$(version)` equal to the md5 checksum of the "tar" file.

After sources have been extracted (and corrected by invoking `$(untar-extra)`)
any patches specified by the symbol `PATCHES_$(version)` will be applied.  All
the patches must be in a subdirectory `patches` of the package specification
directory.



Configuring and Performing the Build
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

During the build step the following symbols are provided by the calling makefile
and can be used.

`O`
    This is the path to the directory where the build should take place.

`I`
    This is the path to the staging area where any files needed by the final
    `install` target should be placed.  If possible this can be installed using
    the the packages own `make install` step.

`srcdir`
    This is the path to the extracted sources.  This directory should be treated
    as pristine and not modified.

`COMPILER_PREFIX`
    If the package is being configured for cross-compilation this defines the
    cross compliation prefix.  By default this symbol is exported into the shell
    environment, and the cross-compiler `bin` directory is on the path.

`BUILD_TYPE`
    This is a canonical system name for the build system: the configure script
    often likes to be passed this as the `--build` parameter.

`CFLAGS`
    Set to any complier flags specified in the global configuration script.


The simplest configure and build definition (for example `nano` is as easy as
this) is of the form::

    build:
            cd $(O)  &&  \
            $(srcdir)/configure CFLAGS='$(CFLAGS)' \
                --host=$(COMPILER_PREFIX) --build=$(BUILD_TYPE)
            make -C $(O) install DESTDIR=$(O)

Unfortunately it's sometimes necessary patch the `configure` script, in which
case it has to be rebuilt before being run.  In this case the configure
definition looks more like this (eg `screen`)::

    build:
            cd $(srcdir) && autoconf -o $(O)/configure
            cd $(O) && ./configure --srcdir=$(srcdir) CFLAGS='$(CFLAGS)' \
                --host=$(COMPILER_PREFIX) --build=$(BUILD_TYPE)
            make -C $(O) install DESTDIR=$(O)

In other cases it is necessary to do lots of horribly hacking around to get
the configure to work.


Installation
~~~~~~~~~~~~

Installation is done in two steps:

* Firstly the build must place all the files needed for installation in the
  staging directory $(I).
* The rootfs or target installation can then use these files to populate the
  target system.


Target Installation
^^^^^^^^^^^^^^^^^^^

This installation is performed by the `install` target, and should perform the
minimum possible installation for an embedded install.  During this install the
following makefile symbols are available:

`I`
    Staging area.
`sysroot`
    Location of the rootfs where target files are installed.
`install`
    Install command to place files in the rootfs.
`useradd`, `groupadd`
    Commands for adding users and groups to rootfs.
`startup`
    Installes a startup script into `/etc/init.d` and `/etc/rc.d`.



Building Packages
-----------------

To build packages the following symbols must be defined.

`PACKAGES`
    List of packages to be built.  Normally defined in the target configuration,
    but can also be defined on the command line.




Makefile Symbols
~~~~~~~~~~~~~~~~

`OBJECT_ROOT`
    Path to directory where packages are built

`O`
    Path to particular package directory, `O` = `$(OBJECT_ROOT)/$(COMPONENT)`.
    Only available during `build` step.

`I`
    Path to staging area.


Specifying a Configuration
--------------------------

A configuration consists of the following specifications:

Cross-Compilation Toolchain
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The cross compiler toolchain must be specified by defining at least the
following two symbols:

`COMPILER_PREFIX`
    Compiler tuple to be prefixed before compiler commands, used as the tuple to
    pass to `--host=` on `configure` commands.  This can be empty for native
    compilation.

`SYSROOT`
    This must point to a built libc.  On most toolchains this is found in the
    subdirectory `sys-root` or `libc` under the `$(COMPILER_PREFIX)`
    subdirectory of the installed compiler toolchain.  This directory typically
    contains the `etc`, `lib`, `sbin`, `usr` skeleton, and the libraries are
    used to populate the target rootfs.

The compiler tools, typically `$(COMPILER_PREFIX)-gcc` etc, must be on the path,
or else a third symbol can be defined:

`BINUTILS_DIR`
    Path to the complete toolchain directory.  If this symbol is defined then
    the directory `$(BINUTILS_DIR)/bin` is added to the path.


File Locations
~~~~~~~~~~~~~~

Where to find stuff.


Symbol Definitions
------------------

The package build system is managed through make symbols, and there are many
symbols involved in the process.  They are all documented here, grouped by
role and source.


Parameters to Package Build
~~~~~~~~~~~~~~~~~~~~~~~~~~~

The following are specified where?


`COMPONENT`
    Name of package to build.

`version = $(COMPONENT)_VERSION`
    Version of package to build.  This determines both the name of the
    compressed sources and the source directory.  Typically a default value is
    specified in the package description.

`COMPONENT_PATH = $(ROOTFS_TOP)/packages/$(COMPONENT)`
    Absolute path to package description directory.


Symbols Define in Package Definition
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Symbols that *must* be defined in a package
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Only two symbols need to be defined to build a package: the package version
and the corresponding md5 sum.  A package should define a default version,
which can then be overridden by the target configuration.


`$(PACKAGE)_VERSION`
    Typically a package should define a default version which can be overridden
    by a target configuration, for example `nano` defines ::

        nano_VERSION ?= 2.0.9


`MD5_SUM_$($(PACKAGE)_VERSION)`
    For each supported version the md5 sum of the corresponding source package
    must be given, for example the `nano` package defines ::

        MD5_SUM_2.0.9 = 2be94dc43fb60fff4626a2401a977220

    Compute this by running `md5sum` on the corresponding source file.


Symbols that can optionally be defined
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`TAR_EXTENSION = .tar.bz2`
    Needs to be overridden if the source file is of a different format.

`untar-extra = @:`
    Commands to be executed after extracting source files but before patching.
    Use this rename directories or perform extra extraction operations.

`patch-extra = @:`
    Commands to be executed after patching.  This can be used to rebuild
    configuration files if necessary.


Global Symbols from Rootfs System
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

`ROOTFS_TOP`
    Absolute path to top of rootfs tree.

`BUILD_ROOT`
    Absolute path to where all rootfs files are stored, sets defaults for
    following.

`SOURCE_ROOT = $(BUILD_ROOT)/src`
    Path to extracted and patched sources.

`TOOLKIT_ROOT = $(BUILD_ROOT)/toolkit`
    Path to local prefix for installed toolkit.


Target Specific Definitions
~~~~~~~~~~~~~~~~~~~~~~~~~~~

`TARGET`
    Name of target to build.

`TARGET_PATH = $(ROOTFS_TOP)/configs/$(TARGET)`
    Path to target description directory.

`BUILD_TARGET = $(BUILD_ROOT)/$(TARGET)`
    Path to location where the entire target system is built.  !!!This is a poor
    name, not very consistent with other names!!!

`OBJECT_ROOT = $(BUILD_TARGET)/packages`
    Path to location where all packages are built.

`LIB_ROOT = $(BUILD_TARGET)/local`
    Path to location where libraries are installed.


Other Symbol Definitions
~~~~~~~~~~~~~~~~~~~~~~~~

These symbol definitions are not meant to be overridden, but are important.

`O = $(OBJECT_ROOT)/$(COMPONENT)`
    Individual package build.

`srcdir = $(SOURCE_ROOT)/$(COMPONENT)-$(version)`
    Package sources.  Probably want to enforce consistent naming here, forcing
    the package description to place the sources in the right place if
    necessary.
