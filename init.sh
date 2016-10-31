#!/bin/sh

# BusyBox bootstrap
/bin/busybox --install -s /bin

#Mount things needed by this script
mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t devpts devpts /dev/pts

while true; do
	/bin/sh
done
