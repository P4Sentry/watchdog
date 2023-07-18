# Watchdog

Docker containers that operate as virtual network devices such as switches or routers.

# Table of Contents

# Background Operations

Commands to execute at the host to directly connect two containers via a pair of virtual interfaces (you can imagine it as being a "virtual cable" between the two containers).

These are the commands to **create the interfaces** and **import them to the containers**.

```bash
sudo ip link add veth1 type veth peer name veth2
sudo ip link set veth1 netns $(docker inspect -f '{{.State.Pid}}' container1)
sudo ip link set veth2 netns $(docker inspect -f '{{.State.Pid}}' container2)

docker exec -it container1 ip addr add 192.168.0.1/24 dev veth1
docker exec -it container2 ip addr add 192.168.0.2/24 dev veth2

docker exec -it container1 ip link set veth1 up
docker exec -it container2 ip link set veth2 up
```
