# Build kernel
# series of commands to correctly build the fucker

build_kernel () {
	OLD_DIR=$(pwd)
	mkdir kbuild
	cd kbuild

	# Check if user has the kernel in kbuild directory

	echo "Extract latest stable kernel (downloaded from kernel.org) into kbuild directory..."
	echo "(this tool will build the newest extracted directory, so don't worry if you have multiple kernel folders inside!)"
	read

	cd $(ls -t | head -1)

	# Copy config to kernel directory
	cp "$OLD_DIR/res/.config" ".config"

	# make image, dtb and modules
	echo ">> Compiling kernel"
	make allmodconfig -j8 ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image dtbs modules

	# do mkimage
	echo ">> Doing mkimage"
	cp "$OLD_DIR/res/arm64.kernel.its" arm64.kernel.its
	sync
	mkimage -f arm64.kernel.its arm64.kernel.itb

	# do futility
	echo ">> Doing futility"
	cp "$OLD_DIR/res/kernel.flags" kernel.flags
	sync
	futility --debug vbutil_kernel --arch arm --version 1 --keyblock /usr/share/vboot/devkeys/kernel.keyblock --signprivate /usr/share/vboot/devkeys/kernel_data_key.vbprivk --bootloader kernel.flags --config kernel.flags --vmlinuz arm64.kernel.itb --pack vmlinuz.signed

	# go back
	cd $OLD_DIR
}
