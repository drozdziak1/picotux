LINUX_DIR = linux
BUSYBOX_DIR = busybox

LINUX_CONFIG = linux_config
BUSYBOX_CONFIG = busybox_config

.PHONY: linux busybox all clean

objs = vmroot.img

all: linux busybox

linux:
	$(MAKE) -C $(LINUX_DIR) KCONFIG_CONFIG = $(LINUX_CONFIG) $@

busybox:
	echo "STUB"

clean:
	$(MAKE) -C $(LINUX_DIR) clean
	$(MAKE) -C $(BUSYBOX_DIR) clean
	rm -rf $(objs)

mrproper: clean
	$(MAKE) -C $(LINUX_DIR) mrproper
	$(MAKE) -C $(BUSYBOX_DIR) mrproper
