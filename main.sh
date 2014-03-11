#! /bin/bash

# installtion
LIST_OF_APPS="msmtp-mta heirloom-mailx curl openssh-server"
apt-get install -y $LIST_OF_APPS

# Set up configuration, and place files.
cat ./data/msmtprc.txt > ~/.msmtprc 
cat ./data/mailrc.txt > ~/.mailrc
cat ./data/sendip > /etc/network/if-up.d/sendip 
chmod 755 /etc/network/if-up.d/sendip 

# Add a Linux user, test
if [ $(id -u) -eq 0 ]; then
username="test"
password="password"
egrep "^$username" /etc/passwd >/dev/null
pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
useradd -m -p $pass $username
sudo adduser test sudo
fi

# Exit
exit 0
