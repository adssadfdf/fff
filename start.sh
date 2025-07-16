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
exec /usr/local/bin/xray -config /etc/xray/config.json &

echo "Starting Loophole tunnel on port $PORT..."
/usr/local/bin/loophole http $PORT
# Start Cloudflare tunnel
# cloudflared tunnel --no-autoupdate --url http://localhost:$PORT --token eyJhIjoiNDhmZTUxYjA5MzQzMGNjNjljNjI3MjgxN2U3MTQxNDciLCJ0IjoiODNhNjcyMDctNzI4Zi00NTc3LWI5MTEtZDQwYTIwNTM1ZDMwIiwicyI6Ik56WmtNMk01WmpZdE5HUXlNeTAwWmpNMkxUa3hOek10TWpsa1lUZGpaRFppTmpZdyJ9
