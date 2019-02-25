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

#### Network driver summary

  * __User-defined__ bridge networks are best when you need multiple containers to communicate on the same Docker host.
  * **Host networks** are best when the network stack should not be isolated from the Docker host, but you want other aspects of the container to be isolated.
  * **Overlay networks** are best when you need containers running on different Docker hosts to communicate, or when multiple applications work together using swarm services.
  * **Macvlan networks** are best when you are migrating from a VM setup or need your containers to look like physical hosts on your network, each with a unique MAC address.
  * **Third-party network plugins** allow you to integrate Docker with specialized network stacks.


** Docker networking uses the kernel's networking stack as low level primitives to create higher level network drivers. Simply put, Docker networking is Linux networking. **

#### Host driver

* --net=host effectively turns Docker networking off and containers use the host (or default) networking stack of the host operating system. *

###### Check that you have a working install docker :
###### $ docker info

###### Create containers on the host network
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


#### --------- Bridge driver -------------

Bridge network driver which instantiates a Linux bridge called docker0.

###### $ docker run -it --name c1 busybox sh { Create a busybox container named "c1" and show its IP addresses }
###### $ brctl show 
	The tool brctl on the host shows the Linux bridges that exist in the host networas assigned one subnet from the ranges 172.[17-31].0.0/16 or 192.168.[0-240].0/20 which does not overlap with any existing host interface. 

##### Unlike the default bridge network, user-defined networks supports manual IP address and subnet assignment. 

###### $ docker network create -d bridge --subnet 10.0.0.0/24 my_bridge
<<<<<<< HEAD
###### $ docker network ls



=======
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




