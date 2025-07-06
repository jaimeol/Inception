
FROM debian:bookworm

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
	php-fpm \
	php-mysqli \
	curl

COPY conf/www.conf /etc/php/8.2/fpm/pool.d/.
COPY tools/config.sh .
RUN chmod +x config.sh

VOLUME /var/www/html

CMD ["./config.sh"]
