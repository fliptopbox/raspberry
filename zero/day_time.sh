#!/bin/bash

#url="https://api.sunrise-sunset.org/json?lat=51.5465589&lng=-0.0352543&date=today"
#wget $url -O - > day_time.json

# Extract the civil_twilight_(begin|end) attributes
json=`cat day_time.json | sed -r 's/.*("civ[^,]+").*("civ[^,]+").*/\1;\2/g'`

#
# extract the respective time values
read sunrise <<< $(echo $json | awk -F";" '{print $1}' | sed -r 's/.*"([^\s]+)".*/\1/g')
read sunset <<< $(echo $json | awk -F";" '{print $2}' | sed -r 's/.*"([^\s]+)".*/\1/g')

# time offset to before/after the sunrise/sunset event
offset="90 minutes"

# Convert the AM/PM time to 24hour time and extract the time value as long (eg. 0345512)
sunrise=$(date -d "$sunrise-$offset" | awk '{print $4}' | sed -r s/\://g)
sunset=$(date -d "$sunset+$offset" | awk '{print $4}' | sed -r s/\://g)

echo "sunrise" $sunrise "sunset" $sunset
