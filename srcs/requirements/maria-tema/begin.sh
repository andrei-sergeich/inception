#!/bin/bash

sed -i "s/bind-ad/\#bind-ad/" "/etc/mysql/mariadb.conf.d/50-server.cnf"
sed -i "s/\#port  /port   /" "/etc/mysql/mariadb.conf.d/50-server.cnf"
if [ ! -d /var/lib/mysql/wordpress/ ]; then
service mysql start
echo "CREATE DATABASE IF NOT EXISTS wordpress;"| mysql -u root
echo "CREATE USER IF NOT EXISTS 'cmero'@'%' IDENTIFIED BY 'cmero_pass';"| mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'cmero'@'%' WITH GRANT OPTION;"| mysql -u root
echo "FLUSH PRIVILEGES;"| mysql -u root
mysqladmin -u root password "${DB_USER_PASSWORD}"
service mysql stop
else
mkdir /var/run/mysqld
mkfifo var/run/mysqld/mysqld.sock
touch /var/run/mysqld/mysqld.pid
chown -R mysql /var/run/mysqld
fi
chown -R mysql:mysql /var/lib/mysql

mysqld