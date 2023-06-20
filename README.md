Updated NVIDIA 340.108 Linux Drivers
====================================

This repository provides scripts and patches for building the NVIDIA 340.108 drivers for
recent Linux (6.0+) kernel.

Most code patches were sourced from [If Not True Then
False](http://www.if-not-true-then-false.com). Additional modifications were made to allow
it to build with recent Linux kernels.

This is distributed as a patch only. The official driver installer will be downloaded from
the NVIDIA website if necessary.


Installation
------------

    git clone https://github.com/dkosmari/nvidia-340.108-updated.git
    cd nvidia-340.108-updated
    ./apply-patch.sh # this will download NVIDIA-Linux-x86_64-340.108.run

In order to install using DKMS (recommended):

    sudo make install

To just compile the module, without installing it:

    make


Post-Installation
-----------------

This will only install the kernel drivers. You still need to run the installer to ensure
the rest of the driver stack gets installed:

    ./NVIDIA-Linux-x86_64-340.108.run --no-kernel-module

You might need to rerun this every time your Xorg package gets updated, since there's a
conflict with the GLX library.
