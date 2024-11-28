#!/bin/bash

#---------------------------------------------------wp installation---------------------------------------------------#
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

cd /var/www/wordpress
chmod -R 755 /var/www/wordpress/
chown -R www-data:www-data /var/www/html


wp core download --allow-root

wp config create --dbhost=mariadb:3306 --dbname="$MYSQL_DB" \
				--dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASS" --allow-root

wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" \
				--admin_user="$WP_ADMIN_N" --admin_password="$WP_ADMIN_P" \
				--admin_email="$WP_ADMIN_E" --allow-root

wp user create "$WP_SECOND_USER" "$WP_SECOND_USER_EMAI" \
				--user_pass="$WP_SECOND_USER_PASS" --role=author --allow-root

wp theme activate twentytwentyfour --allow-root

#---------------------------------------------------php config---------------------------------------------------#
sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
mkdir -p /run/php
/usr/sbin/php-fpm7.4 -F