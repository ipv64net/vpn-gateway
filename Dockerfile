FROM alpine:3.22

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

COPY assets/entrypoint.sh /opt/app/entrypoint.sh

WORKDIR /opt/app
ENTRYPOINT ["/opt/app/entrypoint.sh"]
