FROM debian:bookworm

RUN apt update -y && apt upgrade -y && apt install -y mariadb-server

# Copiar la configuración de MariaDB
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

# Copiar el script que inicializa la BD con la contraseña desde secreto
COPY tools/script.sh /usr/local/bin/script.sh

# Permisos para ejecutar el script
RUN chmod +x /usr/local/bin/script.sh

# Crear carpeta necesaria para mysqld
RUN mkdir /run/mysqld

# Puerto MariaDB (opcional, en compose puede hacerse)
EXPOSE 3306

# Ejecutar script.sh que genera init.sql con contraseña de secreto y arranca mysqld
CMD ["/usr/local/bin/script.sh"]
