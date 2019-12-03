We may not need need to use host networking for the master pod if we can assign an ip to the docker container that we create for pause.

While docker does not have any command flags that let us specify the ip of the created docker container, we can take over creation of the networking namespace for the container and configure it ourselves.

Doing this allows us to assign an ip to the docker container. I tried out the following steps from the docker networking page and it seems to work. It is done without having to start containers in priviledged mode, and an container exit, the cleanup automatically happens.

At one shell, start a container and leave its shell idle and running

$ sudo docker run -i -t --rm --net=none ubuntu /bin/bash
root@63f36fc01b5f:/#

At another shell, learn the container process ID and create its namespace entry in /var/run/netns/
for the "ip netns" command we will be using below

$ sudo docker inspect -f '{{.State.Pid}}' 63f36fc01b5f
2778
$ pid=2778
$ sudo mkdir -p /var/run/netns
$ sudo ln -s /proc/$pid/ns/net /var/run/netns/$pid

Check the bridge's IP address and netmask

$ ip addr show docker0
21: docker0: ...
inet 172.17.42.1/16 scope global docker0
...

Create a pair of "peer" interfaces A and B, bind the A end to the bridge, and bring it up

$ sudo ip link add A type veth peer name B
$ sudo brctl addif docker0 A
$ sudo ip link set A up

Place B inside the container's network namespace, rename to eth0, and activate it with a free IP

$ sudo ip link set B netns $pid
$ sudo ip netns exec $pid ip link set dev B name eth0
$ sudo ip netns exec $pid ip link set eth0 address 12:34:56:78:9a:bc
$ sudo ip netns exec $pid ip link set eth0 up
$ sudo ip netns exec $pid ip addr add 172.17.42.99/16 dev eth0
$ sudo ip netns exec $pid ip route add default via 172.17.42.1

When we finally exit the ubuntu container, Docker cleans up the container, the network namespace is destroyed along with the virtual eth0 — whose destruction in turn destroys interface A out in the Docker host and automatically un-registers it from the docker0 bridge. So everything gets cleaned up without having to run any extra commands.

Clean up dangling symlinks in /var/run/netns

rm /var/run/netns/$pid
