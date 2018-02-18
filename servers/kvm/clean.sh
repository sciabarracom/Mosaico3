HOST=${1:?hostname}
virsh destroy $HOST
virsh undefine $HOST
rm /var/kvm/mosaico/$HOST/image.qcow2
