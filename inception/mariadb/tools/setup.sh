#!/bin/bash

# set -ex # print commands & exit on error (debug mode)

# DB_NAME=MariaDB_database
# DB_USER=MariaDB_useru
# DB_PASSWORD=qwerty
# DB_PASS_ROOT=123456

# GRANT ALL PRIVILEGES ON $DB_NAME.* TO 'root'@'%' IDENTIFIED BY '$DB_PASS_ROOT';

service mariadb start

mariadb -v -u root << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_PASS_ROOT');

EOF

sleep 5

service mariadb stop

exec $@ 