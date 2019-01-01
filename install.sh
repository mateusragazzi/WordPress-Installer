echo "Hi! Thanks for using this script."
echo "What'll be the name of your website? (single name, without spaces)"
read site_name
check if file exists
if [ -e latest.tar.gz ]; then
   rm -rf latest.tar.gz
fi
echo "Alright! Wait a minute, we'll download the newest version for you."
wget http://wordpress.org/latest.tar.gz
tar -zxvf latest.tar.gz
rm -rf latest.tar.gz
mv wordpress ../$site_name

echo "Let's setup your database."
echo "Please enter your MySQL user:"
read sql_user
echo "create database $site_name" | mysql -u $sql_user -p

echo "All done! You can access it via http://localhost/$site_name"
echo "The name of your database is: $site_name"

exit
