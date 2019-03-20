Работа с контейнерами Docker. Часть 1. Основы
Андрей Маркелов


# cat /etc/yum.repos.d/docker.repo
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg


# yum install -y docker-engine
# systemctl start docker.service
# systemctl enable docker.service

# systemctl status docker.service

# docker info

# ls -lh /var/lib/docker/devicemapper/devicemapper/data

OPTIONS='--selinux-enabled --log-driver=journald'

# usermod -aG docker andrey

$ docker search mysql

OPTIONS='--selinux-enabled --log-driver=journald --group=docker'

# ls -l /var/run/docker.sock

$ docker search haproxy

$ docker pull haproxy

$ docker pull haproxy:1.5

[URI репозитория][имя пользователя]имя образа[:тэг]

$ docker images

$ docker rmi $(docker images -q)


$ docker run -it ubuntu

root@d7402d1f7c54:/# cat /etc/*release | grep DISTRIB_DESCRIPTION

$ docker ps

$ docker run -d mysql

$ docker ps -a

$ docker logs peaceful_jones

$ docker run --name mysql-test -e MYSQL_ROOT_PASSWORD=docker -d mysql

$ docker exec -it mysql-test bash

# pstree -p

# pstree -p

# docker top mysql-test

# docker top mysql-test

$ docker ps

$ docker run -it --name mysql-test2 -e MYSQL_ROOT_PASSWORD=docker mysql /bin/bash

root@5c31ad53edb1:/# cat $(which docker-entrypoint.sh)

$ docker ps -a

root@d3d4c9281249:/# pstree -p

root@5c31ad53edb1:/# pstree -p

-----------------------------------------------------------------------------------------

