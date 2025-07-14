# vpn-gateway
A docker client for the IPv64.net VPN gateway.


docker build -t ipv64-vpn-gateway-client .

docker run --rm -it \
  --privileged \
  --cap-add=NET_ADMIN \
  --device /dev/net/tun \
  -e WG_TOKEN="<Copy-Peer-Token-here>" \
  ipv64-vpn-gateway-client
