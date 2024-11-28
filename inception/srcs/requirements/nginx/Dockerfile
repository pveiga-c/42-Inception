#Nginx Dockerfile

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl

ARG		COUNTRY=PT
ARG		STATE=Lisbon
ARG		LOCALITY=lisbon
ARG		ORGANIZATION=42Lisboa
ARG		UNIT=pveiga-c
ARG		COMMON_NAME=pveiga-c

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/pveiga-c.key \
	-out /etc/nginx/ssl/pveiga-c.crt \
    -subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/OU=${UNIT}/CN=${COMMON_NAME}"

COPY ./tools/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/wordpress

RUN chown -R www-data:www-data /var/www/wordpress

CMD ["nginx", "-g", "daemon off;"]