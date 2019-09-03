#!/bin/bash


. config.sh


forcereload=false

# Image destination (relative)
# The destination sub-directory
# eg. "bracket", "still"

capturetype="still"
if [ $bracket -gt 0 ]; then
    capturetype="bracket"
fi

# the destingation folder (still|bracket)
root="$relativeImages/$capturetype/"


if [ "$1" == "force" ]; then
    forcereload=true
    rm $relativeStats
    echo "log=capture;force reload"
fi

# if the stats file already exist ...
# 1. then check the expires date, 
# 2. output the existing stats.txt (ie cache)
# 3. sleep until the current cache expires

if [ -f "$relativeStats" ]; then
    now=`date -u +%s`
    expires=$(cat $relativeStats | sed -En "s/(.*)expires=([0-9]+)(.*)/\2/p")
    datediff=$(( expires-now ))


    if [ $datediff -gt 0 ]; then
        echo "log=using cache"
        echo -e `cat $relativeStats`

        echo "log=retry in (${datediff})"
        sleep "${datediff}s"
    fi
fi


refresh=""
begin=`date +%s`
today=$(date -u +"%Y/%m/%d/") # UTC date
dest="${root}${today}"

if [ ! -d $dest ]; then
    echo "log=creating destination: $dest"
    mkdir -p $dest
    refresh="true"
fi

daytime=$(./day_time.sh $refresh)
awake=$(echo $daytime | awk '{print $8}')

if [ "$stayAwake" == "true" ]; then
    awake=1
fi

if [ "$awake" -eq "1" ]; then
    case $capturetype in
        still)
            echo "log=take still image"
            hires=$(./single.sh "$sleepInterval" | awk '{print $1}')
            ;;

        bracket)
            hms=`date -u +"%H%M"`
            seq=$(./next_frame.sh "$dest" | awk '{print $1}')
            echo "log=take bracket sequence: $hms $seq $dest"

            hires=$(./bracket.sh \
                -p $dest \
                -n "bracket-$hms" \
                -e "$encoding" \
                -b "$bracket" \
                -s $seq \
                | awk '{print $1}')
            ;;
    esac

    # ALWAYS resize one image for the UI display
    ./resize.sh "$hires"

else
    echo "log=sleeping ... $daytime"
fi

finish=`date +%s`
runtime=$(( $finish - $begin ))

echo "log=update stats"
response=$(./stats.sh $sleepInterval $runtime)
echo $response

echo "log=snooze ... $sleepInterval"
sleep $sleepInterval

echo "log=delete cache"
# echo "" > $relativeStats
rm $relativeStats

if [ "$forcereload" == "false" ]; then
    # TODO seperate capture and backup routines
    ./backup.sh &

    echo "log=capture;creating new thread"
    ./capture.sh
fi


