#!/bin/bash

# create todays destination
root="../images/"
today=$(date +"%Y/%m/%d/")
dest="$root$today"
prefix="seq"
bracket=3
range=$(($bracket + $bracket + 1))
ev="0"

echo $dest
mkdir -p $dest

# Derive the last frame number
current=`ls -R $root \
    | sort -V \
    | grep -E '[0-9]{8}.*jpg$' \
    | tail -1 \
    | sed -E 's/(.*)([0-9]{8})(.*)/\2/g' \
    | sed 's/^[0]*//g'`

# Increment the last frame number
next=`printf %08d $((current + 1))`


# Generate the bracketed photos
while [ $ev -lt $range ]; do

    # Case linear int to signed byte
    # eg. 1= -24, ... 4=0 ... 7= +24
    exposure=$(( 8*(ev -bracket) ))
    ev=$(($ev + 1))

    # create the new filename
    # eg. seq-00000001-EV1.jpg
    filename="$prefix-$next-EV$ev.jpg"
    nextfile="$dest$filename"

    echo "$nextfile - EV: $exposure"

    raspistill -q 100 -ev $exposure -o $nextfile
done
