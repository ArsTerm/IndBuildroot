#!/bin/sh

gst-variable-rtsp-server -u \
"imxv4l2videosrc device=/dev/video0 queue-size=24 imx-capture-mode=2 ! queue2 ! c.sink_0 \
imxv4l2videosrc device=/dev/video1 queue-size=24 imx-capture-mode=2 ! queue2 ! c.sink_1 \
imxv4l2videosrc device=/dev/video2 queue-size=24 imx-capture-mode=2 ! queue2 ! c.sink_2 \
imxv4l2videosrc device=/dev/video3 queue-size=24 imx-capture-mode=2 ! queue2 ! c.sink_3 \
imxg2dcompositor name=c background-color=0xffffff keep-aspect-ratio=0 \
sink_0::xpos=0 sink_0::ypos=0 sink_0::width=640 sink_0::height=360 sink_0::fill_color=0x00000000 \
sink_1::xpos=640 sink_1::ypos=0 sink_1::width=640 sink_1::height=360 sink_1::fill_color=0x00000000 \
sink_2::xpos=0 sink_2::ypos=360 sink_2::width=640 sink_2::height=360 sink_2::fill_color=0x00000000 \
sink_3::xpos=640 sink_3::ypos=360 sink_3::width=640 sink_3::height=360 sink_3::fill_color=0x00000000 \
! queue2 ! video/x-raw, width=1280, height=720 ! imxipuvideotransform ! queue2 \
! imxvpuenc_h264 bitrate=10000 ! queue2 ! rtph264pay name=pay0 pt=96"
