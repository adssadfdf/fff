#!/bin/sh

# Set default values
PORT=$PORT
VLESS_UUID=$VLESS_UUID
REALITY_PRIVATE_KEY=$REALITY_PRIVATE_KEY
REALITY_SHORT_ID=$REALITY_SHORT_ID

echo "Starting Xray on port $PORT"
echo "UUID: $VLESS_UUID"
echo "Short ID: $REALITY_SHORT_ID"

# Start Xray
exec /usr/local/bin/xray -config /etc/xray/config.json
