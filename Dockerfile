FROM alpine:3.22

ENV WG_TOKEN=""

# install dependencies
RUN apk add --no-cache \
    wireguard-tools \
    iproute2 \
    iputils \
    curl \
    ca-certificates \
    openresolv \
    iptables \
    procps

WORKDIR /opt/app

COPY assets/entrypoint.sh /opt/app/entrypoint.sh

ENTRYPOINT ["/opt/app/entrypoint.sh"]
