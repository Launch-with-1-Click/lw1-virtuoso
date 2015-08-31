#!/bin/bash

VT_VERSION='7.2.1'
DEFAULT_USER='ec2-user'
DEFAULT_GROUP='ec2-user'
VT_USER='virtuoso'
VT_GROUP='virtuoso'

sudo yum update -y
sudo yum install git -y


## Install build dependencies
## See https://github.com/openlink/virtuoso-opensource
sudo yum install -y autoconf automake libtool flex bison gperf gawk m4 make openssl-devel
sudo yum install -y unixODBC-devel ruby-devel

## Prepare dirs
sudo install -o ${DEFAULT_USER} -g ${DEFAULT_GROUP} -d /opt/src
sudo install -o ${DEFAULT_USER} -g ${DEFAULT_GROUP} -d /opt/virtuoso-opensource


## Checkout latest stable to /opt
sudo -u ${DEFAULT_USER} git clone --depth 1 git://github.com/openlink/virtuoso-opensource.git -b v${VT_VERSION} /opt/src/virtuoso-opensource_${VT_VERSION}


## Build virtuoso-opensource

cd /opt/src/virtuoso-opensource_${VT_VERSION}
sudo -u ${DEFAULT_USER} ./autogen.sh
sudo -u ${DEFAULT_USER} CFLAGS="-O2 -m64" ./configure --with-layout --prefix=/opt/virtuoso-opensource --enable-ruby --enable-bpel-vad --enable-dbpedia-vad --enable-isparql-vad --enable-rdfmappers-vad --enable-rdb2rdf-vad
sudo -u ${DEFAULT_USER} make -j `grep processor /proc/cpuinfo | wc -l`
sudo make install
sudo chown -R ${VT_USER}.${VT_GROUP} /opt/virtuoso-opensource
