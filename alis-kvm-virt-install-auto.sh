#!/usr/bin/env bash

./alis-kvm-virt-install.sh

echo "Wait for starting VM..."

while true; do
    mac_addr=$(virsh dumpxml arch-vm | grep "mac address" | awk -F\' '{ print $2}') && \
    ip_address=$(arp -an | grep $mac_addr | awk '{print $2}' | sed 's/[()]//g') 
    if [[ -n "$ip_address" ]]; then  
	    break
    fi
    sleep 1
done


echo "VM started."
echo "MAC: ${mac_addr} IP: ${ip_address}"

echo "Waiting for server become available..."

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

./alis-cloud-init-ssh.sh -i $ip_address -c alis-config-efi-ext4-grub-gnome-qemu.sh


