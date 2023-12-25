#!/bin/bash

# export DOMAIN_NAME=csantivi.42.fr
# export TITLE=wordpress

# export WP_ADMIN_USER=god
# export WP_ADMIN_EMAIL=god@42.fr
# export WP_ADMIN_PASSWD=god1234
# export WP_USER=wpuser
# export WP_EMAIL=wpuser@42.fr
# export WP_PASSWD=wp1234

# export DB_HOST=mariadb
# export DB_NAME=wordpress
# export DB_USER=dbuser
# export DB_PASSWD=db1234
# export DB_ROOT_USER=root
# export DB_ROOT_PASSWD=root1234

mkdir -p /run/php;
if [ ! -f "var/www/html/wp-config.php" ]
then
mkdir -p /var/www/html
cd /var/www/html
wp core download --allow-root

cp wp-config-sample.php wp-config.php
sed -i "s/username_here/$DB_USER/g" wp-config.php
sed -i "s/password_here/$DB_PASSWD/g" wp-config.php
sed -i "s/localhost/$DB_HOST/g" wp-config.php
sed -i "s/database_name_here/$DB_NAME/g" wp-config.php
wp core install --url=$DOMAIN_NAME --title=$TITLE \
    --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWD \
    --admin_email=$WP_EMAIL --allow-root
wp user create $WP_USER $WP_EMAIL --role=author --user_pass=$WP_PASSWD --allow-root

fi

exec "$@"