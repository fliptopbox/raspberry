#!/bin/bash

# this=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
# Q=`dirname "${this}"`
# . "$Q/config.sh"

# remoteRsyncServer="bruce@lithium"
# remoteImageDest="Projects/github/raspberry/zero/images"
# relativeImages="../images"
# relativeStills="../images/still"
# sleepInterval=$(( 1*60 )) # seconds


. ./config.sh

# create todays destination
today=$(date -u +"%Y/%m/%d/") # UTC date
mtime=$(date -u +"%H%M") # UTC date

root="$relativeStills/"
dest="$root$today"

prefix="still"
delay=$1

mkdir -p $dest

free=`df -h | grep /dev/root | sed -E 's/.*\s([0-9]+%).*/\1/g'`

# Derive the last frame number
next=$(./next_frame.sh | awk '{print $1}')

# create the new filename
# eg. seq-00000001-EV1.jpg
filename="$prefix-$mtime-$next.jpg"
nextfile="$dest$filename"

raspistill \
    -t $cameraTimeout \
    -ISO $ISO \
    -q $jpgQuality \
    -o $nextfile


now=$(date -u +"%H:%M:%S") # UTC date
echo "$nextfile ($free) $now ${delay}s"
