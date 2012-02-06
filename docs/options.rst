.. _options:
.. default-role:: literal

Selectable Rootfs Options
=========================

The detailed assembly and configuration of the rootfs is controlled by a number
of `OPTIONS` values.  Two of the options configure core rootfs behaviour, the
remainder are used for network configuration.


Option `inittab`
----------------

This option is selected by default and defines the core skeleton of files to be
installed, see `options/inittab/file-list`, and defines two configuration
values:

`CONSOLE_TTY`
    This is a list of TTY names for which `/sbin/getty` will be run.

`CONSOLE_BAUD`
    This specifies the line speen for the console TTYs.

Option `ldconfig`
-----------------

This option configures how /etc/ld.so.cache is initialised using one
configuration value:

`LDCONFIG`
    This can have one of the following values:

    `cross`
        Use the native `ldconfig` tool to initialise `/etc/ld.so.cache` on the
        target system.  This doesn't normally work if the target system has a
        different word size or orientation.

    `install`
        Install `ldconfig` on the target system but leave it uninitialised.

    `once`
        Install `ldconfig` on the target system and call it on first boot.

Note that this option is entirely optional, as `ld.so.cache` merely speeds up
the loading of dynamic libraries.


Option `network`
----------------

This is used to configure a fixed IP address for the target system.  The
`network` startup script is installed and `/etc/network/interfaces` is
constructed from the following settings:

`NW_PORT`
    Name of ethernet interface to use, defaults to `eth0`.

`NW_ADDRESS`, `NW_NETMASK`, `NW_GATEWAY`
    Network IP address, netmask and (optional) gateway to be configured into
    target system.

`NW_HWADDRESS`
    Optional MAC address to be specified for target.

`RESOLV_CONF`
    File to be installed as `/etc/resolv.conf`.


Option `network-mtd`
--------------------

Installs script for configuring the network from u-boot settings stored in
`/dev/mtd0`.

Option `network-nvram`
----------------------

Installs script for configuring the network from MOT load configuration settings
stored in `/dev/nvram`.

Option `configure-network`
--------------------------

Installs network management script using predefined lists of available machine
names and IP addresses.  Designed to be used to facilitate moving machines
between the primary and lab networks.

The basic network configuration consists of the following definitions:

`NETWORKS_LIST`
    A file containing a list of networks, each line of the form::

        <network-name> <netmask> [<gateway>]

`RESOLV_CONF.`\ <network-name>
    For each network name the appropriate `resolv.conf` file to use.

`IP_LIST.`\ <network-name>
    For each network name a file containing a list of machine names and
    associated IP addresses for that network.

`FSTAB.`\ <network-name>
    For each network name the appropiate `fstab` for extra mounts.  These are
    only useful if the `mount-extra` option has been selected.

Also, if `NW_HOSTNAME` is specified then it will be used to configure the
network on first boot.


Option `mount-nfs`
------------------

Adds startup script to load NFS entries from `/etc/fstab`.

Option `mount-extra`
--------------------

Adds startup script to mount extra entries from a specified file.  Two
parameters control this option:


`MOUNT_EXTRA`
    List of mount points to be created on the target rootfs.

`EXTRA_FSTAB`
    Optional extra `fstab` to be used.  Don't define with `configure-network`
    option, as this option manages the extra fstabs separately.
