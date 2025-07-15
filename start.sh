#!/bin/sh

echo "⚙️ Starting Xray + ngrok setup..."

# Update config.json with env values
sed -i "s/8080/$PORT/g" /etc/xray/config.json
sed -i "s/your-uuid-here/$VLESS_UUID/g" /etc/xray/config.json
sed -i "s/your-private-key-here/$REALITY_PRIVATE_KEY/g" /etc/xray/config.json
sed -i "s/your-short-id-here/$REALITY_SHORT_ID/g" /etc/xray/config.json

# Start Xray in background
/usr/local/bin/xray -config /etc/xray/config.json &
echo "✅ Xray started on port $PORT"

# Login to ngrok
ngrok config add-authtoken "$NGROK_AUTHTOKEN"

# Start ngrok TCP tunnel
ngrok tcp $PORT > /dev/null &
sleep 5

# Show tunnel info
echo "🌐 Waiting for ngrok to initialize..."
sleep 5
curl --silent http://localhost:4040/api/tunnels | jq '.tunnels[] | select(.proto=="tcp") | .public_url'

# Keep container alive
tail -f /dev/null
