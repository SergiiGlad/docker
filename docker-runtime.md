
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

$ docker stats { live stream a container's runtime metrics }

``` /sys/fs/cgroup ``` Control groups are exposed through a pseudo-filesystem.

$ grep cgroup /proc/mounts { To figure out where your control groups are mounted }

``` /proc/<pid>/cgroup ``` which control groups a process belongs to

``` /sys/fs/cgroup/memory/docker/<longid>/ ``` the memory metrics for a Docker container ID

## Docker plugins

#### Network plugin

https://www.weave.works/install-weave-net/

$ curl -L https://github.com/weaveworks/weave/releases/dwonload/v2.3.0/weave -o /usr/bin/weave && /usr/bin/weave

$ weave launch

$ weave status



## Finding the web server port in a script
```
$ docker port <containerID> 80
32456
```

## Finding the container's IP address

```
$ docker inspect --format '{{ .NetworkSettings.IPAddress }}' <yourContainerID>
172.17.0.3
```
