eval $(grep "BR2_TARGET_UBOOT_BOARDNAME" .config)
BOARD_DIR=board/starterkit/imx6sk-min

if grep -q "BR2_TARGET_UBOOT_WATCHDOG=y" .config; then
    install -m 0755 $BOARD_DIR/S15watchdog $1/etc/init.d/
else
    test -f $1/etc/init.d/S15watchdog && rm $1/etc/init.d/S15watchdog
fi

test -d output/staging/usr/lib/qt/examples && cp -r output/staging/usr/lib/qt/examples $1/usr/lib/qt/
test -d $1/etc/usbmount && install -m 0644 $BOARD_DIR/usbmount.conf $1/etc/usbmount/
test -f $1/usr/lib/qt/plugins/video/videonode/libeglvideonode.so && rm $1/usr/lib/qt/plugins/video/videonode/libeglvideonode.so
test -f $1/lib/udev/rules.d/80-net-name-slot.rules && rm $1/lib/udev/rules.d/80-net-name-slot.rules
rm $1/usr/lib/imx-mm/parser/lib_mkv_parser*

cp output/images/u-boot.imx $1/boot/
install -m 0755 $BOARD_DIR/S10udev $1/etc/init.d/
install -m 0755 $BOARD_DIR/S45rus $1/etc/init.d/
install -m 0755 $BOARD_DIR/S90fbtest $1/etc/init.d/
install -m 0644 $BOARD_DIR/profile.sh $1/etc/profile.d/
if echo "$BR2_TARGET_UBOOT_BOARDNAME" | grep -q "sodimm"; then
    sed -i 's/event0/event1/g' $1/etc/profile.d/profile.sh
fi
install -m 0644 $BOARD_DIR/interfaces $1/etc/network/
install -m 0644 $BOARD_DIR/fw_env.config $1/etc/
install -m 0644 $BOARD_DIR/inittab $1/etc/
install -m 0644 $BOARD_DIR/asound.conf $1/etc/
install -m 0755 $BOARD_DIR/root2nand.sh $1/root/
install -m 0755 $BOARD_DIR/a1.sh $1/root/
install -m 0755 $BOARD_DIR/v1.sh $1/root/
install -m 0755 $BOARD_DIR/avc1.sh $1/root/
install -m 0755 $BOARD_DIR/cv4.sh $1/root/
install -m 0755 $BOARD_DIR/vcv4.sh $1/root/
install -m 0755 $BOARD_DIR/rtsp4.sh $1/root/
install -m 0644 $BOARD_DIR/v4.qml $1/root/

# install -m 0755 $BOARD_DIR/spidev_test $1/root/

test -f $1/etc/ssh/sshd_config && sed -i 's/^.*UseDNS.*$/UseDNS no/g' $1/etc/ssh/sshd_config
test -f $1/etc/ssh/sshd_config && sed -i 's/^.*PermitRootLogin.*$/PermitRootLogin yes/g' $1/etc/ssh/sshd_config
rm $1/etc/resolv.conf
echo "nameserver 8.8.8.8" > $1/etc/resolv.conf
echo "nameserver 4.2.2.4" >> $1/etc/resolv.conf
