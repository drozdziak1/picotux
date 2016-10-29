LINUX_DIR = linux
LINUX_CONFIG = linux_config

BUSYBOX_DIR = busybox
BUSYBOX_CONFIG = busybox_config
BUSYBOX_ACTUAL_CONFIG = $(BUSYBOX_DIR)/.config

.PHONY: linux busybox all clean

objs = vmroot.img

all: vmroot.img
	$(LINUX_DIR)/usr/get


linux_config:
	$(MAKE) -C $(LINUX_DIR) KCONFIG_CONFIG=$(LINUX_CONFIG) defconfig

linux: linux_config
	$(MAKE) -C $(LINUX_DIR) KCONFIG_CONFIG=$(LINUX_CONFIG)


busybox_config:
	$(MAKE) -C $(BUSYBOX_DIR) defconfig

busybox: busybox_config;
	$(MAKE) -C $(BUSYBOX_DIR) KCONFIG_CONFIG=$(BUSYBOX_CONFIG)

vmroot.img: linux busybox


clean:
	$(MAKE) -C $(LINUX_DIR) $@
	$(MAKE) -C $(BUSYBOX_DIR) $@
	rm -rf $(objs)

mrproper: clean
	$(MAKE) -C $(LINUX_DIR) $@
	$(MAKE) -C $(BUSYBOX_DIR) $@
