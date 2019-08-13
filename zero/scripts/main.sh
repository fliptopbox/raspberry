#!/bin/bash


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





# One photo every Nth minute
minutes=1

# Sleep time in seconds
zzz=$(( $minutes*60 ))

# Image destination (relative)
root="../images/"


while true
do


    refresh=""
    today=$(date -u +"%Y/%m/%d/") # UTC date
    dest="$root$today"

    if [ ! -d $dest ]; then
        echo "Creating destination: $dest"
        mkdir -p $dest
        refresh="true"
    fi

    daytime=$(sh day_time.sh $refresh)
    awake=$(echo $daytime | awk '{print $8}')

    if [ "$awake" -eq "1" ]; then
        sh ./single.sh "$zzz"
    else
        echo "Sleeping ... $daytime"
    fi

    sh ./stats.sh "$zzz"
    sleep "${zzz}s"

done
