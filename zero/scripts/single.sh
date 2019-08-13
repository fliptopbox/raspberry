#!/bin/bash

# create todays destination
root="../images/"
today=$(date -u +"%Y/%m/%d/") # UTC date
mtime=$(date -u +"%H%M")
dest="$root$today"
prefix="still"
delay=$1

mkdir -p $dest

free=`df -h | grep /dev/root | sed -E 's/.*\s([0-9]+%).*/\1/g'`

# Derive the last frame number
next=$(sh next_frame.sh | awk '{print $1}')

# create the new filename
# eg. seq-00000001-EV1.jpg
filename="$prefix-$mtime-$next.jpg"
nextfile="$dest$filename"

raspistill -ISO 100 -q 100 -o $nextfile

now=$(date -u +"%H:%M:%S") # UTC date
echo "$nextfile ($free) $now ${delay}s"
