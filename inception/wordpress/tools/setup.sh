#!/bin/bash

# Carregar variáveis do arquivo .env
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Caminho de instalação do WordPress
# WP_PATH="/var/www/html"

# Permitir tempo para que os serviços necessários estejam disponíveis (ajuste conforme necessário)
sleep 5

# Verifica se o WordPress já está configurado
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo -e "\033[0;32mConfigurando WordPress...\033[0m"

    # Baixar o WordPress core se os arquivos ainda não estiverem no diretório
    wp core download --allow-root --path="$WP_PATH"

    # Criar o arquivo de configuração wp-config.php
    wp config create --allow-root \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="$DB_HOST" \
        --path="$WP_PATH"

    # Instalar o WordPress se ainda não estiver instalado
    wp core install --allow-root \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --path="$WP_PATH"

    # Criar um segundo usuário no WordPress, se configurado
    wp user create --allow-root \
        "$WP_SECOND_USER" \
        "$WP_SECOND_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_SECOND_USER_PASSWORD" \
        --path="$WP_PATH"

    # Ajustar permissões para garantir que o servidor web possa acessar os arquivos
    chown -R www-data:www-data "$WP_PATH"
    chmod -R 755 "$WP_PATH"

    echo -e "\033[0;32mWordPress configurado com sucesso!\033[0m"
else
    echo -e "\033[0;32mWordPress já está configurado.\033[0m"
fi

# Iniciar o serviço PHP-FPM no caso de estar usando PHP-FPM
exec /usr/sbin/php-fpm7.4 -F

# Esperar um pouco para garantir que os serviços estejam estáveis
sleep 2

# Executar o comando final no Dockerfile (PHP-FPM ou Apache no foreground)
exec "$@"
