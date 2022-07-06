#!/bin/sh

gst-launch-1.0 -e imxv4l2videosrc device=/dev/video0 queue-size=16 ! queue ! \
  imxipuvideotransform ! queue ! imxvpuenc_h264 bitrate=2000 ! queue ! h264parse ! queue ! \
  mux. alsasrc device="hw:0" ! audiorate ! audioconvert ! queue ! imxmp3audioenc ! \
  mux. matroskamux name=mux ! queue ! filesink location=avc0.mkv
