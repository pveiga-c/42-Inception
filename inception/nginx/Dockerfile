# Usar imagem Debian Bullseye como base
FROM debian:bullseye

# Definir a variável para evitar prompts durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Expor a porta 443 (SSL)
EXPOSE 443

# Instalar Nginx e OpenSSL, e limpar a cache do apt
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    nginx \
    openssl && \
    rm -rf /var/lib/apt/lists/*

# Criar diretório para certificados SSL
RUN mkdir -p /etc/nginx/ssl /run/nginx

# Gerar um certificado SSL autoassinado
ARG COUNTRY=PT
ARG STATE=Lisboa
ARG LOCALITY=Lisboa
ARG ORGANIZATION=MyCompany
ARG UNIT=IT
ARG COMMON_NAME=localhost

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/server.crt \
    -keyout /etc/nginx/ssl/server.key \
    -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/OU=${UNIT}/CN=${COMMON_NAME}"

# Definir permissões dos certificados
RUN chmod 644 /etc/nginx/ssl/server.crt /etc/nginx/ssl/server.key

# Copiar arquivos de configuração do Nginx
COPY ./tools/nginx.conf /etc/nginx/nginx.conf
# COPY ./tools/server.conf /etc/nginx/conf.d/server.conf

# Ajustar permissões para o diretório do Nginx
RUN chown -R www-data:www-data /var/www/html

# Iniciar o Nginx no modo foreground
CMD ["nginx", "-g", "daemon off;"]

# Redefinir o DEBIAN_FRONTEND para evitar afetar outros processos
ENV DEBIAN_FRONTEND=
