#!/bin/sh

gst-launch-1.0 -e alsasrc device="hw:$1" ! audioconvert ! alsasink device="hw:$2"
