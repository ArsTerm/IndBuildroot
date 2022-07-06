#!/bin/sh

eval $(grep "BR2_TARGET_UBOOT_BOARDNAME" .config)

BOOT=$1

#if [ -z "$2" ]; then
#    DISK=$1
#else
#    DISK=$2
#fi
#
DISK=$1

if echo "$DISK" | grep -q "mmc"; then
    PART="p1"
else
    PART="1"
fi

msg() {
    if [ $1 -ne 0 ]; then
        printf "[ERROR]\n"
        printf "see mk-sd.log for more details\n"
        exit $1
    else
        printf "[OK]\n"
    fi
}

if [ "$BOOT" = "/dev/sda" ]; then
    echo "WARNING !!! $BOOT probably your root device, skipped"
    exit 1
fi

if [ "$DISK" = "/dev/sda" ]; then
    echo "WARNING !!! $DISK probably your root device, skipped"
    exit 1
fi

if [ ! -b "$BOOT" ]; then
    echo "block device $BOOT not found"
    exit 1
fi

if [ ! -b "$DISK" ]; then
    echo "block device $DISK not found"
    exit 1
fi

if [ -z "$BR2_TARGET_UBOOT_BOARDNAME" ]; then
        BR2_TARGET_UBOOT_BOARDNAME="unknown board"
fi

echo ""
echo "create the bootable SD card for $BR2_TARGET_UBOOT_BOARDNAME on device $BOOT,$DISK"
echo ""

# break off automounter
umount $DISK* > mk-sd.log 2>&1
test -d ./mnt && umount ./mnt > mk-sd.log 2>&1

printf "delete partition table      "
dd if=/dev/zero of=$DISK bs=1024 count=1024 >> mk-sd.log 2>&1
msg $?

printf "create primary partition    "
# echo '1,' | sfdisk -u M $DISK >> mk-sd.log 2>&1
echo '1,,L' | sfdisk -uM --force $DISK >> mk-sd.log 2>&1
msg $?

printf "prepare u-boot.imx          "
dd if=output/images/u-boot.imx of=$BOOT bs=512 seek=2 conv=notrunc >> mk-sd.log 2>&1
msg $?

printf "make ext4 fs                "
mkfs.ext2 -O ^64bit ${DISK}${PART} >> mk-sd.log 2>&1
msg $?

printf "mount partition             "
mkdir -p ./mnt
mount ${DISK}${PART} ./mnt >> mk-sd.log 2>&1
msg $?

printf "extract rootfs.tar          "
tar xf output/images/rootfs.tar -C ./mnt >> mk-sd.log 2>&1
msg $?

printf "Copy system system files    "
cp -R ../SysFiles/* ./mnt >> mk-sd.log 2>&1
msg $?
chmod 0600 ./mnt/etc/NetworkManager/system-connections/*
echo "$2" > ./mnt/opt/indicator-program/deviceName

printf "umount partition            "
umount ./mnt >> mk-sd.log 2>&1
msg $?

# bye automounter
umount $DISK* >> mk-sd.log 2>&1
sync >> mk-sd.log 2>&1

printf "remove tmp mount point      "
rm -r ./mnt >> mk-sd.log 2>&1
msg $?

echo ""
echo "all commands are completed without errors, SD is ready"
echo ""
