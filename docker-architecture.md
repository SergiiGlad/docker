
https://docs.google.com/presentation/d/1fC9cKR2-kFW5l-VEk0Z5_1vriYpROXOXM_5rhyVnBi4/edit#slide=id.gb6f3e2d2d_2_213

https://github.com/openshift-labs/learn-katacoda



## ARCHITECTURE

 * Containers do not run ON docker. Containers are processes - they run on the Linux kernel. Containers are Linux.
 * The docker daemonis one of the many user space tools/libraries that talks to the kernel to set up container.

## CONTAINERS ARE LINUX

Userspace libraries interact with the kernel to isolate processes

 * Libraries
	LXC, LXD, LibContainer, systemd nspawn, LibVirt
 * Kernel Data Structures
	NameSpaces, Cgroups, SELinux

## THE USER SPACE TOOL CHAIN
On a Single Host

The user space tool chain adds the following:
 * A local daemon
 * Simple CLI/REST interface
 * Support for container images (OCI) and connection to registries

 * **dockerd:** This is the main docker daemon. It handles all docker API calls (docker run, docker build, docker images) through either the unix socket ```/var/run/docker.sock``` or it can be configured to handle requests over TCP. This is the 'main' daemmon and it is started by systemd with the ```/user/lib/systemd/system/docker.service``` unit file.

 * **docker-containerd:** Containerd was recently open sourced as a separate community project. The docker daemon talks to containerd when it needs to fire up a container. More and more plumbing is being added to containerd (such as storage).

 * **docker-containerd-shim:** this is a shim layer which starts the docker-runc-current command with the right options.

 * **docker:** This is the docker command which you typed on the command line.

## THE ORCHECTRATION TOOLCHAINE
On Multiple Hosts

The orchestration toolchain adds the following:
 * More daemons ( it's a party) :)
 * Scheduling across multiple hosts
 * Application Orchestration
 * Distributed builds (OpenShift)
 * Registry (OpenShift)

## CLASS ARCHITECTURE
Bringing it All Together

#### In distributed ssystems, the user must interact through APIs


## THE COMMUNITY LANDSCAPE
Open Source, Leadership & Standards

The landscape is made up of committees, standards bodies, and open source projects:

 * Docker/Moby
 * Kubernetes/OpenShift
 * OCI (Open Container Intiative) Specifications
 * CNCF Cloud NAtive Copmputing Foundation Tecnical Leadership

 
