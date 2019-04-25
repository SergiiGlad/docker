

## Application Container Engine

No one is perfect - There is a perfectly wonderful code.


  * __Dependencies__: Developers rarely write every bit of code that makes up their application. More often they leverage code or even other applications written by other developers. Examples of this include something as simple as "importing" a module or library into code to simplify a complex task like time/date manipulation to a web developers need for a web server to host their web application. Everything an application needs outside of the code the developer directly writes is a "dependency".
  * __Efficient__: Virtual machines have long been used by companies to run applications in a more efficient method than having independent physical servers for every application. The move to VMs was a step for efficiency, but a VM includes far more than most applications need to run. Containers provide a significant improvement in efficiencies for running applications in the areas of CPU, memory and storage space.
  * __Isolated__: When running, each application should be contained within it's own execution space and not have access to, or be impacted by, other applications running. The reasons for this include security concerns as well as application stability and conflict isolation.
  * __Host Platform__: Like virtual machines, containers must be executed on some host platform. A single host platform should be able to run many containers simultaneously, each in their isolated environment.


## Cgroups
В современных дистрибутивах управление контрольными группами реализовано через systemd, однако сохраняется возможность управления при помощи библиотеки libcgroup и утилиты cgconfig.

  * > blkio
  * > cpu
  * > cpuacct
  * > cpuset
  * > devices
  * > freezer
  * > memory
  * > net_cls
  * > perf_event
  * > hugetlb

## Linux Namespaces

  * > PID, Process ID
  * > NET, Networking
  * > PC, InterProcess Communication
  * > MNT, Mount
  * > UTS, Unix Timesharing System

## Capabilities

  * man 7 capabilities

## Waht is a container?

#### Processes

 ###### $ docker run -d --name=db redis:alpine
 
 ###### $ ps aux | grep redis-server
 
 ###### $ docker top db
 
 ###### $ ps aux | grep <PPID>
 
 ###### $ pstree -c -p -A $(pgrep dockerd)

#### Process Directory

 ###### $ DBPID=$(pgrep redis-server)
 ###### $ ls /proc/$DBPID
 ###### $ cat /proc/$DBPID/environ

#### Namespaces

 List all the namespaces with:
 ###### ls -lha /proc/$DBPID/ns/

#### Cgroup (Control Groups)
 ###### $ cat /proc/$DBPID/cgroup
 ###### $ cat /sys/fs/cgroup/cpu,cpuacct/docker/$DBPID/cpu.shares
 ###### $ ls /sys/fs/cgroup/memory/docker/$DBPID

#### Capabilities

Capabilities are grouping about what a process or user has permission to do.
 ###### $ cat /proc/$DBPID/status | grep ^Cap
 
 ### Unshare can launch "contained" processes.
 
 ###### $ unshare --help
 
 https://www.katacoda.com/courses/containers-without-docker/what-is-a-container

## DOCKER SWARM

By default, Docker works as an isolated single-node. All containers are only deployed onto the engine. Swarm Mode turns it into a multi-host cluster-aware engine. ``` docker swarm init ```

###### $ docker swarm join-token -q worker { ask token }
###### $ docker swarm join --token TOKEN server { to join swarm server }

 * **Node**: A Node is an instance of the Docker Engine connected to the Swarm. Nodes are either managers or workers. Managers schedules which containers to run where. Workers execute the tasks. By default, Managers are also workers.

 * **Services**: A service is a nigh-level concept relating to a collection of tasks to be executed by workers. An example of a service is an HTTP Server running as a Docker Container on three nodes.

 * **Load Balancing**: Docker includes a load balancer to process requests across all containers in the service.


