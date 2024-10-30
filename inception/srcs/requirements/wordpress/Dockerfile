# Use a imagem base Debian Bullseye
FROM debian:bullseye

# Exponha a porta 80 para o serviço HTTP
EXPOSE 9000

# Instalar as dependências: Apache, PHP e extensões necessárias para o WordPress
RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    apache2 \
    php \
    libapache2-mod-php \
    php-mysqli \
    php-gd \
    php-xml \
    php-zip \
    curl \
    ca-certificates \
    tar \
    unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Habilitar o módulo rewrite do Apache
RUN a2enmod rewrite

# Baixar e instalar o WordPress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -zxvf latest.tar.gz && \
    rm latest.tar.gz && \
    mv wordpress/* /var/www/html/ && \
    chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Remover o arquivo index.html padrão do Apache
RUN rm /var/www/html/index.html

# Configurar o diretório de trabalho
WORKDIR /var/www/html

# Iniciar o Apache quando o contêiner iniciar
CMD ["apachectl", "-D", "FOREGROUND"]
