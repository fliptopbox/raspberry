#!/bin/bash

w=640
h=480

abs=`pwd`
frames="frames.tmp"
output="$abs/images/clip-${w}x${h}.mkv"

# ffmpeg -f concat -safe 0 -i <(find images/ -regex ".*jpg$" -printf "file `pwd`/%p\n" | sort -V) -vf scale=640x480 text.mkv
#frames=`find images/ -regex ".*jpg$" -printf "'file $abs/%p'\n" | sort -V`
find images/ -regex ".*jpg$" -printf "file $abs/%p\n" | sort -V > $frames

ffmpeg -y -f concat -safe 0 -i $frames -vf scale=${w}x${h} $output

rm $frames
