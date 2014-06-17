#!/bin/bash

if [ `which chef-solo` ] ;then exit 0;fi

## Prepare Chef

sudo mkdir -p /etc/chef/ohai/hints/
sudo touch /etc/chef/ohai/hints/ec2.json
echo '{}' > ./ec2.json
sudo mv ./ec2.json /etc/chef/ohai/hints/ec2.json
sudo mkdir -p /opt/lw1

curl -L https://www.getchef.com/chef/install.sh | sudo bash
