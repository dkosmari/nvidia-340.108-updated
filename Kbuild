# -*- mode: makefile -*-


COMPILER_VERSION := $(shell gcc --version | head -n1)


NVIDIA_CFLAGS := \
	-D__linux__ \
	-DLinux \
	-DNV_DEV_NAME=\"nvidia\" \
	-DNV_UVM_ENABLE \
	-DNV_VERSION_STRING=\"340.108\" \
	-DNVRM \
	-DNV_BUILD_MODULE_INSTANCES=0 \
	-DNV_MODULE_INSTANCE=0 \
	'-DNV_COMPILER="$(COMPILER_VERSION)"' \
	-DNVIDIA_UVM_LITE_ENABLED \
	-DNVIDIA_UVM_RM_ENABLED


CFLAGS_MODULE := \
	-I$(PWD) \
	$(NVIDIA_CFLAGS) \
	-Werror


obj-m := nvidia.o nvidia-uvm.o


nvidia-objs := \
	nv-acpi.o \
	nv-chrdev.o \
	nv-cray.o \
	nv-dma.o \
	nv-drm.o \
	nv-frontend.o \
	nv-gvi.o \
	nv-i2c.o \
	nv-mempool.o \
	nv-mmap.o \
	nv-p2p.o \
	nv-pat.o \
	nv-procfs.o \
	nv-usermap.o \
	nv-vm.o \
	nv-vtophys.o \
	nv.o \
	nv_uvm_interface.o \
	os-interface.o \
	os-mlock.o \
	os-pci.o \
	os-registry.o \
	os-smp.o \
	os-usermap.o \
	nv-kernel.o


nvidia-uvm-objs := \
	nvidia_page_migration.o \
	nvidia_page_migration_kepler.o \
	nvidia_uvm_common.o \
	nvidia_uvm_linux.o \
	nvidia_uvm_lite.o \
	nvidia_uvm_lite_api.o \
	nvidia_uvm_lite_counters.o \
	nvidia_uvm_lite_events.o \
	nvidia_uvm_page_cache.o \
	nvidia_uvm_utils.o \
	uvm_gpu_ops_tests.o
