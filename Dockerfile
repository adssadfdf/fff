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
RUN curl -Lo /tmp/ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz && \
    unzip /tmp/ngrok.zip -d /usr/local/bin && \
    chmod +x /usr/local/bin/ngrok && \
    rm -f /tmp/ngrok.zip
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
