#!/bin/bash

echo "Installing prerequisites"
apt-get install libssh2-1 libssh2-1-dev -y &>/dev/null

echo "Downloading pecl-networking-ssh2"
wget https://github.com/php/pecl-networking-ssh2/archive/master.zip &>/dev/null

echo "Installing pecl-networking-ssh2"
unzip master.zip &>/dev/null
cd pecl-networking-ssh2-master &>/dev/null
phpize &>/dev/null
./configure &>/dev/null
make &>/dev/null
make install &>/dev/null
cd ..
rm -r master.zip pecl-networking-ssh2-master

echo "Adding ssh2 module config file"
cat > /etc/php/7.2/fpm/conf.d/20-ssh2.ini << EOF
; configuration for php ssh2 module
; priority=20
extension=ssh2.so
EOF

echo "Restarting PHP 7 fpm"
service php7.2-fpm restart &>/dev/null
