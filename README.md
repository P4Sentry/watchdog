# Watchdog

Docker containers that operate as virtual network devices such as switches or routers.

# Table of Contents

1. [Background Operations](#background-operations)

# Background Operations

Commands that are execute at the host to directly connect two containers via a pair of virtual interfaces (you can imagine it as being a "virtual cable" between the two containers).

These are the commands to **create the interfaces** and **import them to the containers**.

```bash
sudo ip link add veth1 type veth peer name veth2

sudo ip link set veth1 up
sudo ip link set veth2 up

sudo ip link set veth1 netns $(docker inspect -f '{{.State.Pid}}' container1)
sudo ip link set veth2 netns $(docker inspect -f '{{.State.Pid}}' container2)

docker exec -it container1 ip addr add 192.168.1.1/24 dev veth1
docker exec -it container2 ip addr add 192.168.1.1/24 dev veth2
```

### Important notes

- The **third octet** of the IP address is directly correlated with the port number on the BMV2 switch.
- The fourth octet **must always be 1** for the imported veth interface.