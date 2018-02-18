#!/bin/bash

cd "$(dirname $0)"

NODE=${1:?node number}
HOST=${2:?host name}
MEMORY=${3?memory}
DISK=${4?disk size in giga}

DIR=/var/kvm/mosaico
OSNAME=ubuntu16.04
OSPATH=http://archive.ubuntu.com/ubuntu/dists/xenial/main/installer-amd64/
PORT=$(expr 5920 + $NODE)
IP=$(expr 10 + $NODE)
IMAGE="$DIR/$HOST/image.qcow2"

test -e "$IMAGE" || qemu-img create -f qcow2 "$IMAGE" ${DISK}G

echo virt-install \
--name $HOST \
--ram "$(expr $MEMORY \* 1024)" \
--disk path=$IMAGE \
--vcpus 1 \
--os-type linux \
--os-variant $OSNAME \
--network bridge=virbr2,mac=52:54:00:10:00:$IP \
--graphics none \
--console pty,target_type=serial \
--location "$OSPATH" \
--extra-args 'console=ttyS0' \
--initrd-inject "$DIR/$HOST/preseed.cfg" \
--noreboot

#--graphics vnc,port=$PORT,listen=0.0.0.0 \
#ISO=ubuntu-16.04.3-server-amd64.iso

