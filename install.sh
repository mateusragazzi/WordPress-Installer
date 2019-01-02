echo "Hi! Thanks for using this script."
echo "What'll be the name of your website? (single name, without spaces)"
read site_name
#check if file exists
if [ -e latest.tar.gz ]; then
   rm -rf latest.tar.gz
fi
echo "Alright! Wait a minute, we'll download the newest version for you."
wget http://wordpress.org/latest.tar.gz -q --show-progress
tar -zxf latest.tar.gz
rm -rf latest.tar.gz
mv wordpress ../$site_name

#reading informations of MySQL access
echo "Done! Let's setup your database."
echo "Please enter your MySQL user:"
read sql_user
echo "Please enter your MySQL password:"
read sql_pswd

#accessing MySQL and creating database
echo "CREATE DATABASE IF NOT EXISTS $site_name" | mysql -u $sql_user -p$sql_pswd

#edit wp-config-sample file, setting database's informations
sed -i "s/database_name_here*/${site_name}/" ../$site_name/wp-config-sample.php
sed -i "s/username_here*/${sql_user}/" ../$site_name/wp-config-sample.php
sed -i "s/password_here*/${sql_pswd}/" ../$site_name/wp-config-sample.php

echo "All done! You can access it via http://localhost/$site_name"

exit
