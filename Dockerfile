FROM alpine:latest

RUN apk add --no-cache curl unzip bash

# Install Xray
RUN curl -Lo xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip xray.zip && chmod +x xray && mv xray /usr/local/bin/xray && \
    rm -rf xray.zip geoip.dat geosite.dat

# Install Cloudflared
RUN curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 -o /usr/local/bin/cloudflared && \
    chmod +x /usr/local/bin/cloudflared

ARG PORT=17306
ARG VLESS_UUID=8442ff27-8e79-4f27-b4d2-c3e6447789ea
ARG REALITY_PRIVATE_KEY=8GXPCvZ4ty3uEKxexznrZvCSo3NqYwzKY5dzbaQGWVM
ARG REALITY_SHORT_ID=8236

ENV PORT=$PORT
ENV VLESS_UUID=$VLESS_UUID
ENV REALITY_PRIVATE_KEY=$REALITY_PRIVATE_KEY
ENV REALITY_SHORT_ID=$REALITY_SHORT_ID

# Copy config
COPY config.json /etc/xray/config.json
COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 8080

CMD ["/start.sh"]
