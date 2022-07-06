#!/bin/sh
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