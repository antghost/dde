#!/bin/bash
Device=${1:-docker0}
IP=`ip -4 addr show scope global dev $Device | grep inet | awk '{print $2}' | cut -d / -f 1 | sed -n 1p`
echo "$Device: $IP"
