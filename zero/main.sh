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
#
#
#
#




# ffmpeg -f concat -safe 0 -i <(find images/ -regex ".*jpg$" -printf "file `pwd`/%p\n" | sort -V) -vf scale=640x480 text.mkv

# One photo every 30 minutes
#z=1800

# One photo every 15 minutes
z=60

# Set time range
hour=$(date +"%H")
late="23"
early="03"

awake=$(echo `sh ./day_time.sh` | awk '{print $8}')
echo "AWAKE: $awake"


while true
do

    if [ "$hour" -lt "$late" ] && [ "$hour" -gt "$early" ]; then
        sh ./single.sh "$z"
        sh ./stats.sh "$z"
    else
        echo "Sleeping ... $hour ($early-$late) $(date)"
    fi

    sleep "${z}s"

done
