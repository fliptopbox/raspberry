#!/bin/bash

# The bootloader will run theses scripts
# Don't forget the trailing &


cd /home/pi/Projects/github/raspberry/zero/

screen -dmS main sh ./main.sh
screen -dmS http python3 -m http.server

