#!/bin/sh
speedometer=/opt/indicator-program/bin/SpeedometerScreen
programm=/opt/indicator-program/bin/indicator-program
export FB_MULTI_BUFFER=3
export QT_QPA_EGLFS_FB=/dev/fb0
$speedometer &
export QT_QPA_EGLFS_FB=/dev/fb2
#    export QT_QPA_EVDEV_TOUCHSCREEN_PARAMETERS=/dev/input/event2
$programm 1
val=$?
if [[ "$val" -ne "0" ]]
then
	programm=/opt/IndicatorRestore/IndicatorRestore
	$programm
fi