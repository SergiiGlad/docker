## Registries

#### Registry servers

 * Click: [registry.fedoraproject.org](http://registry.fedoraproject.org)

 * Click: [bitnami.com/containers](http://bitnami.com/containers)

 * Click: [access.redhat.com/containers](https://access.redhat.com/containers)

#### Container Enginers cache Repositories on the container host

There is a little known or understood fact - whenever you pull a container image, each layer is cached locally, mapped into a shared filesystem - typically ```overlay2``` or ```devicemapper```.

###### $ docker info 2>&1 | grep -E 'Storage | Root'

###### $ tree /var/lib/docker/	


## DOCKER SWARM

By default, Docker works as an isolated single-node. All containers are only deployed onto the engine. Swarm Mode turns it into a multi-host cluster-aware engine. ``` docker swarm init ```

###### $ docker swarm join-token -q worker { ask token }
###### $ docker swarm join --token TOKEN server { to join swarm server }

 * **Node**: A Node is an instance of the Docker Engine connected to the Swarm. Nodes are either managers or workers. Managers schedules which containers to run where. Workers execute the tasks. By default, Managers are also workers.

 * **Services**: A service is a nigh-level concept relating to a collection of tasks to be executed by workers. An example of a service is an HTTP Server running as a Docker Container on three nodes.

 * **Load Balancing**: Docker includes a load balancer to process requests across all containers in the service.

## Your first Stack

A stack is a collection of services that are related and usually work together for an application.

## Analyzing Docker Container Performance With Native Tools

https://crate.io/a/analyzing-docker-container-performance-native-tools/

### docker stats

```
$ docker stats
```

### REST API

Like docker stats, the REST API continuously reports a live stream of CPU, memory, and I/O data. However, the API provides longer, live-streaming chunks of JSON, with metrics about the container.

```
$ curl -v --unix-socket /var/run/docker.sock \
  http://localhost/containers/CONTAINER_ID/stats
```  

### cgroups Pseudo Files

cgroups pseudo files are the fastest way to read metrics from Docker containers.

``` $ export CONTAINER_ID=$(docker inspect --format="{{.Id}}" CONTAINER_NAME)```

You can find the memory metrics in the memory.stat file
CPU metrics are contained in the cpuacct.stat file
```
$ cd /sys/fs/cgroup/memory/docker/$CONTAINER_ID
$ cat memory.stat
```

Since each container has a virtual ethernet interface, Docker lets you directly check the TX (transmit) and RX (receive) counters for this interface from inside the container.

```$ cat /proc/$CONTAINER_PID/net/dev```

### Wrap Up

* The docker stats command is good for small scale use, with a few containers running on a single host.
* The Docker REST API is good when you have multiple containers running on multiple hosts, and you'd like to retrieve the stats remotely.
* The cgroups pseudo files are the fastest and most efficient way to get stats, and are suitable for for large setups where performance is important.

