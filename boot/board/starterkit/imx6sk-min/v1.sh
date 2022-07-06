#!/bin/sh

gst-launch-1.0 -e imxv4l2videosrc device=/dev/video$1 ! imxg2dvideosink
