#!/bin/sh

sed -i -e 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 0.0.0.0:9000/g' /etc/php/7.3/fpm/pool.d/www.conf
wp core download --allow-root --path=/var/www/html/wordpress/
wp config create --allow-root \
				--dbname=wordpress \
				--dbuser="${DB_USER}" \
				--dbhost=mariadb \
				--dbpass="${DB_USER_PASSWORD}"\
				--path=/var/www/html/wordpress/
sleep 10
wp core install --allow-root \
				--url=cmero.42.fr \
				--title=PentagonAlmostOfficialSite \
				--admin_user="${WP_ADMIN}" \
				--admin_password="${WP_ADMIN_PASS}" \
				--admin_email=user@mail.com \
				--path=/var/www/html/wordpress/

wp user create "${WP_USER}" user1@mail.com --role=author --user_pass="${WP_USER_PASS}" --allow-root --path=/var/www/html/wordpress/

/usr/sbin/php-fpm7.3 -F --nodaemonize
