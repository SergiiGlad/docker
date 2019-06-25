# A Practical Introduction to Container Terminology

https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction/

## Container Image

A container image, in its simplest definition, is a file which is pulled down from a Registry Server and used locally as a mount point when starting Containers.

## Container Image Format

Historically, each Container Engine had its container images format. LXD, RKT, and Docker all had their own image formats. Some were made up of a single layer, while others were made up of a bunch of layers in a tree structure. Today, almost all major tools and engines have moved to a format defined by the Open Container Initiative (OCI).This image format defines the layers and metadata within a container image. Essentially, the OCI image format defines a container image composed of tar files for each layer, and a manifest.json file with the metadata.

## Container Engine

A container engine is a piece of software that accepts user requests, including command line options, pulls images, and from the end user’s perspective runs the container.

## Container

A container is a standard Linux process typically created through a clone() system call instead of fork() or exec(). Also, containers are often isolated further through the use of cgroups, SELinux or AppArmor.

## Conatiner Host

The container host is the system that runs the containerized processes, often simply called containers. 

## Registry Server

A registry server is essentially a fancy file server that is used to store docker repositories. Typically, the registry server is specified as a normal DNS name and optionally a port number to connect to. 

## Container Orchestration

A container orchestrator really does two things:

 * Dynamically schedules container workloads within a cluster of computers. This is often referred to as distributed computing.
 * Provides a standardized application definition file (kube yaml, docker compose, etc)

## Container Runtime

A container runtime a lower level component typically used in a Container Engine but can also be used by hand for testing. The Open Containers Initiative (OCI) Runtime Standard reference implementation  is runc. This is the most widely used container runtime, but there are others OCI compliant runtimes, such as crun, railcar, and katacontainers. Docker, CRI-O, and many other Container Engines rely on runc.

## Image Layer

Repositories are often referred to as images or container images, but actually they are made up of one or more layers. Image layers in a repository are connected together in a parent-child relationship. Each image layer represents changes between itself and the parent layer.

## Tag

Typically, tags are used to designate versions of software within in the repository. 

## Repository

When using the docker command, a repository is what is specified on the command line, not an image. In the following command, “rhel7” is the repository.

``` $ docker pull rhel7```

## Namespace

A namespace is a tool for separating groups of repositories. On the public DockerHub, the namespace is typically the username of the person sharing the image, but can also be a group name, or a logical name.

## Kernel Namespace

A kernel namespace is completely different than the namespace we are referring to when discussing Repositories and Registry Servers. When discussing containers, Kernel namespaces are perhaps the most important data structure, because they enable containers as we know them today. Kernel namespaces enable each container to have it’s own mount points, network interfaces, user identifiers, process identifiers, etc

## Graph Driver

When the end user specifies the Tag of a container image to run – by default this is the latest Tag – the graph driver unpacks all of the dependent Image Layers necessary to construct the data in the selected Tag. The graph driver is the piece of software that maps the necessary image layers in the Repository to a piece of local storage. The container image layers can be mapped to a directory using a driver like Overlay2 or in block storage using a driver like Device Mapper. Drivers include: aufs, devicemapper, btrfs, zfs, and overlayfs.

# Container Use Case

* Application Containers
* Operation System Containers
* Pet Containers
* Super Privileged Containers
* Tools & Operation System Software








