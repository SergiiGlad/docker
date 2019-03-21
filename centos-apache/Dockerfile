# This is a comment line
FROM centos
LABEL description="This is a custom httpd container image"
MAINTAINER John Doe <jdoe@xyz.com>

RUN yum -y update; yum clean all
RUN yum -y install httpd; yum clean all
RUN echo "Apache" >> /var/www/html/index.html

EXPOSE 80

ENV LogLevel "info"

ADD https://drive.google.com/open?id=1b5sqTT-qbj1yQvMgcEznt_e2BMLxBJ7s  /var/www/html
COPY ./src/ /var/www/html

RUN rm -rf /run/httpd/*
ENTRYPOINT ["/usr/sbin/apachectl"]
CMD ["-D", "FOREGROUND"]


