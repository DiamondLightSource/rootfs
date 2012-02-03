# Definitions for embedded FPGA processor core

TOOLCHAIN = powerpc-405

CONSOLE_BAUD = 9600
CONSOLE_TTY = ttyS0

ROOT_PASSWORD = Jungle

SSH_AUTHORIZED_KEYS = $(configdir)/authorized_keys

CFLAGS = -O2

TERMS = xterm xterm-color screen vt100 vt102

# This one is essential, nothing builds without it.
PACKAGES += busybox
# Components required for normal operation.
PACKAGES += ntp dropbear portmap
# Useful debugging tools
PACKAGES += strace lsof

BOOT = nfs

OPTIONS += mount-nfs ldconfig
LDCONFIG = install


#
# Based on how RFS will be loaded, comment lines below accordingly
#
# >> NFS-BEGIN
#NFS_SERVER ?= pc0035
#NFS_ROOTFS ?= /scratch/rootfs/$(TARGET)
# << NFS-END

# >> CF-BEGIN
# This locaation is used where to copy RFS
NFS_SERVER ?= pc0035
NFS_ROOTFS ?= /media/XLNX_RFS
#
OPTIONS += network
NW_ADDRESS = 172.23.204.246
NW_GATEWAY = 172.23.192.0
NW_NETMASK = 255.255.240.0
NW_BROADCAST = 172.23.207.255
NW_HOSTNAME = FE21B-DI-PBPM-01
# << CF-END

final-install:
        # Install the regular nfs mounts.
	$(install) -d /mnt/nfs /mnt/prod /mnt/work
	cat $(configdir)/fstab >>$(sysroot)/etc/fstab

DROPBEAR_KEYS = y
INETD_ENABLE = y

# vim: set filetype=make:
