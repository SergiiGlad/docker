Работа с контейнерами Docker. Часть 2. Базовые операции с контейнерами
Андрей Маркелов


$ docker ps



$ docker run --name test alpine bash



$ docker ps -a



$ docker run --name test alpine busybox
$ docker ps -a



$ docker run -it --name ubuntu ubuntu /bin/bash



$ docker ps



$ docker pause ubuntu

$ docker ps



# mount | grep freezer



# ls /sys/fs/cgroup/freezer/system.slice/



# cat /sys/fs/cgroup/freezer/system.slice/docker-9b0117ecb82d6b792c42479d868f9c2b33409f7887cc4b419a02dde676637955.scope/freezer.state



$ docker pause ubuntu
$ docker ps

# cat /sys/fs/cgroup/freezer/system.slice/docker-9b0117ecb82d6b792c42479d868f9c2b33409f7887cc4b419a02dde676637955.scope/freezer.state



$ ps aux | grep Ds



$ docker ps -aq

$ docker images -q



$ docker rm $(docker ps -aq)

$ docker rmi $(docker images -q)



$ docker run -d -p 8888:80 --name my-httpd httpd



$ docker ps



# iptables -L DOCKER -t nat



$ curl http://10.0.2.7:8888



$ docker exec -it my-httpd bash
root@92722dc668b8:/usr/local/apache2# echo "My Apache server" > /usr/local/apache2/htdocs/index.html
root@92722dc668b8:/usr/local/apache2# exit
$ curl http://10.0.2.7:8888



$ docker run -d -P --name my-httpd httpd



$ docker port my-httpd



$ docker inspect my-httpd2 | nl



$ docker inspect -f '{{ .NetworkSettings.IPAddress}}' my-httpd2



$ docker run -dit --name my-apache-app -v "$PWD":/usr/local/apache2/htdocs/ httpd:2.4



$ mkdir mywww
$ echo "My Apache server - 2" > mywww/index.html
$ docker run -d -p 8889:80 -v /home/andrey/mywww: /usr/local/apache2/htdocs/ --name my-httpd2 httpd
$ curl http://10.0.2.7:8889



# chcon -R -t svirt_sandbox_file_t ~andrey/mywww/



$ docker stop my-httpd2
$ docker rm my-httpd2
$ docker run -itd -p 8889:80 -v /home/andrey/mywww: /usr/local/apache2/htdocs/ --name my-httpd2 httpd
$ curl http://10.0.2.7:8889



$ docker run -v /home/andrey/mywww:/usr/local/apache2/htdocs/ --name my-data httpd echo "Data container"

$ docker ps -a



$ docker run --volumes-from my-data --name test httpd cat /usr/local/apache2/htdocs/index.html



$ docker rm test

$ docker run -d -p 8889:80 --volumes-from my-data  --name my-httpd3 httpd

$ curl http://10.0.2.7:8889



$ docker inspect -f '{{ .HostConfig.VolumesFrom}}' my-httpd3



$ mkdir wwwbackup
$ chcon -R -t svirt_sandbox_file_t ~andrey/wwwbackup



$ docker run --rm --volumes-from my-httpd3 -v /home/andrey/wwwbackup:/backup httpd cp  /usr/local/apache2/htdocs/index.html /backup
$ ls wwwbackup/
