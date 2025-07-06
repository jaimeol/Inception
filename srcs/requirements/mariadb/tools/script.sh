#!/bin/bash
set -e

# Leer contraseña del secreto
DB_PASSWORD=$(cat /run/secrets/db_password)

# Generar init.sql dinámico
cat > /etc/mysql/init.sql << EOF
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'wpuser'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

# Inicializar base de datos si no está inicializada
if [ ! -d /var/lib/mysql/mysql ]; then
    mysql_install_db
fi

# Lanzar mysqld
exec mysqld
