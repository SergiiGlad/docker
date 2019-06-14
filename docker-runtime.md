
*Tell me and I forget*
*Teach me and I remember*
*Involve me and I learn*
	
*Benjamin Franklin*
(Probably inspired by Chinese Confucian philosopher Xunzi)


## Container Training

https://container.training
http://github.com/jpetazzo/container.training

Exercises

 * [Play-With-Docker](http://www.play-with-docker.com)

 * [Katacoda Kubernetes playground](https://katacoda.com/courses/kubernetes/playground)

 * [Play with Kubernetes](https://labs.play-with-k8s.com)

 * [DevNet k8s sandbox](https://devnetsandbox.cisco.com) Contiv within Kubernetes cluster)



## Runtime metrics


### Collect Docker metrics via pseudo-file

###### $ cat /sys/fs/cgroup/cpuacct/docker/$CONTAINER_ID/cpuacct.stat

#### Network pseudo-file

###### $ CONTAINER_PID=`docker inspect -f '{{ .State.Pid }}' $CONTAINER_ID`
###### $ cat /proc/$CONTAINER_PID/net/dev   

### Stats command

###### $ docker stats { live stream a container's runtime metrics }

``` /sys/fs/cgroup ``` Control groups are exposed through a pseudo-filesystem.

$ grep cgroup /proc/mounts { To figure out where your control groups are mounted }

``` /proc/<pid>/cgroup ``` which control groups a process belongs to

``` /sys/fs/cgroup/memory/docker/<longid>/ ``` the memory metrics for a Docker container ID

### API

The daemon listens on ```unix:///var/run/docker.sock``` to allow only local connections by the root user. 


## Docker plugins

#### Network plugin

https://www.weave.works/install-weave-net/

$ curl -L https://github.com/weaveworks/weave/releases/dwonload/v2.3.0/weave -o /usr/bin/weave && /usr/bin/weave

$ weave launch

$ weave status



#### Finding the web server port in a script

###### $ docker port <containerID> 80

#### Finding the container's IP address

###### $ docker inspect --format '{{ .NetworkSettings.IPAddress }}' <yourContainerID>

#### on the host, get the container's PID:

###### $ docker inspect --format {{.State.Pid}} <container_name_or_ID>

