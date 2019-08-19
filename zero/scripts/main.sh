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



# The destination sub-directory
# eg. "bracket", "still"
type="still"

if [ $1 ]; then
    type=$1
fi


while true
do

    . "$Q/config.sh"

    # Image destination (relative)
    root="$relativeImages/$type/"

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
        case $type in
            still)
                echo "take still image"
                hires=$(./single.sh "$zzz" | awk '{print $1}')
                ;;
            bracket)
                echo "take bracket sequence"
                hms=`date -u +"%H%M%S"`
                seq=$(./next_frame.sh "$dest" | awk '{print $1}')
                hires=$(./bracket.sh \
                    -p $dest \
                    -n "bracket-$hms-$seq" \
                    | awk '{print $1}')
                ;;
        esac

        # ALWAYS resize one image for the UI display
        ./resize.sh "$hires"

    else
        echo "Sleeping ... $daytime"
    fi

    finish=`date +%s`
    runtime=$((finish-begin))

    ./stats.sh $zzz $runtime
    sleep "${zzz}s"

done
