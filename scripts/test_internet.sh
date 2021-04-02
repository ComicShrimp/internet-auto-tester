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
    speedtest $FLAGS | tee output.txt || echo "Erro"

    LATENCY=$(cat output.txt | grep "Latency:" | awk -F " " '{print $2}')
    DOWNLOAD=$(cat output.txt | grep "Download:" | awk -F " " '{print $3}')
    UPLOAD=$(cat output.txt | grep "Upload:" | awk -F " " '{print $3}')
    PACKET_LOSS=$(cat output.txt | grep "Packet Loss:" | awk -F " " '{print $3}')
    RESULT_URL=$(cat output.txt | grep "Result URL:" | awk -F " " '{print $3}')

    # Remove % from information
    PACKET_LOSS=${PACKET_LOSS::-1}

    # Send data do influx
    # curl -i -XPOST "http://db:8086/write?db=$INFLUXDB_DB" -u admin:admin --data-binary "download,host=local value=$DOWNLOAD"
    curl --request POST "http://db:8086/api/v2/write?bucket=$INFLUXDB_INIT_BUCKET&org=$INFLUXDB_INIT_ORG" \
        --header "Authorization: Token $INFLUX_TOKEN" \
        --data-raw "
        latency,host=local value=$LATENCY
        download,host=local value=$DOWNLOAD
        upload,host=local value=$UPLOAD
        packet_loss,host=local value=$PACKET_LOSS
        result_url,host=local value=\"$RESULT_URL\"
        "

    sleep $INTERVAL
done