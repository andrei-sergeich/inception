#!/bin/sh

#chown -R mysql:mysql /var/lib/mysql
#chmod 755 -R /var/lib/mysql
#mkfifo /var/run/mysqld/mysqld.sock
#touch /var/run/mysqld/mysqld.pid
#chown -R mysql:mysql /var/run/mysqld

if [ ! -d "/var/lib/mysql/$DB_NAME" ]; then
    service mysql start
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME DEFAULT CHARACTER SET utf8;"
    mysql -u root -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' WITH GRANT OPTION;"
    mysql -u root -e "FLUSH PRIVILEGES;"
    mysqladmin -u root password "$DB_ROOT_PASSWORD"
    service mysql stop
fi

/usr/bin/mysqld_safe

# TODO убрать строки 3 - 7, подключиться к БД через CLion (docker inspect mariadb)
