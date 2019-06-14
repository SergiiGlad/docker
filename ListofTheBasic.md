docker command | desc
--- | ---
`docker build -t friendlyhello . ` | Create image using this directory's Dockerfile
`docker run -p 4000:80 friendlyhello`|  Run "friendlyname" mapping port 4000 to 80
`docker run -d -p 4000:80 friendlyhello`| Same thing, but in detached mode
`docker container ls`                    | List all running containers
`docker container ls -a`             | List all containers, even those not running
`docker container stop <hash>`         |  Gracefully stop the specified container
`docker container kill <hash>`        | Force shutdown of the specified container
`docker container rm <hash>`       | Remove specified container from this machine
`docker container rm $(docker container ls -a -q)`       |  Remove all containers
`docker image ls -a `                        |  List all images on this machine
`docker image rm <image id>`         |  Remove specified image from this machine
`docker image rm $(docker image ls -a -q)` |  Remove all images from this machine
`docker login `        |  Log in this CLI session using your Docker credentials
`docker tag <image> username/repository:tag` | Tag <image> for upload to registry
`docker push username/repository:tag`        |   Upload tagged image to registry
`docker run username/repository:tag  `         |  Run image from a registry
`docker run -ti --rm --pid=host myhtop`         |  Join host namespace to htop
`docker run -ti --rm --pid=container:rhel myhtop  `   | Join another container's pid namespace can be used for debugging that container
`docker run -ti --rm --uts="host" alpine hostname  `         | Setting the hostname and the domain that is visible to running process
`docker inspect -f "{{.State.StartedAt}}" my-container `         |  last timr the container was (re)started
`docker run --restart=always redis `         |  Always restart the container regardless of the exit status
`docker run --security-opt no-new-privileges -it centos bash `         |  raise privileges as su and sudo will no longer work
 
  


