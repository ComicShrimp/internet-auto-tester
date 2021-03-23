#!/bin/bash

FLAGS=""

if [[ -z "${INTERVAL}" ]]
then
    INTERVAL=3600
fi

if [[ -z "${SERVER_ID}" ]]
then
    FLAGS=""
else
    FLAGS=" -s ${SERVER_ID}"
fi

# Main loop

while true
do
    speedtest $FLAGS | tee output.txt

    LATENCY=$(cat output.txt | grep "Latency:" | awk -F " " '{print $2}')
    DOWNLOAD=$(cat output.txt | grep "Download:" | awk -F " " '{print $3}')
    UPLOAD=$(cat output.txt | grep "Upload:" | awk -F " " '{print $3}')
    PACKET_LOSS=$(cat output.txt | grep "Packet Loss:" | awk -F " " '{print $3}')
    
    # Remove a porcentagem do valor
    PACKET_LOSS=${PACKET_LOSS::-1}

    sleep $INTERVAL
done