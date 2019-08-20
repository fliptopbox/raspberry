#!/bin/bash

# The bootloader will run theses scripts
# Don't forget the trailing &


cd /home/pi/Projects/github/raspberry/zero/
cd scripts/
screen -dmS main ./main.sh

cd ../http/
screen -dmS http python3 -m http.server
