#!/bin/bash



# One photo every 30 minutes
#z=1800

# One photo every 15 minutes
z=900

while true; do

    sh ./single.sh
    sleep $z

done
