FROM php:8.1-apache 

# Install necessary apt + pip packages
RUN apt-get update && apt-get install iputils-ping net-tools vim sudo python3-pip cron wget mariadb-client mariadb-server zip unzip imagemagick apt-utils -y
RUN service mariadb start
RUN curl -sSLf \
        -o /usr/local/bin/install-php-extensions \
        https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions && \
    chmod +x /usr/local/bin/install-php-extensions && \
    install-php-extensions gettext gd xsl zip xdebug pdo_mysql mysqli
#RUN pecl install xdebug && docker-php-ext-enable xdebug
RUN mkdir -p /home/xdebug
COPY ./.docker/*.sql /home/xdebug/
COPY ./.docker/entrypoint.sh /home/xdebug/entrypoint.sh

# Copy the files
COPY ./slims9.zip /var/www/html/
RUN unzip -q /var/www/html/slims9.zip 
RUN mv /var/www/html/slims9_bulian-master/* /var/www/html/

# Configure apache2
COPY ./.docker/vhost.conf /etc/apache2/sites-enabled/000-default.conf


# Entrypoint for `docker run` command
EXPOSE 80
ENTRYPOINT ["/bin/sh", "/home/xdebug/entrypoint.sh"]
