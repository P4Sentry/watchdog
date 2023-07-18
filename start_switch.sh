#!/usr/bin/env sh

PORT_NUM=$1     # Number of ports of the switch
GRPC_PORT=$2    # gRPC port number

INTFS_ARG=""
for port in $(seq 0 $PORT_NUM); do
    intf="macvlan$port"
    if ! ip link show $intf &> /dev/null; then
        # Should the intefaces be of VLAN type ?
        ip link add $intf link eth0 type macvlan mode bridge
        ip link set dev $intf up
        INTFS_ARG="$INTFS_ARG-i $port@$intf "
    fi
done

simple_switch_grpc --no-p4 $INTFS_ARG-- --grpc-server-addr 0.0.0.0:$GRPC_PORT