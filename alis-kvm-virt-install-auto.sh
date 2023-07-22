#!/usr/bin/env bash
set -eu
# set -x

iso_url="https://mirror.datacenter.by/pub/archlinux/iso/latest/archlinux-x86_64.iso"

VM_NAME="arch-vm"
VM_RAM="4096" 
VM_DISK_SIZE="40" 
VM_CPUS="4" 
# VM_DISK_DIRECTORY="/media/user/E-DATA-B/VM"
ISO_DIRECTORY="$HOME/Downloads"


# cd to script directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR" || exit


# Downloading Arch Linux
if [[ ! -f "$ISO_DIRECTORY/archlinux.iso" ]]; then
    echo "Downloading Arch Linux..."
    wget -N "$iso_url" -O "$ISO_DIRECTORY/archlinux.iso"
fi

# Creating SSH keys
if [[ ! -f cloud-init/alis-cloud-init.iso ]]; then
    echo "Creating SSH keys..."
    ./alis-cloud-init-iso.sh
fi


# Creating QEMU VM
echo "Creating VM..."

if [[ ! -d ~/shared ]]; then mkdir ~/shared; fi


virt-install \
    --connect=qemu:///session \
    --name "$VM_NAME" \
    --os-variant archlinux \
    --vcpus "$VM_CPUS" \
    --virt-type=kvm \
    --ram "$VM_RAM" \
    --disk size="$VM_DISK_SIZE",pool=default,bus=virtio,format=qcow2,sparse=yes \
    --cdrom "$ISO_DIRECTORY/archlinux.iso" \
    --disk cloud-init/alis-cloud-init.iso,device=cdrom,bus=sata \
    --network bridge=virbr0 \
    --graphics spice,listen=127.0.0.1 \
    --sound ich9 \
    --filesystem source=~/shared,target=shared,accessmode=mapped \
    --boot uefi \
    --noautoconsole
    # --disk path="$VM_DISK_DIRECTORY/$VM_NAME.qcow2,format=qcow2,size="$VM_DISK_SIZE",bus=virtio,sparse=yes" \


echo "Wait for starting VM..."

while true; do
    mac_addr=$(virsh --connect qemu:///session dumpxml $VM_NAME | grep "mac address" | awk -F\' '{ print $2}') && \
    ip_address=$(arp -an | grep $mac_addr | awk '{print $2}' | sed 's/[()]//g') 
    if [[ -n "$ip_address" ]]; then  
	    break
    fi
    sleep 1
done


echo "VM started."
echo "MAC: ${mac_addr} IP: ${ip_address}"

echo "Waiting for server become available..."

touch /home/user/.ssh/known_hosts

# ssh-keygen -R "$ip_address" &> /dev/null
while true; do
    if ssh-keyscan -H "$ip_address" &> /dev/null; then
        echo "Server available"
        break
    fi
    sleep 1
done

# sleep 10

echo "Connecting..."

./alis-cloud-init-ssh.sh -i $ip_address -c ""
# ./alis-cloud-init-ssh.sh -i $ip_address -c alis-config-efi-ext4-grub-gnome-qemu.sh


