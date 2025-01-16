#!/bin/bash

DB_DIR="/var/lib/mysql"

if [ ! -d "$DB_DIR/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --basedir=/usr --datadir="$DB_DIR"
fi

sed -i "s|bind-address\s*=\s*127.0.0.1|bind-address = 0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

mysqld_safe --datadir="$DB_DIR" &
sleep 5

echo "Configuring MariaDB..."

mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"

mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"

mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_ADMIN_USER}'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_ADMIN_USER}'@'%';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ADMIN_USER}'@'%' WITH GRANT OPTION;"

mysql -e "FLUSH PRIVILEGES;"

wait
