## Docker Network Drivers

[Docker Networking](https://success.docker.com/article/networking)

host bridge macvlan overlay none 

**Docker networking uses the kernel's networking stack as low level primitives to create higher level network drivers. Simply put, Docker networking is Linux networking. **

#### Host driver

*--net=host effectively turns Docker networking off and containers use the host (or default) networking stack of the host operating system. *

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
	*In this example, the host C1 and C1 all share the same interface  when containers use the host network. *
	*The traffic path goes directly from the container process to the host interface, offering bare-metal performance that is equivalent to a non-containerized process. *
