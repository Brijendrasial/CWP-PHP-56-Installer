#!/bin/bash

# PHP 5.6 Installer in CentOS Web Panel

# Simple Bash script by Bullten Web Hosting Solutions [http://www.bullten.com]

CDIR='/usr/local/php-5-6'
Repo='http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm'
PHPDown='http://php.net/distributions'
package_56='php-5.6.7.tar.gz'

RED='\033[01;31m'
RESET='\033[0m'
GREEN='\033[01;32m'

clear

echo -e "$GREEN******************************************************************************$RESET"
echo -e "   PHP 5.6 Installation in CentOS Web Panel [http://centos-webpanel.com] $RESET"
echo -e "               Install and enable PHP 5.6                              $RESET"
echo -e "       Bullten Web Hosting Solutions http://www.bullten.com/"
echo -e "   Web Hosting Company Specialized in Providing Managed VPS and Dedicated Server   "
echo -e "$GREEN******************************************************************************$RESET"
echo " "
echo " "
echo -e $RED"This script will install ZendGuard Loader on your system"$RESET
echo -e $RED""
echo -n  "Press ENTER to start the installation  ...."
read option


clear
echo -e $RED"Enabling repository"$RESET
echo ""
sleep 3

rpm -ivh $Repo

echo -e $RED"Repository enabled"$RESET
echo ""
sleep 3

echo -e $RED"Downloading needed dependencies"$RESET
echo ""
sleep 3

yum -y install gcc make gcc-c++ cpp kernel-headers.x86_64 \
	libxml2-devel openssl-devel bzip2-devel libjpeg-devel \
	libpng-devel freetype-devel openldap-devel postgresql-devel \
	aspell-devel net-snmp-devel libxslt-devel libc-client-devel \
	libicu-devel gmp-devel curl-devel libmcrypt-devel pcre-devel \
	sqlite-devel db4-devel enchant-devel libXpm-devel mysql-devel \
	readline-devel libedit-devel recode-devel libtidy-devel libtool-ltdl-devel

echo ""
echo -e $RED"Downloading of needed dependencies completed"$RESET

clear
echo ""
echo -e $RED"Installing PHP 5.6"$RESET
echo ""
sleep 5

rm -rf $CDIR; mkdir -p $CDIR
cd $CDIR
wget -c $PHPDown/$package_56
tar zxvf $package_56
cd php-5.6.7

./configure --with-bz2 \
	--prefix=/usr/local/php \
	--with-apxs2 \
	--with-curl \
	--with-libdir=/usr/lib64 \
	--with-config-file-path=/usr/local/php \
	--with-config-file-scan-dir=/usr/local/php/php.d \
	--with-iconv \
	--with-gd \
	--with-jpeg-dir=/usr/local/php \
	--with-png-dir \
	--with-freetype-dir=/usr/local/php \
	--enable-gd-native-ttf \
	--with-kerberos \
	--enable-mbstring \
	--with-mcrypt \
	--with-mhash \
	--with-mysql \
	--with-sqlite3 \
	--with-mysql=mysqlnd \
	--with-mysqli=mysqlnd \
	--with-mysql-sock=/var/lib/mysql/mysql.sock \
	--with-xsl \
	--with-pspell \
	--with-openssl \
	--with-gettext \
	--with-pcre-regex \
	--with-libxml-dir=/usr/local/php \
	--with-pdo-mysql \
	--with-regex \
	--with-pic \
	--with-pear=/usr/local/php/pear \
	--with-gmp \
	--enable-zip \
	--with-zlib \
	--enable-inline-optimization \
	--enable-mbregex \
	--enable-opcache \
	--enable-fpm \
	--enable-posix \
	--enable-calendar \
	--enable-bcmath \
	--enable-exif \
	--enable-phar \
	--enable-ftp \
	--enable-pdo \
	--enable-soap \
	--enable-sockets \
	--enable-intl \
	--with-xmlrpc \
	--without-pdo-sqlite

make && make install

echo ""
echo -e $RED"Doing final configuration"$RESET
echo ""
sleep 3

rm -rf /usr/local/php/php.ini
cp php.ini-production /usr/local/php/php.ini

CHKEXTENSIONTDIR=`/usr/local/php/bin/php-config --extension-dir`;grep ^extension_dir /usr/local/php/php.ini || echo "extension_dir='$CHKEXTENSIONTDIR'" >> /usr/local/php/php.ini

rm -rf /usr/local/bin/php
ln -s /usr/local/php/bin/php /usr/local/bin/php

echo ""
echo -e $RED"Restarting Apache"$RESET
echo ""
sleep 3

service httpd restart

sleep 2

echo -e $RED"Installation completed"$RESET
echo ""
sleep 3

php -v