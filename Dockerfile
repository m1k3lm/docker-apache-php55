FROM ubuntu:14.04
MAINTAINER Alexander Schenkel <alex@alexi.ch>

VOLUME ["/var/www"]

RUN apt-get update && \
    apt-get install -y \
      apache2 \
      php5 \
      php5-cli \
      libapache2-mod-php5 \
      php5-gd \
      php5-json \
      php5-ldap \
      php5-mysql \
      php5-curl \
      php5-xdebug \      
      mcrypt \
      php5-mcrypt \      
      php5-pgsql     

RUN php5enmod mcrypt
RUN php5enmod xdebug
#Set up debugger
RUN echo "xdebug.remote_enable=1" >> /etc/php5/apache2/conf.d/20-xdebug.ini
#Please provide your host (local machine IP) instead of 192.168.2.117
RUN echo "xdebug.remote_host=mysql_server" >> /etc/php5/apache2/conf.d/20-xdebug.ini

COPY apache_default /etc/apache2/sites-available/000-default.conf
COPY run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN a2enmod rewrite

EXPOSE 80
CMD ["/usr/local/bin/run"]
