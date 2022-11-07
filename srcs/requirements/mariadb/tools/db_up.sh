#!/bin/sh

cmd="$@"

if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then
    service mysql start
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME DEFAULT CHARACTER SET utf8;"
    mysql -u root -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"
    mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%' WITH GRANT OPTION;"
    mysql -u root -e "FLUSH PRIVILEGES;"
    mysqladmin -u root password "${DB_ROOT_PASSWORD}"
    service mysql stop
fi

# TODO проверить какие таблицы и данные есть в базе после раскатки
echo "MariaDB started on :3306"

#/usr/bin/mysqld_safe
exec $cmd