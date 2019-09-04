## Containers

One of the most common misconceptions about containers is that they act as light virtual machine (VMs). But containers are much more loghtweight than virtual machines: more flexible, scalable and easier to use.

The term "containers" is heavily overused. Also, depending on the context, it can mean different things to different people.

__Traditional Linux containers are really just ordinary processes on a Linux system.__

These groups of processes are isolated from other groups of processes using resource constraints (control groups [cgroups]),
Linux security constraints (Unix permissions, capabilities, SELinux, AppArmor, seccomp, etc), and namespaces (PID,network,mount, etc)

[Containers guide](https://opensource.com/article/18/8/sysadmins-guide-containers)

## Application Container Engine

No one is perfect - There is a perfectly wonderful code. 

One of the best examples of recognizable container software is Docker.


  * __Dependencies__: Developers rarely write every bit of code that makes up their application. More often they leverage code or even other applications written by other developers. Examples of this include something as simple as "importing" a module or library into code to simplify a complex task like time/date manipulation to a web developers need for a web server to host their web application. Everything an application needs outside of the code the developer directly writes is a "dependency".
  * __Efficient__: Virtual machines have long been used by companies to run applications in a more efficient method than having independent physical servers for every application. The move to VMs was a step for efficiency, but a VM includes far more than most applications need to run. Containers provide a significant improvement in efficiencies for running applications in the areas of CPU, memory and storage space.
  * __Isolated__: When running, each application should be contained within it's own execution space and not have access to, or be impacted by, other applications running. The reasons for this include security concerns as well as application stability and conflict isolation.
  * __Host Platform__: Like virtual machines, containers must be executed on some host platform. A single host platform should be able to run many containers simultaneously, each in their isolated environment.

## The Linux container specification uses various kernel features like namespaces, cgroups, capabilities, LSM, and filesystem jails to fulfill the spec.


## Cgroups

Also known as cgroups, they are used to restrict resource usage for a container and handle device access. cgroups provide controls (through controllers) to restrict cpu, memory, IO, pids, network and RDMA resources for the container. For more information, see the kernel cgroups documentation.

В современных дистрибутивах управление контрольными группами реализовано через systemd, однако сохраняется возможность управления при помощи библиотеки libcgroup и утилиты cgconfig.

  * `blkio`
  * `cpu`
  * `cpuacct`
  * `cpuset`
  * `devices`
  * `freezer`
  * `memory`
  * `net_cls`
  * `perf_event`
  * `hugetlb`

## Linux Namespaces

https://github.com/opencontainers/runtime-spec/blob/master/config-linux.md

type are supported:

  * `PID, Process ID` - processes inside the container will only be able to see other processes inside the same container or inside the same pid namespace
  * `NET, Networking`  - the container will have its own network stack 
  * `IPC, InterProcess Communication` - processes inside the conatiner will only be able to communicate to other processes inside the same container via system level IPC
  * `MNT, Mount` - the container will have an isolated mount table
  * `UTS, Unix Timesharing System` - the container will be able to have its own hostname and domain name
  * `USER` - the conatiner will be able to remap user and group IDs from the host to local users and groups within the container
  * `CGROUP` - the container will have an isolated view of the cgroup hierarchy

path - namespace file

## Capabilities

  * man 7 capabilities
  
## Take a look

So, if you define a container as a process with resource constraints, Linux security constraints, and namespaces, by definition every process on a Linux system is in a container. This is why we often say __Linux is containers, containers are Linux__

Path | Descriptions
--- | ---
/proc/PID/cgroup | that the process is in cgroup
/proc/PID/status | you see capabilities
/proc/self/attr/current | SELinux labels
/proc/PID/ns | the list of namespaces the process is in

  
  

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

One of the fundamental parts of a container is namespaces. The concept of namespaces is to limit what processes can see and access certain parts of the system, such as other network interfaces or processes.

 List all the namespaces with:
 ###### ls -lha /proc/$DBPID/ns/

#### Cgroup (Control Groups)

CGroups limit the amount of resources a process can consume. These cgroups are values defined in particular files within the /proc directory.

 ###### $ cat /proc/$DBPID/cgroup
 ###### $ cat /sys/fs/cgroup/cpu,cpuacct/docker/$DBPID/cpu.shares
 
 The memory quotes are stored in a file called ```memory.limit_in_bytes```.
 
 ###### $ ls /sys/fs/cgroup/memory/docker/$DBPID
 
 ###### # echo 1000000 > /sys/fs/cgroup/memory/docker/025f6645e43e28f41c59b9c67779b36e3d2142c319e8d78d10abb782dd8a38aa/memory.limit_in_bytes 
 
 ###### $ docker stats $DBPID --no-stream { view metrics }
 
#### Capabilities

Capabilities are grouping about what a process or user has permission to do.
 
 ###### $ cat /proc/$DBPID/status | grep ^Cap
 
 ### Unshare can launch "contained" processes.
 
 ###### $ unshare --help
 
 ### Chroot

An important part of a container process is the ability to have different files that are independent of the host. This is how we can have different Docker Images based on different operating systems running on our system.

Chroot provides the ability for a process to start with a different root directory to the parent OS. This allows different files to appear in the root
 
 https://www.katacoda.com/courses/containers-without-docker/what-is-a-container
Docker

## Setting up a limit with the memory cgroup

Create a new memory cgroup:
```
$ CG=/sys/fs/cgroup/memory/onehundredmegs
$ sudo mkdir $CG
```
Limit it approximately 100 MB of memory usage:
```
$ sudo tee $CG/memory.memsw.limit_in_bytes <<< 100000000
```
Move the current process to that cgroup:
```
$ sudo tee $CG/tasks <<< $$
```
The current process and all its future children are now limited.


