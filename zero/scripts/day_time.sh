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
dest="$relativeData/sunrise-sunset.json"

# time offset to before/after the sunrise/sunset event
offset="30 minutes"

# check modified date against roday's date
modified=`date -r $dest +"%m%d"`
today=`date +"%m%d"`

if [ "$modified" != "$today" ]; then
    update=true
fi

# The API call only needs to update once per day
if [ ! -f $dest ] || [ ! -s $update ]; then
    wget $apiurl -O - > $dest
fi

# Extract the civil_twilight_(begin|end) attributes
# IMPORTANT! the API delivers UTC without seasonal adjustments
json=`cat $dest | sed -r 's/.*("civ[^,]+").*("civ[^,]+").*/\1;\2/g'`

# extract the respective time values
sunrise=$(echo $json | awk -F";" '{print $1}' | sed -r 's/.*"([^\s]+)".*/\1/g')
sunset=$(echo $json | awk -F";" '{print $2}' | sed -r 's/.*"([^\s]+)".*/\1/g')

# Convert the AM/PM time to 24hour time 
sunrise=$(date -d "$sunrise-$offset" | awk '{print $4}')
sunset=$(date -d "$sunset+$offset" | awk '{print $4}')

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
     "update" $update
