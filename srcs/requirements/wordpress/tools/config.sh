#!/bin/bash

# Crear el directorio de WordPress si no existe
if [ ! -d "/var/www/html/wordpress" ]; then
    mkdir -p /var/www/html/wordpress
    cd /var/www/html/wordpress

    # Descargar WordPress
    wp core download --allow-root

    # Crear el archivo de configuración de WordPress
    wp config create \
        --dbname=$DB_NAME \
        --dbuser=$MYSQL_ADMIN_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb \
        --allow-root

    # Instalar WordPress
    wp core install \
        --url=jolivare.42.fr \
        --title=Inception \
        --admin_user=$MYSQL_ADMIN_USER \
        --admin_password=$MYSQL_PASSWORD \
        --admin_email=info@example.com \
        --allow-root

    # Instalar y activar un tema
    wp theme install inspiro --activate --allow-root
fi

# Iniciar php-fpm
exec php-fpm7.3 --nodaemon