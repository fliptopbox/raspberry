#!/bin/bash

# The bootloader will run theses scripts
# Don't forget the trailing & 
# or add them to a detached screen session
port=8080
static="../http/"


cd /home/pi/Projects/github/raspberry/zero/
cd scripts/

screen -dmS main ./websocketd --port=$port --staticdir=$static ./main.sh

# http is now handled by apache2
# cd ../http/
# screen -dmS http python3 -m http.server
