LINUX_DIR = linux
LINUX_CONFIG = linux_config

BUSYBOX_DIR = busybox
BUSYBOX_CONFIG = busybox_config
BUSYBOX_ACTUAL_CONFIG = $(BUSYBOX_DIR)/.config

.PHONY: linux busybox all clean

objs = vmroot.img

all: linux busybox vmroot.img


linux: linux_config
	$(MAKE) -C $(LINUX_DIR) KCONFIG_CONFIG=$(LINUX_CONFIG)


busybox: busybox_config;
	ifeq(,$(wildcard $(BUSYBOX_ACTUAL_CONFIG))
		$(MAKE) -C $(BUSYBOX_DIR)
	endif


linux_config:
	$(MAKE) -C $(LINUX_DIR) KCONFIG_CONFIG=$(LINUX_CONFIG) defconfig

busybox_config:



clean:
	$(MAKE) -C $(LINUX_DIR) clean
	$(MAKE) -C $(BUSYBOX_DIR) clean
	rm -rf $(objs)

mrproper: clean
	$(MAKE) -C $(LINUX_DIR) mrproper
	$(MAKE) -C $(BUSYBOX_DIR) mrproper
