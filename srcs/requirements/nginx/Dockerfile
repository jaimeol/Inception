FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y nginx openssl apt-utils \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/jolivare.crt \
    -keyout /etc/nginx/ssl/jolivare.key \
    -subj "/C=ES/ST=Madrid/L=Madrid/O=42 School/OU=jolivare42/CN=jolivare/"

COPY tools/default /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]