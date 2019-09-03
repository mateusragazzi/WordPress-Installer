#!/bin/bash

echo "Hi! Thanks for using this script."
echo "What'll be the name of your website? (single name, without spaces)"
read site_name

# managing files
if [ -e latest.tar.gz ]; then
    echo "You already have an version of WordPress. Do you want to keep it? (y/n)"
    read option
    if [ $option == "n" ]; then
        echo "Alright! Wait a minute, we'll download the newest version for you."
        rm -rf latest.tar.gz
        wget http://wordpress.org/latest.tar.gz -q --show-progress
    fi
else 
    echo "Alright! Wait a minute, we'll download the newest version for you."
    wget http://wordpress.org/latest.tar.gz -q --show-progress
fi

# creating WordPress instalation folder
tar -zxf latest.tar.gz
mv wordpress ../$site_name
cd ../$site_name/

# reading MySQL access
echo "Done! Let's setup your database."
echo "Please enter your MySQL user:"
read sql_user
echo "Please enter your MySQL password:"
read -s sql_pswd

# accessing MySQL and creating database
echo "CREATE DATABASE IF NOT EXISTS $site_name" | mysql -u $sql_user -p$sql_pswd

# editing wp-config-sample file, setting database's informations
sed -i "s/database_name_here*/${site_name}/" wp-config-sample.php
sed -i "s/username_here*/${sql_user}/" wp-config-sample.php
sed -i "s/password_here*/${sql_pswd}/" wp-config-sample.php

# generating unique keys for WordPress security
# for (( i = 0; i < 8; i++ )); do
#   key=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9$#&/%!@()*' | fold -w 64 | head -n 1)
#   sed -i -e "0,/put\syour\sunique\sphrase\shere/s//${key}/" ../$site_name/wp-config-sample.php
# done

#rename wp-config-sample to wp-config to end the installation
cp wp-config-sample.php wp-config.php

echo "All done! You can access it via http://localhost/$site_name"
exit