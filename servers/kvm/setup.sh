#!/bin/bash
cd "$(dirname $0)"
KEYPUB="$(cat $HOME/.ssh/id_ecdsa.pub)"
# the passwd is the first 16 chars of the sha256sum of the private key
# encoded with md5sum to put in the configuration file
PASSWD="$(cat /home/msciab/.ssh/id_ecdsa | sha256sum | head -c 16 | md5sum | head -c 32)"
mkdir -p /var/kvm/mosaico 
virsh net-create network.xml
for i in 0 1 2 3 
do 
    if test "$i" = "0"
    then HOST="master"
    else HOST="node$i"
    fi
    bash preseed.sh $i $HOST "$PASSWD" "$KEYPUB"
done
