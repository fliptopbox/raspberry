#!/bin/bash

# create todays destination
root="./images/"
today=$(date -u +"%Y/%m/%d/")a # UTC date
dest="$root$today"
prefix="still"
delay=$1

mkdir -p $dest

free=`df -h | grep /dev/root | sed -E 's/.*\s([0-9]+%).*/\1/g'`

# Derive the last frame number
current=`ls -R $root \
    | sort -V \
    | grep -E '[0-9]{8}.*jpg$' \
    | tail -1 \
    | sed -E 's/(.*)([0-9]{8})(.*)/\2/g' \
    | sed 's/^[0]*//g'`

# Increment the last frame number
next=`printf %08d $((current + 1))`

# create the new filename
# eg. seq-00000001-EV1.jpg
filename="$prefix-$next.jpg"
nextfile="$dest$filename"

raspistill -ISO 100 -q 100 -o $nextfile

now=$(date -u +"%H:%M:%S") # UTC date
echo "$nextfile ($free) $now ${delay}s"
