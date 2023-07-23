#!/usr/bin/env bash
set -eu

sed -i "s/LOG=.*/LOG=\"false\"/" ./alis.conf
sed -i "s#DEVICE=.*#DEVICE=\"auto\"#" ./alis.conf
sed -i "s/FILE_SYSTEM_TYPE=.*/FILE_SYSTEM_TYPE=\"ext4\"/" ./alis.conf
sed -i "s/LVM=.*/LVM=\"false\"/" ./alis.conf
sed -i "s/LUKS_PASSWORD=.*/LUKS_PASSWORD=\"\"/" ./alis.conf
sed -i "s/LUKS_PASSWORD_RETYPE=.*/LUKS_PASSWORD_RETYPE=\"\"/" ./alis.conf
sed -i "s/ROOT_PASSWORD=.*/ROOT_PASSWORD=\"111\"/" ./alis.conf
sed -i "s/ROOT_PASSWORD_RETYPE=.*/ROOT_PASSWORD_RETYPE=\"111\"/" ./alis.conf
sed -i "s/USER_PASSWORD=.*/USER_PASSWORD=\"111\"/" ./alis.conf
sed -i "s/USER_PASSWORD_RETYPE=.*/USER_PASSWORD_RETYPE=\"111\"/" ./alis.conf
sed -i "s/BOOTLOADER=.*/BOOTLOADER=\"grub\"/" ./alis.conf
sed -i "s/DESKTOP_ENVIRONMENT=.*/DESKTOP_ENVIRONMENT=\"i3-wm\"/" ./alis.conf

sed -i "s/PACKAGES_INSTALL=.*/PACKAGES_INSTALL=\"true\"/" ./alis.conf
sed -i "s/PACKAGES_PIPEWIRE=.*/PACKAGES_PIPEWIRE=\"true\"/" ./alis.conf
sed -i "s/PACKAGES_FLATPAK_INSTALL=.*/PACKAGES_FLATPAK_INSTALL=\"true\"/" ./alis-packages.conf

sed -i "s/PACKAGES_PACMAN_CUSTOM=.*/PACKAGES_PACMAN_CUSTOM=\"spice-vdagent qemu-guest-agent\"/" ./alis-packages.conf


