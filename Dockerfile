FROM ubuntu

MAINTAINER Prateek Nayak <prateek.1708@gmail.com>

ENV APACHE_RUN_USER  www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE  /var/run/apache2.pid
ENV APACHE_RUN_DIR   /var/run/apache2
ENV APACHE_LOCK_DIR  /var/lock/apache2
ENV APACHE_LOG_DIR   /var/log/apache2
ENV APACHE_USER_UID 0

# PHP && Apache
RUN apt-get update && apt-get upgrade -y &&\
    DEBIAN_FRONTEND=noninteractive apt-get install -y apache2\
    php5\
    php5-curl\
    php5-gd\
    php-apc\
    apache2-mpm-prefork\
    apache2-utils\
    libapache2-mod-php5 &&\
    rm -rf /var/lib/apt/lists/* &&\
    a2enmod rewrite &&\
    apt-get update &&\
    apt-get install -y openssh-server apache2 supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf 

EXPOSE 22 80

CMD ["/usr/bin/supervisord"]