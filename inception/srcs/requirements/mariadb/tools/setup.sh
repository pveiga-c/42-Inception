#!/bin/bash

# DB_NAME=MariaDB_database
# DB_USER=MariaDB_user
# DB_PASSWORD=qwerty
# DB_PASS_ROOT=123456

# Inicia o MariaDB apenas se não estiver em execução
if ! pgrep mariadbd > /dev/null; then
    service mariadb start
    sleep 5  # Aguarda o serviço estar totalmente inicializado
fi


mariadb -u root << EOF
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('$DB_PASS_ROOT');

EOF

sleep 5

service mariadb stop

exec "$@" 