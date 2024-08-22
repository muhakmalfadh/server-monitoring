#!/bin/bash

read -p "Enter the port for web.listen-address (default: 9100): " PORT

PORT=${PORT:-9100}
LISTEN_ADDRESS=":$PORT"

sudo docker run -d --name node_exporter --net="host" --pid="host" \
-v "/:/host:ro,rslave" prom/node-exporter:v1.8.2 \
--path.rootfs=/host --web.listen-address=$LISTEN_ADDRESS

