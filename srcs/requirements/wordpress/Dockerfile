FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysqli \
    php7.4-curl \
    php7.4-xml \
    php7.4-mbstring \
    php7.4-zip \
    php7.4-gd \
    php7.4-cli \
    curl unzip

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/config.sh /config.sh
RUN chmod +x /config.sh

VOLUME /var/www/html

CMD ["bash", "/config.sh"]
