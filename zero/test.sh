#!/bin/bash

# create todays destination
root="./zero/"
today=$(date +"%Y/%m/%d/")
dest="$root$today"
prefix="seq"

echo $dest
mkdir -p $dest

# derive the highest frame number
current=`ls -R $root \
    | sort -V \
    | grep -E '[0-9]{8}\.jpg' \
    | tail -1 \
    | sed -E 's/(.*)([0-9]{8})(.*)/\2/g' \
    | sed 's/^[0]*//g'`

# increment the last frame number
next=`printf %08d $((current + 1))`


bracket=3
range=$(($bracket + $bracket + 1))
ev="0"

# Generate the bracketed photos
while [ $ev -lt $range ]; do
    #echo "ev-" . $ev . $(($ev - $bracket)) . $(( 8*(ev -bracket) ))
    ev=$(($ev + 1))

    # create the new filename
    filename="$prefix-EV$ev-$next.jpg"
    nextfile="$dest$filename"

    echo $nextfile
    touch $nextfile
done
# ls -R 2019/ | sort -V | grep seq[0-9] | tail -1 | sed 's/[^0-9]//g' | sed 's/^[0]*//g'
