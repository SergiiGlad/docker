The main Docker concepts are:

__Node__ - a VM that plays a role of a base for containers. A Node VM is created by Orchestrator on Docker Service activation.

__Master node (manager)__ - a Docker Engine host that handles cluster management tasks such as maintaining cluster state, scheduling services and serving swarm mode HTTP API endpoints.

__Worker Node__ - is a Docker Engine host that executes containers.

__Container__ - is a running instance of an image. It can be created, started, stopped, moved or deleted using API or CLI. It is possible to connect a container to one or more networks, attach storage to it, or even create a new image based on its current state.

__Container Image__ - is a read-only template with instructions to create a Docker container.

__Volume__ - a container directory mapped to a host directory and used to store and share data.

__Docker Registry__ - a repository service that allows to share VM images between nodes. Registry is hosted on a separate VM that is used as a storage for container images.

__Repository__ - an entity within a registry, in which the images are grouped. Typically, repository names are taken according to the OS family used on the images that will be stored in this or that repository (e.g., CentOS).

__Tag__ - images in repositories are referenced by tags, which are typically given according to image OS version (e.g., 6, 7, etc.).

__Service__ - the definition of tasks to execute on the manager or worker nodes. It is the central structure of the swarm system and the primary root of user interaction with the swarm.

