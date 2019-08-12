#!/bin/bash

w=640
h=480

abs=`pwd`
frames=".frames"
output="$abs/images/clip-${w}x${h}.mkv"

#frames=`find images/ -regex ".*jpg$" -printf "'file $abs/%p'\n" | sort -V`
find images/ -regex ".*jpg$" -printf "file $abs/%p\n" | sort -V > $frames

#echo $frames
#ffmpeg -f concat -safe 0 -i "${frames}" -vf scale=$wx$h test.mkv
#ffmpeg -f concat -safe 0 -i <(find images/ -regex ".*jpg$" -printf "'file $abs/%p'\n" | sort -V) -vf scale=$wx$h test.mkv
ffmpeg -y -f concat -safe 0 -i $frames -vf scale=${w}x${h} $output

rm $frames
