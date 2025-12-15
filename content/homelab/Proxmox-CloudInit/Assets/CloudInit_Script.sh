CI_IMAGE_NAME="noble-server-cloudimg-amd64.img"
CI_IMAGE_LOCATION="/var/lib/vz/template/iso/"
if [ -f ${CI_IMAGE_LOCATION}${CI_IMAGE_NAME} ]; then
    echo "Cloud image already downloaded."
else
    echo "Downloading cloud image..."
    cd ${CI_IMAGE_LOCATION}
    wget https://cloud-images.ubuntu.com/noble/current/${CI_IMAGE_NAME}
    cd -
    echo "Download of cloud image complete."
fi

TEMPLATE_NUM=8000
VM_NAME="dock02"
VM_NUM=200
VM_IP="55"
VM_MEMORY="4096"
VM_CORES="3"
VM_STORE="local-lvm"
# Change the commented-out lines per your choice
VM_FULL_CLONE="true"
# VM_FULL_CLONE="false"
# NB: Use of this flag is NOT YET IMPLEMENTED
# VM_FULL_CLONE="false" will create a linked clone, which is not recommended for production use.
# ANote that specifying the storage is not allowed for a linked clone
cd /var/lib/vz/template/iso
qm create ${TEMPLATE_NUM} --memory ${VM_MEMORY} --core ${VM_CORES} --name ubuntu-cloud --net0 virtio,bridge=vmbr0
qm disk import ${TEMPLATE_NUM} noble-server-cloudimg-amd64.img ${VM_STORE}
cd -
qm set ${TEMPLATE_NUM} --scsihw virtio-scsi-pci --scsi0 ${VM_STORE}:vm-${TEMPLATE_NUM}-disk-0
qm set ${TEMPLATE_NUM} --boot order=scsi0
qm resize ${TEMPLATE_NUM} scsi0 +100G
qm set ${TEMPLATE_NUM} --agent enabled=1

qm set ${TEMPLATE_NUM} --ide2 ${VM_STORE}:cloudinit

qm set ${TEMPLATE_NUM} --serial0 socket --vga serial0
qm template ${TEMPLATE_NUM}

# Create a file with all the public ssh keys
cat > ~/.ssh/all.pub <<EOF
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKL1EWv5ZwWTti7qoZbA+OZDGE5U+JhUU1Mxb+M0ZxkL ansibleuser@ansible4
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAP9eyxA4P8mE51qmbnigiuEmX72dRFRuN4SLmp0ISuA david@Ryzen2
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDfi8tdojFUWJJBvVSsvm6sp0bPiYCT9zeE7vXxeVXejw8IK29/qbUtKNx/DTbQUcLtoO42coAdNqc+oTt04ueO3o6GnYI/ZM+2NYCsGnFLtbVYOcaSextqXyLp/sr4o2nyV9vjF24F33TrnITxz1Jh+HqLwvh0ryII6XIv/pxo4XbFuQeeGUwuogCTmK+h4fDyXqE3AEd51bhjfv5gooB67XP6y/UxZxGiBoFX41Rb5pRf263ed1dUoW3KQkQWqcw2LI7SwzHO3+mbIgD4ZzsqrMGnxsoFLcox54gL++yYshMQDsughSssyBkcV0I1Txo9U3xsV81Ez91uxd1Qz67+bBk9IeAcaqIjPSR+Hc4a07mTiJ/w2NPTIHRzDIL5vCNvVJVYT62xdUBIxzQv4QeStLApLb7YmaLOXDEnFYNXmqw1Kmwph2e+9ufe6rpuXF5ybbGHhi44kzOM9M51W5Y+1bT4nb66AXJtk2Um1Xu1QKowBjcDarBVdjglKc79w75jAZ831/ApWfzMssQisV1Im+D0AAjVs695rDHbU9imJBu7p22G8Vw2ml9HmOQt//e+BfVobLR51uRdp2s3/2QbrZ4NbEG9l/qpPF9J1To2LrDkYjf+QYCG04G3FzsO9Z93WaxCqnuIR1sUfggpnoCsiswQl5zE01OTmMQlsjVmhw== root@pve
EOF

qm set ${TEMPLATE_NUM} --ipconfig0 ip=192.168.178.${VM_IP}/24,gw=192.168.178.1
qm set ${TEMPLATE_NUM} --cpu cputype=host 
qm set ${TEMPLATE_NUM} --ciuser "david"
# See https://docs.openssl.org/1.0.2/man1/passwd/ for how to generate a password hash
# Example... qm set ${TEMPLATE_NUM} --cipassword $(openssl passwd $CLOUD_INIT_USER_PASSWORD)
# or set a non-encrypted string.
# Note that it is not recommended to set the cloudinit password - users should log in via ssh leveraging keys
qm set ${TEMPLATE_NUM} --cipassword "chestnut1999"

qm set ${TEMPLATE_NUM} --sshkeys ~/.ssh/all.pub
qm set ${TEMPLATE_NUM} --nameserver="192.168.178.5 8.8.8.8"
qm set ${TEMPLATE_NUM} --searchdomain="lab.davidmjudge.me.uk"

qm cloudinit update ${TEMPLATE_NUM}

# To control where the full clone will place its disk, add '--storage data4tb' to the command below.
qm clone ${TEMPLATE_NUM} ${VM_NUM} --name ${VM_NAME} --full true 

qm start ${VM_NUM}
