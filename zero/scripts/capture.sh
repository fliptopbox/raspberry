#!/bin/bash


. config.sh

# Some UI events force a reload but
# interupting the loop should not
# create an additional thread!

forcereload=false
if [ "$1" == "force" ]; then
    forcereload=true
    echo "log=capture;force reload"
    echo "" > $relativeStats
fi

# Image destination (relative)
# The destination sub-directory
# eg. "bracket", "still"

capturetype="still"
if [ $bracket -gt 0 ]; then
    capturetype="bracket"
fi

# the destingation folder (still|bracket)
root="$relativeImages/$capturetype/"



# if the stats file already exist ...
# 1. then check the expires date, 
# 2. output the existing stats.txt (ie cache)
# 3. sleep until the current cache expires

if [ -f $relativeStats ]; then
    now=`date -u +%s`
    expires=$(cat $relativeStats | sed -En "s/(.*)expires=([0-9]+)(.*)/\2/p")
    datediff=$(( expires-now ))
    pause=$([[ $expires -gt 0  && $datediff -gt 0 ]] && echo 1 || echo 0)

    echo "log=capture;pause=$pause"
    echo "log=capture;expires=$expires"
    echo "log=capture;datediff=$datediff"

    if [[ $pause -gt 0 ]]; then
        echo "log=using cache"
        echo -e `cat $relativeStats`

        echo "log=retry in (${datediff})"
        sleep "${datediff}s"
    fi
fi


begin=`date +%s`
today=$(date -u +"%Y/%m/%d/") # UTC date
dest="${root}${today}"

refresh=false
if [ ! -d $dest ]; then
    echo "log=creating destination: $dest"
    mkdir -p $dest
    refresh=true

    # TODO seperate backup routine
    ./backup.sh &

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


if [[ $forcereload == true ]]; then
    echo "log=capture;exiting thread ($forcereload)"
    exit
fi


echo "log=snooze ... $sleepInterval"
sleep "$sleepInterval"

echo "log=delete cache"
echo "" > $relativeStats

echo "log=capture;creating new thread"
./capture.sh
