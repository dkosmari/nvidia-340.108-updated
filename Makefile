PACKAGE := nvidia
VERSION := 340.108
DISTDIR := $(PACKAGE)-$(VERSION)


KDIR ?= /lib/modules/$(shell uname -r)/build
SRCTREE ?= /usr/src
INSTALLER ?= ./NVIDIA-Linux-x86_64-340.108.run


SRCDIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))


SRCFILES := \
	cla06f.h \
	cla06fsubch.h \
	cla0b5.h \
	cpuopsys.h \
	ctrl2080mc.h \
	g_nvreadme.h \
	gcc-version-check.c \
	nv-memdbg.h \
	nv-acpi.c \
	nv-chrdev.c \
	nv-cray.c \
	nv-dma.c \
	nv-drm.c \
	nv-frontend.c \
	nv-frontend.h \
	nv-gvi.c \
	nv-i2c.c \
	nv-linux.h \
	nv-mempool.c \
	nv-misc.h \
	nv-mmap.c \
	nv-p2p.c nv-p2p.h \
	nv-pat.c nv-pat.h \
	nv-procfs.c \
	nv-proto.h \
	nv-reg.h \
	nv-time.h \
	nv-usermap.c \
	nv-vm.c \
	nv-vtophys.c \
	nv.c nv.h \
	nv_gpu_ops.h \
	nv_uvm_interface.c nv_uvm_interface.h \
	nverror.h \
	nvgputypes.h \
	nvidia-config.h \
	nvidia_page_migration.c nvidia_page_migration.h \
	nvidia_page_migration_kepler.c nvidia_page_migration_kepler.h \
	nvidia_uvm_common.c nvidia_uvm_common.h \
	nvidia_uvm_linux.c nvidia_uvm_linux.h \
	nvidia_uvm_lite.c nvidia_uvm_lite.h \
	nvidia_uvm_lite_api.c \
	nvidia_uvm_lite_counters.c nvidia_uvm_lite_counters.h \
	nvidia_uvm_lite_events.c \
	nvidia_uvm_page_cache.c \
	nvidia_uvm_utils.c nvidia_uvm_utils.h \
	nvkernel.h \
	nvmisc.h \
	nvtypes.h \
	os-interface.c os-interface.h \
	os-mlock.c \
	os-pci.c \
	os-registry.c \
	os-smp.c \
	os-usermap.c \
	rmil.h \
	rmretval.h \
	uvm-debug.h \
	uvm.h \
	uvm_gpu_ops_tests.c uvm_gpu_ops_tests.h \
	uvm_ioctl.h \
	uvm_linux_ioctl.h \
	uvmtypes.h \
	xapi-sdk.h


DISTFILES := \
	dkms.conf \
	Makefile \
	Kbuild \
	generate-patch.sh \
	$(SRCFILES)


.PHONY: all clean install uninstall distdir dist patch


all: nv-kernel.o_shipped
	touch .nv-kernel.o.cmd
	make -C $(KDIR) M=$(SRCDIR)


clean:
	$(info cleaning up)
	make -C $(KDIR) M=$(SRCDIR) clean
	$(RM) .nv-kernel.o.cmd


nv-kernel.o_shipped:
	$(eval NV_TMPDIR := $(shell mktemp --directory --dry-run))
	chmod +x $(INSTALLER)
	$(INSTALLER) --extract-only --target $(NV_TMPDIR)
	cp -uv $(NV_TMPDIR)/kernel/nv-kernel.o $@
	$(RM) -r $(NV_TMPDIR)


distdir:
	mkdir -p $(DISTDIR)
	cp $(DISTFILES) $(DISTDIR)/


dist: distdir
	tar czf $(DISTDIR).tar.gz $(DISTDIR)
	$(RM) -r $(DISTDIR)


install: uninstall nv-kernel.o_shipped
ifeq ($(SRCTREE),$(SRCDIR))
	$(error Cannot install when SRCTREE and SRCDIR are the same.)
endif
	mkdir -p $(SRCTREE)/$(DISTDIR)
	cp $(DISTFILES) $(SRCTREE)/$(DISTDIR)
	cp nv-kernel.o_shipped $(SRCTREE)/$(DISTDIR)
	dkms add -m $(PACKAGE) -v $(VERSION)
	dkms build -m $(PACKAGE) -v $(VERSION)
	dkms install -m $(PACKAGE) -v $(VERSION)


uninstall:
	dkms --version >/dev/null
	-dkms remove -m $(PACKAGE) -v $(VERSION) --all
	$(RM) -r $(SRCTREE)/$(DISTDIR)


patch: $(INSTALLER)
	./generate-patch.sh
