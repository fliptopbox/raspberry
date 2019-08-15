#!/bin/bash

this=`readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0`
Q=`dirname "${this}"`

#    
#     ██████████   ██████   ██ ███████
#    ░░██░░██░░██ ░░░░░░██ ░██░░██░░░██
#     ░██ ░██ ░██  ███████ ░██ ░██  ░██
#     ░██ ░██ ░██ ██░░░░██ ░██ ░██  ░██
#     ███ ░██ ░██░░████████░██ ███  ░██
#    ░░░  ░░  ░░  ░░░░░░░░ ░░ ░░░   ░░
#
#   
#   1.  Runs and infinte loop that takes a photo
#   2.  Creates the daily folder destination
#   3.  Once a day grabs the sunrise-sunset.json
#   4.  Determines if the camera should sleep
#
#
#






while true
do

    . "$Q/config.sh"

    # Image destination (relative)
    root="$relativeStills/"

    # Sleep time in seconds
    zzz="$sleepInterval"


    refresh=""
    begin=`date +%s`
    today=$(date -u +"%Y/%m/%d/") # UTC date
    dest="$root$today"

    if [ ! -d $dest ]; then
        echo "Creating destination: $dest"
        mkdir -p $dest
        refresh="true"
    fi

    daytime=$(./day_time.sh $refresh)
    awake=$(echo $daytime | awk '{print $8}')

    if [ "$awake" -eq "1" ]; then
        hires=$(./single.sh "$zzz" | awk '{print $1}')
        ./resize.sh "$hires"

    else
        echo "Sleeping ... $daytime"
    fi

    finish=`date +%s`
    runtime=$((finish-begin))

    ./stats.sh $zzz $runtime
    sleep "${zzz}s"

done
