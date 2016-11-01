#!/bin/sh

# BusyBox bootstrap
/bin/busybox --install -s /bin

# Mount pseudofilesystems
mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t devpts devpts /dev/pts

# Execute shell
while true; do
	/bin/sh
done
