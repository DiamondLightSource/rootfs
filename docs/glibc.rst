.. _glibc:
.. default-role:: literal

Notes on glibc Libraries
========================

Libraries in `/lib`
-------------------

The following appear to be core dependencies:
    `ld-2.7.so`, `ld-linux.so.3` (link to `ld-2.7.so`), `libc-2.7.so`,
    `libgcc_s.so`


`libanl-2.7.so`:
    Defines `getaddrinfo_a`...

`libBrokenLocale-2.7.so`:
    Mystery file.

`libcrypt-2.7.so`:
    Encryption library: see `crpyt(P)`

`libdl-2.7.so`:
    Implements `dlopen` -- core to glibc?

`libgfortran.so`:
    Fortran library, definitely not wanted!

`libgomp.so`:
    OpenMP: shared memory parallel programming.  Useful for multi-core
    processors, presumably not so useful when embedded!

`libm-2.7.so`:
    Mathematics library.

`libmemusage.so`, `libmudflap.so`, `libmudflapth.so`:
    Debug implementations of `malloc` etcetera?

`libnsl-2.7.so`:
    NIS (Network Information Service) or YP support.

`libnss_compat-2.7.so`, `libnss_dns-2.7.so`, `libnss_files-2.7.so`, `libnss_hesiod-2.7.so`:
    These all appear to be part of DNS, and are dynamically loaded.

`libnss_nis-2.7.so`, `libnss_nisplus-2.7.so`:
    Various name server resolvers.

`libpcprofile.so`:
    Profiling support?

`libpthread-2.7.so`:
    Pthread library.

`libresolv-2.7.so`:
    Name service resolver.

`librt-2.7.so`:
    Timers and so forth.

`libSegFault.so`:
    Segmentation fault handler, tries to catch segfaults.

`libssp.so`:
    More memory checking libraries.

`libstdc++.so`:
    C++ libraries.

`libthread_db-1.0.so`:
    Debugger support for multi-threaded programs.

`libutil-2.7.so`:
    Exports `login`, `openpty` and associated functions, but probably not needed
    if busybox is being used instead.


Library dependency hierarchy::

    ld-linux.so.3 = ld-2.7.so
        libc-2.7.so = libc.so.6
            libBrokenLocale-2.7.so
            libcrypt-2.7.so
            libdl-2.7.so = libdl.so.2
                libmemusage.so
                libmudflap.so.0.0.0
                libmudflapth.so.0.0.0
            libgcc_s.so.1
                libgfortran.so.2.0.0 *
                libstdc++.so.6.0.9 *
            libm-2.7.so
                libgfortran.so.2.0.0 *
                libstdc++.so.6.0.9 *
            libnsl-2.7.so = libnsl.so.1
                libnss_compat-2.7.so
                libnss_nisplus-2.7.so
                libnss_nis-2.7.so *
            libnss_files-2.7.so = libnss_files.so.2
                libnss_nis-2.7.so *
                libnss_hesiod-2.7.so *
            libpcprofile.so
            libpthread-2.7.so = libpthread.so.0
                libanl-2.7.so
                librt-2.7.so
                    libgomp.so.1.0.0
            libresolv-2.7.so = libresolv.so.2
                libnss_dns-2.7.so
                libnss_hesiod-2.7.so *
            libSegFault.so
            libssp.so.0.0.0
            libthread_db-1.0.so
            libutil-2.7.so

The libraries marked `*` appear with multiple dependencies.


Libraries in `/usr/lib`
-----------------------

`libbfd-2.18.so`, `libbfd-2.18.so`:
    Object file format library.

`libc.so`, `libpthread.so`:
    `ld` scripts, presumably not needed on target?

`libdmalloc.so`, `libdmallocthcxx.so`, `libdmallocth.so`, `libdmallocxx.so`:
    Debug `malloc` libraries?

`libduma.so`:
    DUMA Malloc Debugger.

`libncurses.so`, `libcurses.so`:
    Support for the NCURSES library.

`libform.so`, `libmenu.so`, `libpanel.so`:
    Specific NCURSES libraries.



Library dependency hierarchy (`/usr/lib` only)::

    libncurses.so.5
        libform.so.5.6
        libmenu.so.5.6
        libpanel.so.5.6


The following are links to the corresponding libraries in `/lib`:

    `libanl.so`,
    `libBrokenLocale.so`,
    `libcrypt.so`,
    `libdl.so`,
    `libm.so`,
    `libnsl.so`,
    `libnss_compat.so`,
    `libnss_dns.so`,
    `libnss_files.so`,
    `libnss_hesiod.so`,
    `libnss_nisplus.so`,
    `libnss_nis.so`,
    `libresolv.so`,
    `librt.so`,
    `libthread_db.so`,
    `libutil.so`


Tools for investigating libraries
---------------------------------

Binutils tools
~~~~~~~~~~~~~~

* `addr2line` -- Converts addresses into filenames and line numbers.
* `ar` -- A utility for creating, modifying and extracting from archives.
* `c\+\+filt` -- Filter to demangle encoded C++ symbols.
* `dlltool` -- Creates files for building and using DLLs.
* `gprof` -- Displays profiling information.
* `nlmconv` -- Converts object code into an NLM.
* `nm` -- Lists symbols from object files.
* `objcopy` -- Copys and translates object files.
* `objdump` -- Displays information from object files.
* `ranlib` -- Generates an index to the contents of an archive.
* `readelf` -- Displays information from any ELF format object file.
* `size` -- Lists the section sizes of an object or archive file.
* `strings` -- Lists printable strings from files.
* `strip` -- Discards symbols.

To discover dependencies run::

    $PREFIX-readelf -d $lib | grep NEEDED

To discover underlying library name run::

    $PREFIX-readelf -d $lib | grep SONAME

To view library exports run::

    $PREFIX-nm -g $lib | grep -v ' U '
