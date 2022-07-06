#!/bin/sh

msg() {
    if [ $1 -ne 0 ]; then
        printf "[ERROR]\n"
        printf "see root2nand.log for more details\n"
        echo 1 > /proc/sys/kernel/printk
        exit $1
    else
        printf "[OK]\n"
    fi
}

if [ ! -c /dev/mtd0 ]; then
    echo "NAND not found"
    exit 1
fi

echo 0 > /proc/sys/kernel/printk

printf "erase kernel partition        "
flash_erase /dev/mtd1 0 0 > root2nand.log 2>&1
msg $?

printf "write zImage                  "
nandwrite -p /dev/mtd1 /boot/zImage >> root2nand.log 2>&1
msg $?

printf "erase dtb partition           "
flash_erase /dev/mtd2 0 0 > root2nand.log 2>&1
msg $?

if [ "$(grep 'processor' /proc/cpuinfo | uniq | wc -l)" -eq "4" ]; then
    dtbfile="imx6q-sk.dtb"
else
    dtbfile="imx6dl-oem.dtb"
fi

printf "write $dtbfile            "
nandwrite -p /dev/mtd2 /boot/$dtbfile >> root2nand.log 2>&1 
msg $? 

printf "format root partition mtd3    "
ubiformat -y /dev/mtd3 >> root2nand.log 2>&1
msg $?

printf "attach mtd3                   "
ubiattach /dev/ubi_ctrl -m 3 >> root2nand.log 2>&1
msg $?

printf "make volume <rootfs>          "
ubimkvol /dev/ubi0 -N rootfs -m >> root2nand.log 2>&1
msg $?

printf "mount ubifs                   "
mount -t ubifs ubi0:rootfs /mnt >> root2nand.log 2>&1
msg $?

printf "copy root fs to NAND          "
tar -cf - \
  --exclude 'dev/*' --exclude 'proc/*' --exclude 'sys/*' \
  --exclude 'tmp/*' --exclude lost+found --exclude 'mnt/*' \
  --exclude 'media/usb*/*' --exclude 'run/*' / | \
  tar -xf - -C /mnt
msg $?

printf "umount ubifs                  "
umount /mnt >> root2nand.log 2>&1
msg $?

printf "detach mtd3                   "
ubidetach /dev/ubi_ctrl -m 3 >> root2nand.log 2>&1
msg $? 

if [ -f /boot/u-boot-nand.imx ]; then
    printf "erase boot partition          "
    flash_erase /dev/mtd0 0 0 >> root2nand.log 2>&1
    msg $?

    printf "prepare u-boot-nand.imx       "
    kobs-ng init -v -x /boot/u-boot-nand.imx >> root2nand.log 2>&1
    msg $?
fi

echo 1 > /proc/sys/kernel/printk

echo ""
echo "all commands are completed without errors, NAND is ready"
echo ""
