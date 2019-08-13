#!/bin/bash


root="../images/"
current=`ls -ltRr $root \
    | grep -E '.*jpg$' \
    | tail -1 \
    | sed -E 's/(.*)-([0-9]{8})(.*)/\2/g' \
    | sed 's/^[0]*//g'`


next=`printf %08d $((current + 1))`
echo "$next $current"
