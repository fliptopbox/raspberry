#!/bin/bash

# FFmpeg requires that the "frames" list uses absolute path
# using PWD (to this file) chop off the tail (ie /scripts)
# so the $dest is relative to the parent folder.

w=640
h=480

parent=$(echo `pwd` | sed -r 's/\/([^\/]+)$//');
images="${parent}/images/"

output="${images}clip-${w}x${h}.mkv"
tmp="${parent}/data/~frames"

# ffmpeg -f concat -safe 0 -i <(find images/ -regex ".*jpg$" -printf "file `pwd`/%p\n" | sort -V) -vf scale=640x480 text.mkv
#frames=`find images/ -regex ".*jpg$" -printf "'file $abs/%p'\n" | sort -V`
find $images -regex ".*jpg$" -printf "file %p\n" | sort -V > $tmp

ffmpeg -y -f concat -safe 0 -i $tmp -vf scale=${w}x${h} $output

rm $tmp
