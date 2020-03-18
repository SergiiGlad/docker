
# From https://github.com/docker-library/golang

### make sure you run apt-get update in the same line with all the packages to ensure all are updated correctly.

```
RUN apt-get update && \
  apt-get install -y --no-install-recommends \
  g++ \
  gcc \
  libc6-dev \
  make \
  && rm -rf /var/lib/apt/lists/*
```

### In order to reduce the complexity of your Dockerfile and prevent some unexpected behavior, it's usually best to always use COPY to copy your files.
```
FROM busybox:1.24

ADD example.tar.gz /add # Will untar the file into the ADD directory
COPY example.tar.gz /copy # Will copy the file directly
```

### In order to use Docker’s cache as smartly as possible, copy over the files that are needed to install all your dependencies first, and then execute the commands that install those dependencies. 
```
# !!! ANTIPATTERN !!!
COPY ./my-app/ /home/app/
RUN npm install # or RUN pip install or RUN bundle install
# !!! ANTIPATTERN !!!
```

```
COPY ./my-app/package.json /home/app/package.json # Node/npm packages
WORKDIR /home/app/
RUN npm install

# Maybe you have to install python packages too?
COPY ./my-app/requirements.txt /home/app/requirements.txt
RUN pip install -r requirements.txt
COPY ./my-app/ /home/app/
```
### While simple, using the latest tag for an image means that your build can suddenly break if that image gets updated.

```
FROM node:latest
```

### Using external services during the build. The app  might not be available during building image time

```
# !!! ANTIPATTERN !!!
COPY /YOUR-PROJECT /YOUR-PROJECT
RUN python manage.py migrate

# runserver would actually try to the migration, but imagine it doesn’t
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
# !!! ANTIPATTERN !!!
```

### Adding EXPOSE and ENV at the top of your Dockerfile

```
ENV GOLANG_VERSION 1.7beta1
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOLANG_DOWNLOAD_SHA256 a55e718935e2be1d5b920ed262fd06885d2d7fc4eab7722aa02c205d80532e3b

RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
 && echo "$GOLANG_DOWNLOAD_SHA256  golang.tar.gz" | sha256sum -c - \
 && tar -C /usr/local -xzf golang.tar.gz \
 && rm golang.tar.gz

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

```

### Multiple FROM statements

Docker will just use the last FROM specified and ignore everything before that.

```
# !!! ANTIPATTERN !!!
FROM node:6.2.1
FROM python:3.5

CMD ["sleep", "infinity"]
# !!! ANTIPATTERN !!!

```

### Multiple services running in the same container

If you want to quickly setup a Django+Nginx application for development, it might make sense to just run them in the same container and have a different Dockerfile in production where they run separately.


### Volumes in your image are added when you run your container, not when you build it.

```
FROM busybox:1.24
VOLUME /data
RUN echo "hello-world!!!!" > /data/myfile.txt

CMD ["cat", "/data/myfile.txt"]

$ docker run volume-in-build
cat: can't open '/data/myfile.txt': No such file or directory
```

###  A common example of this is updating the local package index and installing packages in two separate steps. 
```
FROM ubuntu:18.04
RUN apt -y update
RUN apt -y install nginx php-fpm
```

We’ve added a second package to the installation command run by the
second instruction. If a significant amount of time has passed since the
previous image build, the new build might fail. That’s because the package
index update instruction (RUN apt -y update) has not changed, so
Docker reuses the image layer associated with that instruction. Since we
are using an old package index, the version of the php-fpm package we
have in our local records may no longer be in the repositories, resulting in
an error when the second instruction is run

from https://runnable.com






