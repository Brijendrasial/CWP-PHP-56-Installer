# CWP-PHP-56-Installer
Upgrade PHP version to 5.6 in CentOS Web Panel 64bit

==========================================================================================
cd /usr/local/src

rm -rf cwp-php-5-6.sh

wget -c http://dl-package.bullten.in/cwp/cwp-php-5-6.sh

chmod -x cwp-php-5-6.sh

sh cwp-php-5-6.sh | tee /var/log/php_5_6.log

==========================================================================================

You can try below if above url is not working.

==========================================================================================
cd /usr/local/src

rm -rf cwp-php-5-6.sh

wget -c https://raw.githubusercontent.com/Brijendrasial/CWP-PHP-56-Installer/master/cwp-php-5-6.sh

chmod -x cwp-php-5-6.sh

sh cwp-php-5-6.sh | tee /var/log/php_5_6.log

==========================================================================================
