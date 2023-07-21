#!/usr/bin/env bash
set -eu

# https://wiki.archlinux.org/title/Libvirt#Server
# https://wiki.archlinux.org/title/QEMU#Bridged_networking_using_qemu-bridge-helper
# sudo pacman -S virt-install dnsmasq dmidecode
# sudo usermod -a -G libvirtd picodotdev
# sudo systemctl start libvirtd.service
# mkdir -p /etc/qemu
# vim /etc/qemu/bridge.conf
# allow virbr0

# 3D Acceleration
# Host and guest shared clipboard
# Host and guest file sharing

# DISK_DIRECTORY="/media/user/E-DATA-B/VM"
ISO_DIRECTORY="$HOME/Downloads"

virt-install \
    --connect=qemu:///session \
    --name arch-vm \
    --os-variant archlinux \
    --vcpus 2 \
    --ram 4096 \
    --disk size="$VM_DISK_SIZE",pool=default,bus=virtio,format=qcow2,sparse=yes \
    --cdrom "$ISO_DIRECTORY/archlinux.iso" \
    --disk cloud-init/alis-cloud-init.iso,device=cdrom,bus=sata \
    --network bridge=virbr0 \
    --noautoconsole
    # --disk path="$DISK_DIRECTORY/archlinux-alis.qcow2,format=qcow2,size=20,sparse=yes" \
    # --boot uefi \
