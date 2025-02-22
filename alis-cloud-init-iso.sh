#!/usr/bin/env bash
set -eu
# set -x

if [ ! -f cloud-init/alis.key ]; then
    openssl genrsa -out cloud-init/alis.key 8192
fi
SSH_RSA=$(ssh-keygen -y -f cloud-init/alis.key)
mkdir -p cloud-init/iso/
cp cloud-init/meta-data cloud-init/user-data cloud-init/iso/
sed -i "s#\\\${SSH_RSA}#${SSH_RSA}#" cloud-init/iso/user-data

sudo pacman -S --needed --noconfirm cdrkit # mkisofs
mkisofs -o cloud-init/alis-cloud-init.iso -V CIDATA -iso-level 3 -J -R cloud-init/iso/