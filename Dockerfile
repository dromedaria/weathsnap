FROM php:5.6-apache
# https://hub.docker.com/_/php/
# https://github.com/docker-library/php/blob/master/5.6/jessie/apache/Dockerfile

# Steps from https://hub.docker.com/_/php/
COPY ./src/ /var/www/html/
# COPY config/php.ini /usr/local/etc/php/

# Not needed, since already set in parent image: https://github.com/docker-library/php/blob/6677546d599d3980781b520f84d03ecaad291dd1/5.6/jessie/apache/Dockerfile
#EXPOSE 80
# Note: In addition to setting EXPOSE, the parent image also set ENTRYPOINT and CMD.

