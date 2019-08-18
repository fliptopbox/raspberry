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



# Incoming argument (optional) "true" to trigger API call
update=$1

# Go to google maps to find your lat/lng geolocation
lat=51.5465589
lng=-0.0352543

apiurl="https://api.sunrise-sunset.org/json?lat=$lat&lng=$lng&date=today"
dest="../data/sunrise-sunset.json"

# time offset to before/after the sunrise/sunset event
offset="30 minutes"

# check modified date against roday's date
modified=`date -r $dest +"%m%d"`
today=`date +"%m%d"`

if [ "$modified" == "$today" ]; then
    update=true
fi


# The API call only needs to update once per day
if [ ! -f $dest ] || [ ! -s $update ]; then
    wget $apiurl -O - > $dest
fi


# Extract the civil_twilight_(begin|end) attributes
json=`cat $dest | sed -r 's/.*("civ[^,]+").*("civ[^,]+").*/\1;\2/g'`

# extract the respective time values
sunrise=$(echo $json | awk -F";" '{print $1}' | sed -r 's/.*"([^\s]+)".*/\1/g')
sunset=$(echo $json | awk -F";" '{print $2}' | sed -r 's/.*"([^\s]+)".*/\1/g')


# Convert the AM/PM time to 24hour time and extract the time value as long (eg. 0345512)
sunrise=$(date -d "$sunrise-$offset" | awk '{print $4}' | sed -r s/\://g)
sunset=$(date -d "$sunset+$offset" | awk '{print $4}' | sed -r s/\://g)

# Determine if time is currently between sunrise/sunset
# IMPORTANT! the API delivers UTC without seasonal adjustments
UTC=`date -u +"%H%M%S"`
if [ $UTC -gt $sunrise -a $UTC -lt $sunset ]; then
    daytime=1
else
    daytime=0
fi

echo "sunrise" $sunrise "sunset" $sunset "UTC" $UTC "daytime" $daytime "update" $update
