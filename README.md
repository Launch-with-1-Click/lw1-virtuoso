# Virtuoso Open-Source

for Amazon Linux AMI 2014.03.1.

## Setup

```
source env.sh # Copy and fill env.sh.sample
```

## Build

### Vagrant

```
bundle
librarian-chef install
vagrant up --provide=aws
```

and reboot instance.


### Packer

`packer build ./packer_ec2.json`

## Login to conductor

Visit http://#{ec2-public-hostname}:8890

Login with `User: dba` `Password: #{your instance_id}`

## Manage Service

The virtuoso process is managed under init.d.

`service virtuoso (start|stop|restart|status)`

