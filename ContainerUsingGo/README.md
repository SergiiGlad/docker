## Build Your Container Using Go

http://jpetazzo.github.io/2016/09/09/go-docker/

https://developers.redhat.com/articles/go-container/

### Let's Build And Run

```sh
$ go get github.com/gorilla/mux

$ env GOOS=linux GOARCH=amd64 go build -o simple-webserver

```
To build the image, run ```docker build```

The ```docker build``` command builds Docker images from a Dockerfile and a "context".
A build's context is the set of files located in the specified PATH or URL.
The URL parameter can refer to three kinds of resources:
  * Git repositories
  * pre-packaged tarball
  * plain text file

Insted of specifying a context, you can pass a single text file ```Dockerfile``` in the URL or pipe the file in via STDIN.

```sh

$ docker build -t sergeyglad/simple-webserver .

```

To run the image
```sh

$ docker run --detach -p 3333:3333 sergeyglad/simple-webserver
```

Now, push the image to the registry using the image ID
```sh

$ docker tag sergeyglad/simple-webserver registry-host:5000/myname/rest-api-gorilla:1.0

$ docker push registry-host:5000/myname/rest-api-gorilla:1.0
```

Create a new image from a container's changes that we just run 
```sh
$ docker commit --change="EXPOSE 80" $(docker ps -lq) rest-api-gorilla:2.0
```
docker ps -lq output the ID of the last container that was executed

### The scratch image
```sh
$ cat <<EOF > Dockerfile
FROM scratch
COPY ./hello /hello
ENTRYPOINT ["/hello"]
EOF

docker build -t scratch-hello .
```

### Installing the SSL certificates
```sh
$ cat <<EOF > Dockerfile
FROM alpine:3.4
RUN apk add --no-cache ca-certificates apache2-utils
```



