#!/bin/bash

# Leer secretos
DB_NAME="wordpress"
DB_USER="wpuser"
DB_PASS=$(cat /run/secrets/db_password)

WP_ADMIN_USER=$(cat /run/secrets/wp_admin_user)
WP_ADMIN_PASS=$(cat /run/secrets/wp_admin_password)
WP_ADMIN_EMAIL=$(cat /run/secrets/wp_admin_email)

# Directorio temporal de instalación
TMP_DIR="/tmp/wordpress"

mkdir -p $TMP_DIR
cd $TMP_DIR

# Descargar wp-cli
curl -s -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

# Descargar WordPress
./wp-cli.phar core download --allow-root

# Crear archivo de configuración
./wp-cli.phar config create \
  --dbname=$DB_NAME \
  --dbuser=$DB_USER \
  --dbpass=$DB_PASS \
  --dbhost=mariadb \
  --allow-root

# Instalar WordPress
./wp-cli.phar core install \
  --url=localhost \
  --title=inception \
  --admin_user=$WP_ADMIN_USER \
  --admin_password=$WP_ADMIN_PASS \
  --admin_email=$WP_ADMIN_EMAIL \
  --allow-root

# Mover todo a /var/www/html
rm -rf /var/www/html/*
cp -r $TMP_DIR/* /var/www/html/

# Iniciar PHP
php-fpm8.2 -F
