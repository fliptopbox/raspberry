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


. config.sh

# The destination sub-directory
# eg. "bracket", "still"
type="still"

if [ $1 ]; then
    type=$1
fi

echo "hello world"

# run the capture loop
./capture.sh &


# Capture WebSocket messages
while IFS="=" read -r KEY VALUE; 
do
    # echo "[$(date)] ${USER}> ${MSG}" >> chat.log
    echo "[$KEY] >>> ${VALUE}"
done
