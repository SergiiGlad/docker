## Registries

#### Fedora Registry

 * Click: [registry.fedoraproject.org](registry.fedoraproject.org)

## DOCKER SWARM

By default, Docker works as an isolated single-node. All containers are only deployed onto the engine. Swarm Mode turns it into a multi-host cluster-aware engine. ``` docker swarm init ```

###### $ docker swarm join-token -q worker { ask token }
###### $ docker swarm join --token TOKEN server { to join swarm server }

 * **Node**: A Node is an instance of the Docker Engine connected to the Swarm. Nodes are either managers or workers. Managers schedules which containers to run where. Workers execute the tasks. By default, Managers are also workers.

 * **Services**: A service is a nigh-level concept relating to a collection of tasks to be executed by workers. An example of a service is an HTTP Server running as a Docker Container on three nodes.

 * **Load Balancing**: Docker includes a load balancer to process requests across all containers in the service.

## Your first Stack

A stack is a collection of services that are related and usually work together for an application.
