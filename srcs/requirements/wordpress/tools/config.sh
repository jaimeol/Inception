#!/bin/bash

# Leer secretos
DB_NAME="wordpress"
DB_USER="wpuser"
DB_PASS=$(cat /run/secrets/db_password)

WP_ADMIN_USER=$(cat /run/secrets/wp_admin_user)
WP_ADMIN_PASS=$(cat /run/secrets/wp_admin_password)
WP_ADMIN_EMAIL=$(cat /run/secrets/wp_admin_email)
WP_USER=$(cat /run/secrets/wp_user)
WP_USER_PASS=$(cat /run/secrets/wp_user_password)
WP_USER_EMAIL=$(cat /run/secrets/wp_user_email)

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

# Crear o actualizar usuario adicional
if ./wp-cli.phar user get "$WP_USER" --allow-root > /dev/null 2>&1; then
  echo "Usuario $WP_USER ya existe, actualizando contraseña..."
  ./wp-cli.phar user update "$WP_USER" --user_pass="$WP_USER_PASS" --allow-root
else
  echo "Creando usuario $WP_USER..."
  ./wp-cli.phar user create "$WP_USER" "$WP_USER_EMAIL" \
    --user_pass="$WP_USER_PASS" \
    --role=author \
    --allow-root
fi

# Mover todo a /var/www/html
rm -rf /var/www/html/*
cp -r $TMP_DIR/* /var/www/html/

if [ ! -d /run/php ]; then
  mkdir -p /run/php
fi

php-fpm7.4 -F

