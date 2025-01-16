#!/bin/bash

DB_DIR="/var/lib/mysql"

if [ ! -d "$DB_DIR/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --basedir=/usr --datadir="$DB_DIR"
fi

mysqld_safe --datadir="$DB_DIR" &
sleep 5

echo "Configuring MariaDB..."

mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"

mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"

mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_ADMIN_USER}'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_ADMIN_USER}'@'%';"

mysql -e "FLUSH PRIVILEGES;"

wait
