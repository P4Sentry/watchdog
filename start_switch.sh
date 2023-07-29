#!/usr/bin/env sh

PORT_NUM=$(expr $1 + 1) # Number of ports of the switch

INTFS_ARG=""
for port in $(seq 1 $PORT_NUM); do
    intf="port$port"
    if ! ip link show $intf &> /dev/null; then
        ip link add $intf link eth0 type macvlan mode vepa  
        ip link set dev $intf up
        ip addr add 192.168.$port.3/24 dev $intf
        ip route add default via 192.168.$port.1 dev $intf
        INTFS_ARG="$INTFS_ARG-i $port@$intf "
    fi
done

simple_switch_grpc --no-p4 $INTFS_ARG-- --grpc-server-addr 0.0.0.0:9559