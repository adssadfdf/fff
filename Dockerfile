FROM alpine:latest

# Install dependencies
RUN apk add --no-cache curl unzip ca-certificates openssl jq bash

# Download Xray
RUN curl -Lo xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip xray.zip && \
    chmod +x xray && \
    mv xray /usr/local/bin/xray && \
    rm -rf xray.zip geoip.dat geosite.dat

# Download ngrok
RUN curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
  | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
  && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
  | sudo tee /etc/apt/sources.list.d/ngrok.list \
  && sudo apt update \
  && sudo apt install ngrok

# Create folders
RUN mkdir -p /etc/xray

# Add config files
COPY config.json /etc/xray/config.json
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Default port (internal only)
ENV PORT=17306
ENV VLESS_UUID=8442ff27-8e79-4f27-b4d2-c3e6447789ea
ENV REALITY_PRIVATE_KEY=8GXPCvZ4ty3uEKxexznrZvCSo3NqYwzKY5dzbaQGWVM
ENV REALITY_SHORT_ID=8236
ENV NGROK_AUTHTOKEN=2zvS3oejdtPQ4HmEpyGGIhwhLbO_9FwbcfpBtqEU4VQHQqSS

# Start
CMD ["/start.sh"]
