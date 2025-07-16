#!/bin/sh

# Set default values
PORT=$PORT
VLESS_UUID=$VLESS_UUID
REALITY_PRIVATE_KEY=$REALITY_PRIVATE_KEY
REALITY_SHORT_ID=$REALITY_SHORT_ID

echo "Starting Xray on port $PORT"
echo "UUID: $VLESS_UUID"
echo "Short ID: $REALITY_SHORT_ID"

# Update config with environment variables
sed -i "s/8080/$PORT/g" /etc/xray/config.json
sed -i "s/your-uuid-here/$VLESS_UUID/g" /etc/xray/config.json
sed -i "s/your-private-key-here/$REALITY_PRIVATE_KEY/g" /etc/xray/config.json
sed -i "s/your-short-id-here/$REALITY_SHORT_ID/g" /etc/xray/config.json

# Start Xray
/usr/local/bin/xray -config /etc/xray/config.json &

# انتظر شوية لحد ما Xray يشتغل
sleep 2

echo "Tunnel starting on port $PORT"

loclx account login # mvwv5SD26237fQ7pH1h3WEUWWxqvTFnIs1Ft3V76

# loclx tunnel tcp --port $PORT
# loclx tunnel tcp --to localhost:$PORT
