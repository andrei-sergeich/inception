#!/bin/bash

chown -R www-data:www-data /var/www/html/wordpress/
chmod -R 775 /var/www/
mkdir -p /run/php/
touch /run/php/php7.3-fpm.pid

wp config create --allow-root \
                --dbname=wordpress \
                --dbuser="${DB_USER}" \
                --dbhost=mariadb \
                --dbpass="${DB_USER_PASSWORD}" \
                --path=/var/www/html/wordpress/
sleep 10
wp core install --allow-root \
                --url=cmero.42.fr \
                --title=Pentagon-Almost-Official-Site \
                --admin_user="${WP_ADMIN}" \
                --admin_password="${WP_ADMIN_PASS}" \
                --admin_email="${WP_ADMIN_EMAIL}" \
                --path=/var/www/html/wordpress/

wp user create "${WP_USER}" "${WP_USER_EMAIL}" --role=author --user_pass="${WP_USER_PASS}" --allow-root --path=/var/www/html/wordpress/


# Немного оптимизации
#echo "Wordpress: Start to create users..."
#if ! [[ -f /var/www/html/wordpress/wp-config.php ]]; then
#    mkdir -p /var/www/html/wordpress/
#    cd /var/www/html/wordpress/;
#
#    # Создаем папку с сайтом
#    mkdir -p /var/www/html/wordpress/mysite;
#    # cp /var/www/html/wordpress/index.html /var/www/html/wordpress/mysite/index.html;
#
#    # wp core download --allow-root;
#    # mv /var/www/wp-config.php /var/www/html/wordpress/
#
#    echo "Wordpress: Users created!"
#    # cоздаем рут-пользователя
#    wp core install --allow-root --url=${DOMAIN_NAME} --title=${WORDPRESS_NAME} --admin_user=${WORDPRESS_ROOT_LOGIN} --admin_password=${MYSQL_ROOT_PASSWORD} --admin_email=${WORDPRESS_ROOT_EMAIL};
#    wp core config --allow-root --dbhost=${DB_HOST} --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_USER_PASSWORD}
#    # cоздаем второго пользователя
#    wp user create --allow-root ${DB_USER} ${WORDPRESS_USER_EMAIL} --user_pass=${DB_USER_PASSWORD} --role=author
#
#    # wp core install --url=${DOMAIN_NAME} --title=${TITLE} --admin_user=${USER_NAME} --admin_password=${DB_ROOT_PASSWORD} --admin_email=${USER_ADMIN_EMAIL} --skip-email --allow-root
#    # wp user create ${DB_USER} ${USER_EMAIL} --allow-root --role=subscriber --user_pass=${DB_USER_PASSWORD}
#
#else
#    echo "Wordpress: Users already exists!"
#fi

# enable redis cache
#sed -i "40i define( 'WP_REDIS_HOST', '${REDIS_HOST}' );"    /var/www/html/wordpress/wp-config.php
#sed -i "41i define( 'WP_REDIS_PORT', 6379 );"               /var/www/html/wordpress/wp-config.php
#sed -i "42i define( 'WP_REDIS_TIMEOUT', 1 );"               /var/www/html/wordpress/wp-config.php
#sed -i "43i define( 'WP_REDIS_READ_TIMEOUT', 1 );"          /var/www/html/wordpress/wp-config.php
#sed -i "44i define( 'WP_REDIS_DATABASE', 0 );\n"            /var/www/html/wordpress/wp-config.php
#
#cd /var/www/html/wordpress/ || echo "cd failed"
#wp plugin install redis-cache --activate --allow-root
#wp plugin update --all --allow-root
#wp redis enable --allow-root

echo "Wordpress started on :9000"

/usr/sbin/php-fpm7.3 -F
