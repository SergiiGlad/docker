## Docker 

[ Learning about Docker, Docker Hub, and Containers ] (https://github.com/imapex-trainnig/mod_adv_docker)

[ Play with Docker ] (https://labs.paly-with-docker.com)

[ Docker Networking ] (https://success.docker.com/article/networking)

#### Docker Networking

	* host 
	* bridge 
	* macvlan 
	* overlay 
	* none 

#### Network driver summary <https://docs.docker.com/network>


  * __User-defined__ bridge networks are best when you need multiple containers to communicate on the same Docker host.
  * **Host networks** are best when the network stack should not be isolated from the Docker host, but you want other aspects of the container to be isolated.
  * **Overlay networks** are best when you need containers running on different Docker hosts to communicate, or when multiple applications work together using swarm services.
  * **Macvlan networks** are best when you are migrating from a VM setup or need your containers to look like physical hosts on your network, each with a unique MAC address.
  * **Third-party network plugins** allow you to integrate Docker with specialized network stacks.


**Docker networking uses the kernel's networking stack as low level primitives to create higher level network drivers. Simply put, Docker networking is Linux networking.**


## HOST Driver 


* --net=host effectively turns Docker networking off and containers use the host (or default) networking stack of the host operating system. *

	Check that you have a working install docker :
###### $ docker info

	Create containers on the host network
###### $ docker run -itd --net host --name C1 alpine sh 
	-d detached mode: run container in the background 
	-t allocate a pseudo TTY
	-i keep STDIN open

###### $ docker images && docker history alpine ( get history of the image)
###### $ docker ps ( list of running container )
###### $ docker inspect C1
###### $ docker exec -it C1 sh ( connect to container shell)
###### $ docker exec -it C1 sh -c "hostname && ip a && cat /etc/resolv.conf" ( run bash command on container)


*In this example, the host C1 and C1 all share the same interface  when containers use the host network.*
*The traffic path goes directly from the container process to the host interface, offering bare-metal performance that is equivalent to a non-containerized process.*


## BRIDGE Driver 

Bridge network driver which instantiates a Linux bridge called docker0.

##### Default Docker Bridge Network

The default __bridge__ network is the only network that supports legacy links. Name-based service discovery and user-provided IP addresses are **not** supported by the default **bridge** network.

###### $ docker run -it --name c1 busybox sh { Create a busybox container named "c1" and show its IP addresses }
###### $ brctl show 
	The tool brctl on the host shows the Linux bridges that exist in the host networas assigned one subnet from the ranges 172.[17-31].0.0/16 or 192.168.[0-240].0/20 which does not overlap with any existing host interface. 

##### User-Defined Bridge Network

##### **Unlike the default bridge network, user-defined networks supports manual IP address and subnet assignment.**

###### $ docker network create -d bridge --subnet 10.0.0.0/24 my_bridge

**Container can be attached and detached from user-defined network on the fly.**
During container's lifetime , you can connect or disconnect it from user-defined networks on the fly. To remove a container from the default bridge network. you need to stop the container and recreate it with different network option.

###### $ docker network connect my-net my-nginx
###### $ docker network disconnect my-net my-nginx
###### $ docker network ls { show all network interfaces }
	
	container has network connectivity to all intefaces on host
	For new custom network you should run new container

###### $ docker network create -d bridge --subnet 10.0.0.0/24 my_bridge
###### $ docker run -itd --name c2 --net my_bridge busybox sh
###### $ docker run -itd --name c3 --net my_bridge --ip 10.0.0.254 busybox sh

###### $ ip link  { ip link help - all command about link }
	Each veth and Linux bridge interface appears as a link between one of the Linux bridges and the container network namespaces.

**Communication between different Docker networks and and container ingress traffic that originates from outside Docker is firewalled. This is a fundamental security aspect that protects container applications from the outside world and from each other.**

c1 has connectivity to host but doesn't connectivity to c2

##### Ingress access is provided through explicit port publishing. 
###### $ docker run -d --name C2 --net my_bridge -p 5000:80 nginx  { All traffic going to this ip_address:5000 is port published to ip_address:80 of the container interface.}
	-p short form --publish


## OVERLAY Driver Network Architecture

VXLAN is typically deployed in data centers on virtualized hosts, which may
be spread across multiple racks.

IETF VXLAN (RFC 7348) is a data-layer encapsulation format that overlays Layer 2 segments over Layer 3 networks.

	Create an overlay named "ovnet" with the overlay driver

###### $ docker network create -d overlay --subnet 10.1.0.0/24 ovnet

	Create a service from an nginx image and connect it to the "ovnet" overlay network

###### $ docker service create --network ovnet nginx


## MACVLAN Driver

The MACVLAN driver provides direct access between containers and the physical network ( w/o the port mapping ).
MACVLAN use-cases may include:
  * Very low-latency application
  * Network design that requres containers be on the same subnet as and using IPs as the external host network.

Trunking 802.1q to a Linux requires cinfiguration file changes in order to be persistent through a reboot.

	Creation of MACVLAN network "mvnet" bound to eth0 on the host
###### $ docker network create -d macvlan --subnet 192.168.0.0/24 --gateway 192.168.0.1 -o parent=eth0 mvnet

### MACVLAN Benefits and Use Cases

  * Very low latency applications can benefit from the macvlan driver because it does not utilize NAT.
  * MACVLAN can provide an IP per container, which may be a requirement in some environments.
  * More careful consideration for IPAM must be taken in to account.



## None (Isolated) Network Driver

**Docker Engine does not create interfaces inside the container, establish port mapping, or install routes for connectivity. A container using --net=none is completely isolated from other containers and the host.**

	Containers using --net=none or --net=host cannot be connected to any other Docker networks.



