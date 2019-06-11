# Docker reference run

https://docs.docker.com/engine/reference/run/


## Network settings
  
   --dns=[]           : Set custom dns servers for the container
   ---
   --network="bridge" : Connect a container to a network
   * 'bridge': create a network stack on the default Docker bridge
   * 'none': no networking
   * 'container:<name|id>': reuse another container's network stack
   * 'host': use the Docker host network stack
   * '<network-name>|<network-id>': connect to a user-defined network
   ---
   --network-alias=[] : Add network-scoped alias for the container
   ---
   --add-host=""      : Add a line to /etc/hosts (host:IP)
   ---
   --mac-address=""   : Sets the container's Ethernet device's MAC address
   ---
   --ip=""            : Sets the container's Ethernet device's IPv4 address
   ---
   --ip6=""           : Sets the container's Ethernet device's IPv6 address
   ---
   --link-local-ip=[] : Sets one or more container's Ethernet device's link local IPv4/IPv6 addresses
   ---

### Your container will use the same DNS servers as the host by default, but you can override this with --dns.

### By default, the MAC address is generated using the IP address allocated to the container.

Network |	Description
--- | ---
none 	| No networking in the container.
bridge (default) |	Connect the container to the bridge via veth interfaces.
host 	| Use the host's network stack inside the container.
container:<name|id> |	Use the network stack of another container, specified via its name or id.
NETWORK |	Connects the container to a user created network (using docker network create command)

## Network: none

With the network is ```none`` a container will not have access to any external routes. The container will still have a ```loopback``` interface enabled in the container but it does not have any routes to external traffic.

## Network: bridge

With the network set to ```bridge``` a container will use docker’s default networking setup. A bridge is setup on the host, commonly named ```docker0```, and a pair of ```veth``` interfaces will be created for the container. One side of the ```veth``` pair will remain on the host attached to the ```bridge``` while the other side of the pair will be placed inside the container’s namespaces in addition to the ```loopback interface```. An IP address will be allocated for containers on the bridge’s network and traffic will be routed though this bridge to the container.

Containers can communicate via their IP addresses by default. To communicate by name, they must be linked.

## Network: host

With the network set to ```host``` a container will share the host’s network stack and all interfaces from the host will be available to the container. The container’s hostname will match the hostname on the host system. Note that ```--mac-address``` is invalid in host netmode. Even in host network mode a container has its own UTS namespace by default. As such ```--hostname``` is allowed in host network mode and will only change the hostname inside the container. Similar to ```--hostname, the --add-host, --dns, --dns-search, and --dns-option``` options can be used in host network mode. These options update /etc/hosts or /etc/resolv.conf inside the container. No change are made to /etc/hosts and /etc/resolv.conf on the host.

Compared to the default bridge mode, the host mode gives _significantly better networking performance_ since it uses the host’s native networking stack whereas the bridge has to go through one level of virtualization through the docker daemon. It is recommended to run containers in this mode when their networking performance is critical, for example, a production Load Balancer or a High Performance Web Server.

**Note:** ```--network="host"``` gives the container full access to local system services such as D-bus and is therefore considered insecure.

## Network: container

With the network set to ```container``` a container will share the network stack of another container. The other container’s name must be provided in the format of ```--network container:<name|id>```. Note that ```--add-host``` ```--hostname``` ```--dns``` ```--dns-search``` ```--dns-option``` and ```--mac-address``` are invalid in container netmode, and ```--publish``` ```--publish-all``` ```--expose``` are also invalid in container netmode.

Example running a Redis container with Redis binding to ```localhost``` then running the ```redis-cli``` command and connecting to the Redis server over the ```localhost``` interface.

```
$ docker run -d --name redis example/redis --bind 127.0.0.1
$ # use the redis container's network stack to access localhost
$ docker run --rm -it --network container:redis example/redis-cli -h 127.0.0.1
```


## User-defined network

You can create a network using a Docker ```network driver``` or an ```external network driver plugin```. You can connect multiple containers to the same network. Once connected to a user-defined network, the containers can communicate easily using only another container’s IP ```address``` or ```name```.

For overlay networks or custom plugins that support multi-host connectivity, containers connected to the same multi-host network but launched from different Engines can also communicate in this way.

The following example creates a network using the built-in bridge network driver and running a container in the created network

```
$ docker network create -d bridge my-net
$ docker run --network=my-net -itd --name=container3 busybox
```

## Managing /etc/hosts

Your container will have lines in ```/etc/hosts``` which define the hostname of the container itself as well as ```localhost``` and a few other common things. The ```--add-host``` flag can be used to add additional lines to /etc/hosts.


### If a container is connected to the default ```bridge``` network and linked with other containers, then the container’s /etc/hosts file is updated with the linked container’s name.

**Note** Since Docker may live update the container’s ```/etc/hosts``` file, there may be situations when processes inside the container can end up reading an empty or incomplete ```/etc/hosts``` file. In most cases, retrying the read again should fix the problem.
