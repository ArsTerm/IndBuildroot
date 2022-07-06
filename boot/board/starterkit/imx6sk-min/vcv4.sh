#!/bin/sh

let W=$(fbset | grep geometry | awk '{ print $2 }')/2
let H=$(fbset | grep geometry | awk '{ print $3 }')/2

gst-launch-1.0 imxv4l2videosrc device=/dev/video0 queue-size=16 ! \
identity drop-allocation=true ! tee name=t ! queue2 ! imxg2dvideosink force-aspect-ratio=0 \
 window-x-coord=0 window-y-coord=0 window-width=$W window-height=$H \
t. ! queue2 ! imxipuvideotransform ! queue2 ! imxvpuenc_h264 bitrate=2000 ! \
 queue2 ! h264parse ! matroskamux ! filesink location=cv0.mkv &

gst-launch-1.0 imxv4l2videosrc device=/dev/video1 queue-size=16 ! \
identity drop-allocation=true ! tee name=t ! queue2 ! imxg2dvideosink force-aspect-ratio=0 \
 window-x-coord=$W window-y-coord=0 window-width=$W window-height=$H \
t. ! queue2 ! imxipuvideotransform ! queue2 ! imxvpuenc_h264 bitrate=2000 ! \
 queue2 ! h264parse ! matroskamux ! filesink location=cv1.mkv &

gst-launch-1.0 imxv4l2videosrc device=/dev/video2 queue-size=16 ! \
identity drop-allocation=true ! tee name=t ! queue2 ! imxg2dvideosink force-aspect-ratio=0 \
 window-x-coord=0 window-y-coord=$H window-width=$W window-height=$H \
t. ! queue2 ! imxipuvideotransform ! queue2 ! imxvpuenc_h264 bitrate=2000 ! \
 queue2 ! h264parse ! matroskamux ! filesink location=cv2.mkv &

gst-launch-1.0 imxv4l2videosrc device=/dev/video3 queue-size=16 ! \
identity drop-allocation=true ! tee name=t ! queue2 ! imxg2dvideosink force-aspect-ratio=0 \
 window-x-coord=$W window-y-coord=$H window-width=$W window-height=$H \
t. ! queue2 ! imxipuvideotransform ! queue2 ! imxvpuenc_h264 bitrate=2000 ! \
 queue2 ! h264parse ! matroskamux ! filesink location=cv3.mkv &
