#!/bin/bash

source ./script/utils/prompt.sh
source ./script/utils/chkarg.sh
source ./script/utils/chkprg.sh

source ./script/partition.sh
source ./script/build-kernel.sh
source ./script/install-kernel.sh

echo "Tungsten (W) - ready at your service!"


prompt_answer "Which device would you install Tungsten on? (/dev/sdc, /dev/mmcblk0p...)" DEVICE
echo $DEVICE

prompt_choice "Nice balls" \
zeta \
ics \
enne \
erre

echo $?

# Partition the device
echo "Partitioning the device..."
# partition $DEVICE

# Prepare to build kernel
echo "Building kernel..."
build_kernel

# Installing kernel
