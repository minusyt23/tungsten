# Partition the device
# args: device (/dev/sda, /dev/sdc, stuff like that)

partition () {
	echo "Partitioning $1..."

	parted --script $1 mklabel gpt

	parted -a optimal $1 unit mib mkpart Kernel 4 36
	parted -a optimal $1 unit mib mkpart Kernel 36 68
	parted -a optimal $1 unit mib mkpart Root 68 100%

	# Adding special flags for Chromebooks
	cgpt add -i 1 -t kernel -l SDKernelA -S 1 -T 2 -P 10 $1
	cgpt add -i 2 -t kernel -l SDKernelB -S 0 -T 2 -P 5 $1

	# Refreshing the kernel
	partprobe -s $1
}
