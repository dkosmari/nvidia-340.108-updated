#!/bin/bash -ex

if [[ ! -f updated.patch ]]
then
    echo "'updated.patch' not found"
    exit 1
fi


NV_DIR="NVIDIA-Linux-x86_64-340.108"
rm -rf ${NV_DIR}
if [[ ! -f NVIDIA-Linux-x86_64-340.108.run ]]
then
   wget https://us.download.nvidia.com/XFree86/Linux-x86_64/340.108/NVIDIA-Linux-x86_64-340.108.run
fi
chmod +x ./NVIDIA-Linux-x86_64-340.108.run
./NVIDIA-Linux-x86_64-340.108.run --extract-only

for f in ${NV_DIR}/kernel/*.{h,c} ${NV_DIR}/kernel/uvm/*.{h,c}
do
    cp -f -t . $f
done

rm -rf ${NV_DIR}


patch --verbose --unified -p1 < updated.patch

exit 0
