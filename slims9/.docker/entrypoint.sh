# TUDO!!!!!
#!/usr/bin/env bash
echo
echo
echo "-=-=-=-[ Slims 9 Bulian ]-=-=-=-"
echo 
echo 


# start and configure psql server
/etc/init.d/mariadb start 

# start mysql secure installattion 
# please don't report, ignore the hardcoded cred!!!
mysql -u root -e "SET PASSWORD FOR 'root'@localhost = PASSWORD('root');"
mysql -u root -proot -e "Create database senayan;"


echo "Configuring Mysql Server!!!\n"
echo "Changing MySQL Log file location!!!\n"
sed -i 's/^#general_log_file/ general_log_file/' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i 's/^#general_log/ general_log/' /etc/mysql/mariadb.conf.d/50-server.cnf
echo "log_output = 'FILE'" >> /etc/mysql/mariadb.conf.d/50-server.cnf
mkdir /var/log/mysql && touch /var/log/mysql/mysql.log && chmod 777 /var/log/mysql/mysql.log
echo "Mysql Config Done. Restarting the service!!!\n"
/etc/init.d/mariadb restart


echo "Changing File directories permission!!!\n" 
chmod -R 755 /var/www/html
chown -R www-data:www-data /var/www/html
echo "Permission Change Done!!!\n"

echo "Changing xdebug configuraattion!!!\n" 
echo "xdebug.mode = debug\nxdebug.idekey = vsc\nxdebug.client_host = host.docker.internal\nxdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "Xdebug Config Change Done!!!\n"


# Restarting Apache server
service apache2 restart

# start apache server
/usr/sbin/apache2ctl -D FOREGOUND

# stayin alive
/bin/bash -c 'while [[ 1 ]]; do sleep 60; done';




