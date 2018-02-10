#!/bin/bash

cd "$(dirname $0)"

NODE=${1:?node number}
MEMORY=${2?memory}
DISK=${3?disk size in giga}

OSNAME=ubuntu16.04
OSPATH=http://archive.ubuntu.com/ubuntu/dists/xenial/main/installer-amd64/
ISO=ubuntu-16.04.3-server-amd64.iso
PORT=$(expr 5920 + $NODE)
IP=$(expr 10 + $NODE)

if test "$NODE" = "0"
then NAME="master"
else NAME="node$NODE"
fi

test -e "$PWD/$NAME.img" || qemu-img create -f qcow2 "$PWD/$NAME.img" ${DISK}G

virt-install \
--name $NAME \
--ram "$(expr $MEMORY \* 1024)" \
--disk path=$PWD/$NAME.img \
--vcpus 1 \
--os-type linux \
--os-variant $OSNAME \
--network bridge=virbr2,mac=52:54:00:10:00:$IP \
--graphics none \
--console pty,target_type=serial \
--location "$OSPATH" \
--extra-args 'console=ttyS0' \
--initrd-inject "$PWD/preseed.cfg" \
--noreboot

#--graphics vnc,port=$PORT,listen=0.0.0.0 \
