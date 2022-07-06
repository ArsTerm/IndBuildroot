#!/bin/sh

eval $(grep "BR2_PACKAGE_KERNEL_MODULE_IMX_GPU_VIV" .config)

rm output/build/linux-custom/.stamp_built
rm output/build/linux-custom/.stamp_images_installed
rm output/build/linux-custom/.stamp_target_installed

if [ "$BR2_PACKAGE_KERNEL_MODULE_IMX_GPU_VIV" = "y" ]; then
    rm -r output/build/kernel-module-imx-gpu-viv*
fi

make -j12
