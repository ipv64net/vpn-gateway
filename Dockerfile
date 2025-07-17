FROM alpine:3.22

# Installiere alle benötigten Tools
RUN apk add --no-cache \
    wireguard-tools \
    iproute2 \
    iputils \
    curl \
    ca-certificates \
    openresolv \
    iptables \
    procps

WORKDIR /app

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV WG_TOKEN=""

ENTRYPOINT ["/entrypoint.sh"]
