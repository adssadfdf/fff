FROM alpine:latest

RUN apk add --no-cache curl unzip bash

# Install Xray
RUN curl -Lo xray.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip && \
    unzip xray.zip && chmod +x xray && mv xray /usr/local/bin/xray && \
    rm -rf xray.zip geoip.dat geosite.dat

RUN curl -Lo playit https://github.com/playit-cloud/playit-agent/releases/download/v0.15.26/playit-linux-amd64 && \
    chmod +x playit && \
    mv playit /usr/local/bin/playit && \
    rm -f playit

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

EXPOSE $PORT

CMD ["/start.sh"]
