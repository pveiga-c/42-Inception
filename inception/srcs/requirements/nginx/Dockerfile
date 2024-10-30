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
RUN mkdir -p /etc/nginx/ssl
# Gerar um certificado SSL autoassinado
ARG COUNTRY=PT
ARG STATE=Lisboa
ARG LOCALITY=Lisboa
ARG ORGANIZATION=MyCompany
ARG UNIT=IT
ARG COMMON_NAME=localhost

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/pveiga-c.crt \
    -keyout /etc/nginx/ssl/pveiga-c.key \
    -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/OU=${UNIT}/CN=${COMMON_NAME}"

    
# copy configuration file
COPY ./tools/nginx.conf /etc/nginx/conf.d

RUN mkdir -p /run/nginx


# Start nginx
CMD ["nginx", "-g", "daemon off;"]

# Reset DEBIAN_FRONTEND variable to avoid affecting other processes
ENV DEBIAN_FRONTEND=
