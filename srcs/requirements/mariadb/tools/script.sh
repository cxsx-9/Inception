#!/bin/bash

service mariadb start

# If the database directory does not exist
if [ ! -d "/var/lib/mysql/$DB_NAME" ]
then
mysql_secure_installation << EOF

Y
Y
$DB_ROOT_PASSWD
$DB_ROOT_PASSWD
Y
Y
Y
Y
EOF

echo "CREATE DATABASE IF NOT EXISTS $DB_NAME;" | mysql
echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD';" | mysql
echo "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWD';" | mysql
echo "FLUSH PRIVILEGES;" | mysql
fi

service mariadb stop

exec "$@"