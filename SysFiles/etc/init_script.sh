#!/bin/sh
if test -f "/opt/.init_file"; then
	printf '1M,630M,L\n,,L' | sfdisk --force /dev/mmcblk1
	rm "/opt/.init_file"
	touch "/opt/.init_file2"
	reboot -f
fi

if test -f "/opt/.init_file2"; then
	mkdir /mnt/data
	mkfs.ext2 -O ^64bit /dev/mmcblk1p2
	rm "/opt/.init_file2"
fi

if test -f "/opt/.need_check"; then
	e2fsck -p /dev/mmcblk1p2
	RET=$?
	echo $RET > /opt/checkResult
	rm "/opt/.need_check"
fi

mount /dev/mmcblk1p2

rm -R /.cache
ln -s /tmp /.cache

gpiochip=/sys/class/gpio
echo 159 > $gpiochip/export
echo 160 > $gpiochip/export
echo 161 > $gpiochip/export
echo 163 > $gpiochip/export
echo 165 > $gpiochip/export
echo 90 > $gpiochip/export
echo 91 > $gpiochip/export
echo 82 > $gpiochip/export
gpio=$gpiochip/gpio90
echo both > $gpio/edge
gpio=$gpiochip/gpio91
echo both > $gpio/edge
gpio=$gpiochip/gpio163
echo out > $gpio/direction
echo 1 > $gpio/value
sleep 0.03
gpio=$gpiochip/gpio161
echo out > $gpio/direction
echo 1 > $gpio/value
sleep 0.01
for pwmchip in /sys/class/pwm/pwmchip*
do
	echo 0 > $pwmchip/export
	pwm=$pwmchip/pwm0
	echo 50000 > $pwm/period
	echo 50000 > $pwm/duty_cycle
	echo 1 > $pwm/enable
done
sleep 0.01
gpio=$gpiochip/gpio159
echo out > $gpio/direction
echo 1 > $gpio/value
gpio=$gpiochip/gpio160
echo out > $gpio/direction
echo 1 > $gpio/value
gpio=$gpiochip/gpio165
echo out > $gpio/direction
echo 1 > $gpio/value

echo 0 > /sys/class/graphics/fbcon/cursor_blink
amixer set Digital 127

valFile=/sys/class/gpio/gpio82/value
val=$(cat $valFile)
if [[ "$val" -eq "1" ]]
then
	/etc/start_programm.sh
else
	programm=/opt/IndicatorRestore/IndicatorRestore
	export QT_QPA_EGLFS_FB=/dev/fb2
	$programm &
fi