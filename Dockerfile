FROM alpine:latest

# Install dependencies
RUN apk add --no-cache curl unzip ca-certificates openssl jq bash

# Install Xray
RUN curl -Lo xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip xray.zip && \
    chmod +x xray && \
    mv xray /usr/local/bin/xray && \
    rm -rf xray.zip geoip.dat geosite.dat

# Install cloudflared (Cloudflare Tunnel client)
RUN curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared

# Copy configs
COPY config.json /etc/xray/config.json
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]
