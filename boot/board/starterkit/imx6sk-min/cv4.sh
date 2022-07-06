#!/bin/sh

gst-launch-1.0 imxv4l2videosrc device=/dev/video0 queue-size=24 ! queue2 ! \
 imxipuvideotransform ! queue2 ! imxvpuenc_h264 bitrate=2000 ! queue2 ! \
 h264parse ! matroskamux ! filesink location=v0.mkv &

gst-launch-1.0 imxv4l2videosrc device=/dev/video1 queue-size=24 ! queue2 ! \
 imxipuvideotransform ! queue2 ! imxvpuenc_h264 bitrate=2000 ! queue2 ! \
 h264parse ! matroskamux ! filesink location=v1.mkv &

gst-launch-1.0 imxv4l2videosrc device=/dev/video2 queue-size=24 ! queue2 ! \
 imxipuvideotransform ! queue2 ! imxvpuenc_h264 bitrate=2000 ! queue2 ! \
 h264parse ! matroskamux ! filesink location=v2.mkv &

gst-launch-1.0 imxv4l2videosrc device=/dev/video3 queue-size=24 ! queue2 ! \
 imxipuvideotransform ! queue2 ! imxvpuenc_h264 bitrate=2000 ! queue2 ! \
 h264parse ! matroskamux ! filesink location=v3.mkv &

