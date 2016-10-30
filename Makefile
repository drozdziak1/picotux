LINUX_DIR = linux
LINUX_CONFIG = $(PWD)/linux_config

BUSYBOX_DIR = $(PWD)/busybox
# No variable in BusyBox to make this prettier unfortunately
BUSYBOX_CONFIG := $(BUSYBOX_DIR)/.config

DESC = vmroot_desc

.PHONY: all clean linux busybox

objs = vmroot.img

all: vmroot.img


linux_config:
	$(MAKE) -C $(LINUX_DIR) KCONFIG_CONFIG=$(LINUX_CONFIG) defconfig

linux: linux_config
	$(MAKE) -C $(LINUX_DIR) KCONFIG_CONFIG=$(LINUX_CONFIG)


$(BUSYBOX_CONFIG):
	$(MAKE) -C $(BUSYBOX_DIR) defconfig

busybox_config: $(BUSYBOX_CONFIG)

busybox:
	$(MAKE) -C $(BUSYBOX_DIR)

vmroot.img: linux busybox
	$(LINUX_DIR)/usr/gen_init_cpio $(DESC) > $@


clean:
	$(MAKE) -C $(LINUX_DIR) $@
	$(MAKE) -C $(BUSYBOX_DIR) $@
	rm -rf $(objs)

mrproper: clean
	$(MAKE) -C $(LINUX_DIR) $@
	$(MAKE) -C $(BUSYBOX_DIR) $@
