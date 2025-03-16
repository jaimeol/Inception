
FROM debian:bookworm

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
	php-fpm \
	php-mysqli \
	curl

COPY www.conf /etc/php/8.2/fpm/pool.d/.
COPY config.sh .
RUN chmod +x config.sh
CMD ["./config.sh"]