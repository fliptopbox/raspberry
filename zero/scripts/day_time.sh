#!/bin/bash
#
#
#   ██████   █████  ██    ██ ████████ ██ ███    ███ ███████ 
#   ██   ██ ██   ██  ██  ██     ██    ██ ████  ████ ██      
#   ██   ██ ███████   ████      ██    ██ ██ ████ ██ █████ 
#   ██   ██ ██   ██    ██       ██    ██ ██  ██  ██ ██    
#   ██████  ██   ██    ██       ██    ██ ██      ██ ███████ 
#                                                           
#
#
#   Save JSON outputted from a URL
#   https://stackoverflow.com/questions/3040904/save-json-outputted-from-a-url-to-a-file


. ./config.sh

# Incoming argument (optional) "true" to trigger API call
update=$1

mkdir -p $relativeData

apiurl="https://api.sunrise-sunset.org/json?lat=$lat&lng=$lng&date=today"
dest="$relativeData/sunrise-sunset"

# time offset to before/after the sunrise/sunset event
offset="15 minutes"

# check modified date against roday's date
modified=`date -r "$dest.json" +"%m%d"`
today=`date +"%m%d"`

if [ "$modified" != "$today" ]; then
    update=true
fi

# The API call only needs to update once per day
if [ ! -f "$dest.json" ] || [ "$update" == "true" ]; then
    wget $apiurl -O - > "$dest.tmp"

    ok=`cat "$dest.tmp" | sed -r 's/.*"status":"(.*)".*/\1/g'`
    if [[ $ok == "OK" ]]; then

        # Extract the civil_twilight_(begin|end) attributes
        # IMPORTANT! the API delivers UTC without seasonal adjustments
        json=`cat "$dest.tmp" | sed -r 's/.*("civ[^,]+").*("civ[^,]+").*/\1;\2/g'`

        # extract the respective time values
        sunrise=$(echo $json | awk -F";" '{print $1}' | sed -r 's/.*"([^\s]+)".*/\1/g')
        sunset=$(echo $json | awk -F";" '{print $2}' | sed -r 's/.*"([^\s]+)".*/\1/g')

        # Convert the AM/PM time to 24hour time 
        sunrise=$(date -d "$sunrise-$offset" | awk '{print $4}')
        sunset=$(date -d "$sunset+$offset" | awk '{print $4}')

        # save the valid json file
        mv -f "$dest.tmp" "$dest.json"

        # Cache the parsed values
        lastupdate=`date -u +"%Y-%m-%dT%H%M%SZ"`
        echo "lastupdate=$lastupdate" > "$dest.txt"
        echo "sunrise=$sunrise" >> "$dest.txt"
        echo "sunset=$sunset" >> "$dest.txt"

    fi

fi


# some default values
lastupdate="Unknown"
sunrise="04:00:00"
sunset="20:00:00"

# try and load the cached values
if [ -f "$dest.txt" ]; then
    . "$dest.txt"
fi

# Cast the time value as long (eg. 0345512)
UTC=`date -u +"%H:%M:%S"`
intUTC=$(echo $UTC | sed 's/\://g')
intSunrise=$(echo $sunrise | sed 's/\://g')
intSunset=$(echo $sunset | sed 's/\://g')

daytime=0

# Determine if time is currently between sunrise/sunset
if [ $intUTC -gt $intSunrise -a $intUTC -lt $intSunset ]; then
    daytime=1
fi

echo "sunrise" $sunrise \
     "sunset" $sunset \
     "UTC" $UTC \
     "daytime" $daytime \
     "update" $update \
     "lastupdate" $lastupdate
