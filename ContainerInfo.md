

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


