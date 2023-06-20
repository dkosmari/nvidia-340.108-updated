#!/bin/bash -xe


NV_DIR="NVIDIA-Linux-x86_64-340.108"
rm -rf ${NV_DIR}
./NVIDIA-Linux-x86_64-340.108.run --extract-only

rm -rf original
mkdir original

for f in ${NV_DIR}/kernel/*.{h,c} ${NV_DIR}/kernel/uvm/*.{h,c}
do
    cp -t original $f
done

rm -rf ${NV_DIR}


rm -rf updated
mkdir updated
cp -t updated *.{h,c}


diff --recursive --unified --new-file original updated > updated.patch || true


rm -rf original updated ${NV_DIR}

exit 0
