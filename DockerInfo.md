

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

