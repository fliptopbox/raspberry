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
today="./sunrise-sunset.json"

# time offset to before/after the sunrise/sunset event
offset="90 minutes"
now=`date +"%H%M%S"`

# The API call only needs to update once per day
# the $update value is an argument sent by ./main.sh
# if the JSON does not exist then call the API
if [[ $update == "true" ||  ! -f $today ]]; then
    wget $apiurl -O - > $today
fi

# Extract the civil_twilight_(begin|end) attributes
json=`cat $today | sed -r 's/.*("civ[^,]+").*("civ[^,]+").*/\1;\2/g'`

# extract the respective time values
read sunrise <<< $(echo $json | awk -F";" '{print $1}' | sed -r 's/.*"([^\s]+)".*/\1/g')
read sunset <<< $(echo $json | awk -F";" '{print $2}' | sed -r 's/.*"([^\s]+)".*/\1/g')


# Convert the AM/PM time to 24hour time and extract the time value as long (eg. 0345512)
sunrise=$(date -d "$sunrise-$offset" | awk '{print $4}' | sed -r s/\://g)
sunset=$(date -d "$sunset+$offset" | awk '{print $4}' | sed -r s/\://g)

# determine if currently between sunrise/sunset
if [ $now -gt $sunrise -a $now -lt $sunset ]; then
    daytime=1
else
    daytime=0
fi

echo "sunrise" $sunrise "sunset" $sunset "now" $now "daytime" $daytime
