.. _extras:
.. default-role:: literal

Selectable Packages
===================

A number of existing projects have been configured to be cross-compiled for
rootfs.  Packages are selected for inclusion in a build by adding their names to
the `PACKAGES` symbol.  Any rootfs build should normally include the following
packages:

`busybox`
    This is required for all rootfs operation, there's no point in trying to
    build without this without significant rework.

`dropbear`
    Provides ssh access.

`ntp`
    Time synchronisation.

`portmap`
    Needed for NTP file locking to work properly.


List of Available Packages
--------------------------

The following packages can be included in any rootfs build.

`arping`
    Web page: http://www.habets.pp.se/synscan/programs.php?prog=arping

    ARP ping tool, but actually not so useful, as already built into `busybox`.

    Depends on both `libnet` and `libpcap` to build, simple example of building
    a package with library dependencies.

`bash`
    Web page: http://www.gnu.org/software/bash

    The standard bash shell, but rather large.  Don't recommend using this,
    instead work within the reasonable limitations of the busybox shell.

`busybox`
    Web page: http://www.busybox.net/

    Collection of basic utilities.  This provides pretty well everything needed
    to build a complete system and is mandatory for rootfs.

`conserver`
    Web page: http://www.conserver.com/

    Tool for logging console output.  Probably much simpler to use `procServ`
    and an external logging mechanism for most applications.

`dropbear`
    Web page: http://matt.ucc.asn.au/dropbear/dropbear.html

    Small ssh server and client, highly recommended.

`i2c-tools`
    Web page: http://www.lm-sensors.org/wiki/I2CTools

    Simple suite of tools for probing devices on the I2C bus.  An example of
    highly invasive patching for building.

`inotify-tools`
    Web page: https://github.com/rvoicilas/inotify-tools/wiki/

    Simple command line interface to inotify(7).  Alas the build is currently
    thoroughly broken, looks quite difficult to fix for out of tree build.

`libnet`
    Web page: http://packetfactory.openwall.net/projects/libnet/

    Packet construction library, used by `arping`.  Rather confusingly, there
    seem to be two completely different versions of this library, it looks as if
    the version at http://libnet.sourceforge.net/ is out of date.

`libpcap`
    Web page: http://www.tcpdump.org/

    Low level package capture interface library needed by `tcpdump` and
    `arping`.

`lm_sensors`
    Web page: http://www.lm-sensors.org

    Not sure that this tool is terribly useful.  Provides `sensors` tool for
    displaying information about some sensor devices.

`lshw`
    Web page: http://ezix.org/project/wiki/HardwareLiSter

    Lists available hardware, but not a greate match for embedded systems.

`lsof`
    Web page: http://people.freebsd.org/~abe/

    Lists all open files.  Can be very useful, worth including in the build.

    This is an instructive example of a particularly horrible build.  This build
    takes a lot of modification to build out of tree.

`ltrace`
    Web page: http://ltrace.alioth.debian.org/

    Trace library calls.  Unfortunately broken for ARM, at least on recent
    kernels.

`lua`
    Web page: http://www.lua.org/

    Lua the language.  A very small embeddable language.  Depends on `readline`.

`mtd-utils`
    Web page: http://www.linux-mtd.infradead.org/source.html

    Download from: ftp://ftp.infradead.org/pub/mtd-utils

    Git repository: git://git.infradead.org/mtd-utils.git

    Needed for jffs2 support.  We only build `flash_eraseall` and `flashcp`.

`nano`
    Web page: http://www.nano-editor.org/

    Small editor.  It's probably best to stick with `vi` from busybox.  A
    canonical example of a simple build that just works.

`nfs-utils`
    Web page: http://linux-nfs.org and http://nfs.sourceforge.net

    Hopefully to fill in some missing busybox functions for NFS mounts.  This
    has been succesfully built (with a surprising amount of effort required) but
    not yet installed or tried.

    If we want to export an nfs filesystem we'll want this.

`ntp`
    Web page: http://www.ntp.org/

    The definitive NTP clock synchronisation reference implementation.
    Rather large, but very functional.  Use this package.

`ntpclient`
    Web page: http://doolittle.icarus.com/ntpclient/

    Microscopic ntp client.  The writer of this also refers to xntpd, and links
    to a detailed man page, but I can't find a download.  Probably too small to
    be useful, but here for testing.

`openntpd`
    Web page: http://www.openntpd.org/

    OpenBSD based implementation of NTP.  Really quite a lot smaller than ntp,
    bit more work to set up, and no status information available when it's
    running.  This last is not so good...

`portmap`
    Web page: http://neil.brown.name/portmap/

    Required for nfs lock mounting.

`procinfo`
    Download from: ftp://ftp.cistron.nl/pub/people/00-OLD/svm/

    Ancient proc monitoring program, last updated 2001-03-02!

`procinfo-ng`
    Web page: http://sourceforge.net/projects/procinfo-ng/

    Updated proc monitoring program, updated recently, but doesn't look all
    that great.

`procServ`
    Web page: http://procserv.sourceforge.net/

    Tool for running programs in background with its own private terminal
    connected to an open Telnet port.

`Python`
    Web page: http://python.org

    Python.  Unfortunately not yet successfully fully cross built.

`readline`
    Web page: http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html

    Readline library, needed by `lua`.

`screen`
    Web page: http://www.gnu.org/software/screen/

    Runs programs in the background with their own private terminal which can be
    reconnected at any time.

`strace`
    Web page: http://sourceforge.net/projects/strace/

    Invaluable debugging tool.  Install this!

`sudo`
    Web page: http://www.gratisoft.us/sudo/

    Controled delegation of authority.

`tcpdump`
    Web page: http://www.tcpdump.org/

    Powerful command line network packet analyser.  Depends on `libpcap`.

`testing`
    Example for components with local sources.

`zlib`
    Web page: http://zlib.net/

    Compression library.  Not sure why this is included.


Toolkit Components
------------------

The following toolkit component is needed for building the root filesystem.

`fakeroot`
    Web page: http://fakeroot.alioth.debian.org/

    Unfortunately, finding the right place to download `fakeroot` is remarkably
    difficult.  It's part of Debian and Ubuntu, but the two distributions are
    very different!

    OpenEmbedded download from ftp://ftp.debian.org/debian/pool/main/f/fakeroot/
    which seems the best reference.

The following toolkit components are needed for reproducible rootfs builds.

`autoconf`, `m4`
    Web pages:  http://www.gnu.org/software/autoconf/,
    http://www.gnu.org/software/m4/

    This is needed for rebuilding `./configure` after local patches to certain
    components.

May well also need up to date versions of `automake` and `libtool`.



Notes on Cross Compiling
------------------------

Preparing packages for building with rootfs presents three challenges:

1.  Not all projects support cross compilation.  The biggest obstacle tends to
    be `./configure` tests which rely on running the built target fragment,
    which is not practical -- such configurations need to be patched or worked
    around.

2.  Rootfs has followed a policy of making all builds "out of tree" so that a
    single source directory can be shared among a number of target builds, and
    this is enforced by making the source directory read-only after extraction.

    Unfortunately a number of tools and projects generate many headaches when
    trying to build out of tree.  Solutions range from configuration patches
    through linking or copying selected files to building the package more
    directly.

3.  Most packages install far too many files for a rootfs build, so typically
    the install step needs to be worked out and redone.


For many the standard `configure` script is well behaved and all that
is needed is something along these lines::

    config:
            cd $(O)  &&  \
            $(srcdir)/configure CFLAGS='$(CFLAGS)' \
                --host=$(COMPILER_PREFIX) --build=$(BUILD_TYPE)
    build:
            make -C $(O)

These components are easy to build:

    bash
    dropbear
    libpcap
    nano
    nfs-utils
    ntp
    openntpd
    procinfo-ng
    screen
    strace
    sudo
    tcpdump

The following support cross compilation out of tree through their own
particular mechanisms:

    busybox
    mtd-utils
    testing

These ones are troublesome:

    i2c-tools
    lm_sensors
    lshw
    lsof
    ntpclient
    portmap
    procinfo
    Python


`inotify-tools`
    This one doesn't build properly yet, it's still work in progress.  There are
    problems with relative paths and rebuilding the make files.

`lm_sensors`
    For this to work we need to construct a skeletal build directory structure
    mirroring the original source structure and create links to all the
    subsiduary make files.  The build needs `VPATH=$(srcdir)` and a number of
    other exports to be set.

`lshw`
    Similarly, this needs links to makefiles in a skeleton of the source
    directory tree and explicit specification of cross compilation programs,
    `VPATH` and an extra includes definition.

`lsof`
    This one is utterly excruciating.

`ntpclient`
    No special configuration step required, but the build requires explicit
    specification of the `VPATH` and `CC`.

`portmap`
    A special patch to the makefile is needed for dependency building to work.
    The build step requires a number of symbols to be defined.

`procinfo`
    Much the same as `ntpclient`.

`Python`
    This one is hard, and doesn't work properly yet.
