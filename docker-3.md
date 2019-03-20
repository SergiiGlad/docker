**Install Docker CE**

***Uninstall any old version of Docker***

sudo yum remove -y docker \
		   docker-client \
		   docker-client-latest \
		   docker-common \
		   docker-latest \
		   docker-latest-logrotate \
		   docker-logrotate \
		   docker-selinux \
		   docker-engine-selinux \
		   docker-engine


***Install Docker***

1. Install required packages

```
sudo yum install -y yum-utils \
	device-mapper-persistent-data \
	lvm2
```	

2. Add the Docker stable repository to yum.
```
sudo yum-config-manager --add-repo \
	https://download.docker.com/linux/centos/docker-ce.repo
```

3. Install Docker CE with yum.
```
sudo yum install -y docker-ce-XX.ce.el7.centos
```

4. Start the docker service.
```
sudo systemctl start docker
```

5. Configure the docker service to start automatically.
```
sudo systemctl enable docker
```

6. Verify `docker` is `active` and `enable`
```
systemctl status docker
```

7. Add permission to the specific user to run docker
```
sudo usermod -aG docker $USERNAME
**relogin**
```

8. Optional Verify docker is working by running a test image.
```
sudo docker run hello-world
```

9. Check version
```
docker version
```

10. Get info about docker
```
docker info
```


