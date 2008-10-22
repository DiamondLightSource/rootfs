#!/bin/sh

set -e

cd "${1:?Target directory}"

# Core device 1 stuff
mknod mem       c 1 1           # Pysical memory access
mknod kmem      c 1 2           # Kernel virtual memory
mknod null      c 1 3           # Null device
mknod port      c 1 4           # I/O port access
mknod zero      c 1 5           # Null byte source
mknod full      c 1 7           # Full on write, blocks on read
mknod random    c 1 8           # Nondeterministic random data 
mknod urandom   c 1 9           # Pseudo random numbers
mknod aio       c 1 10          # Asynchronous I/O notification
mknod kmsg      c 1 11          # Generate printk messages

# Devices actually defined in /proc
ln -s /proc/self/fd fd
ln -s fd/0 stdin 
ln -s fd/1 stdout
ln -s fd/2 stderr

# Serial port
mknod ttyS0     c 4 64          # First UART serial port

# Consoles:
mknod tty       c 5 0           # Current (only) TTY device
mknod console   c 5 1           # System console
mknod ptmx      c 5 2           # PTY master multiplex

# Flash file system partitions
mknod mtdblock0 b 31 0          # uBoot boot loader
mknod mtdblock1 b 31 1          # uBoot configuration
mknod mtdblock2 b 31 2          # kernel
mknod mtdblock3 b 31 3          # filesystem
