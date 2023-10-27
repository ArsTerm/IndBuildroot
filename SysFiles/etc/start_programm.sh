#!/bin/sh
speedometer=/opt/indicator-program/bin/SpeedometerScreen
programm=/opt/indicator-program/bin/indicator-program
export QT_QPA_EGLFS_DISABLE_INPUT=1
export FB_MULTI_BUFFER=3
export QT_QPA_EGLFS_FB=/dev/fb0
$speedometer &
export QT_QPA_EGLFS_FB=/dev/fb2
#    export QT_QPA_EVDEV_TOUCHSCREEN_PARAMETERS=/dev/input/event2
$programm -plugin evdevtouch
val=$?
if [[ "$val" -eq "139" ]]
then
	reboot -f
fi
if [[ "$val" -ne "0" ]]
then
	programm=/opt/IndicatorRestore/IndicatorRestore
	$programm -plugin evdevtouch
fi