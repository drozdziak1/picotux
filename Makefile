LINUX_DIR = linux
LINUX_CONFIG = $(PWD)/linux_config

BUSYBOX_DIR = $(PWD)/busybox
# No variable in BusyBox to make this prettier unfortunately
BUSYBOX_CONFIG := $(BUSYBOX_DIR)/.config

DESC = vmroot_desc

ARCH := $(shell uname -m)

.PHONY: all clean linux busybox

objs = vmroot.img vmlinuz busybox_bin

all: vmroot.img


linux_config:
	$(MAKE) -C $(LINUX_DIR) KCONFIG_CONFIG=$(LINUX_CONFIG) defconfig

linux: linux_config
	$(MAKE) -C $(LINUX_DIR) KCONFIG_CONFIG=$(LINUX_CONFIG)


# <ugly Makefile-lobotomy-grade hack>
$(BUSYBOX_CONFIG):
	$(MAKE) -C $(BUSYBOX_DIR) defconfig

busybox_config: $(BUSYBOX_CONFIG)
# </ugly Makefile-lobotomy-grade hack>

busybox: busybox_config
	$(MAKE) -C $(BUSYBOX_DIR) CONFIG_STATIC=y


vmroot.img: linux busybox
	$(LINUX_DIR)/usr/gen_init_cpio $(DESC) > $@


run:
	qemu-system-$(ARCH) -kernel linux/arch/$(ARCH)/boot/bzImage \
		-initrd vmroot.img -append console=ttyS0 -nographic


clean:
	$(MAKE) -C $(LINUX_DIR) $@
	$(MAKE) -C $(BUSYBOX_DIR) $@
	rm -rf $(objs)

mrproper: clean
	$(MAKE) -C $(LINUX_DIR) $@
	$(MAKE) -C $(BUSYBOX_DIR) $@
