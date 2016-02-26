#!/usr/bin/env bash

set -ex
sudo sync
sleep 5 # In some case, crontab was not updated...

sudo yum clean all

sudo rm -rf /tmp/*
sudo rm -rf /vagrant
sudo rm -rf /var/chef
sudo rm -f /etc/ssh/ssh_host_*
cd /var/log
sudo find /var/log/ -type f -name '*.log' -exec sudo cp /dev/null {} \;
sudo cp /dev/null /var/log/syslog

# erase authorized_keys, command history...
sudo rm -f /etc/ssh/ssh_host_*
sudo cp /dev/null /root/.ssh/authorized_keys
sudo cp /dev/null /root/.bash_history
sudo cp /dev/null /root/.mysql_history
if [ -d /home/ec2-user ]; then
  cp /dev/null /home/ec2-user/.ssh/authorized_keys
  cp /dev/null /home/ec2-user/.bash_history
  if [ -f /home/ec2-user/.mysql_history ]; then
    sudo chown ec2-user.ec2-user /home/ec2-user/.mysql_history
    cp /dev/null /home/ec2-user/.mysql_history
  fi
fi

sudo rm -rf /home/ec2-user/.composer
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/php/session/*
sudo rm -rf /var/www/vhosts/*
sudo rm -rf /var/cache/nginx/proxy_cache/*
sudo rm -rf /var/cache/nginx/proxy_temp/*
sudo rm -rf /vagrant
sudo rm -rf /var/chef
sudo rm -f  /etc/ssh/ssh_host_*

history -c

