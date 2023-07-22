#!/usr/bin/env bash
set -eu

sed -i "s/^DEVICE=.*/DEVICE=\"\/dev\/vda\"/" ./alis.conf

sed -i "s/^PARTITION_MODE=.*/PARTITION_MODE=\"manual\"/" ./alis.conf

# sed -i "s/^FILE_SYSTEM_TYPE=.*/FILE_SYSTEM_TYPE=\"btrfs\"/" ./alis.conf
# sed -i "s/^BOOTLOADER=.*/BOOTLOADER=\"grub\"/" ./alis.conf
# sed -i "s/^DESKTOP_ENVIRONMENT=.*/DESKTOP_ENVIRONMENT=\"gnome\"/" ./alis.conf

# sed -i "s/^PACKAGES_AUR_INSTALL=.*/PACKAGES_AUR_INSTALL=\"true\"/" ./alis-packages.conf
# sed -i "s/^PACKAGES_AUR_COMMAND=.*/PACKAGES_AUR_COMMAND=\"paru-bin\"/" ./alis-packages.conf

# sed -i "s/^PACKAGES_INSTALL=.*/PACKAGES_INSTALL=\"true\"/" ./alis.conf
# sed -i "s/^PACKAGES_PIPEWIRE=.*/PACKAGES_PIPEWIRE=\"true\"/" ./alis.conf
# sed -i "s/^PACKAGES_FLATPAK_INSTALL=.*/PACKAGES_FLATPAK_INSTALL=\"true\"/" ./alis-packages.conf

# sed -i "s/^PACKAGES_PACMAN_CUSTOM=.*/PACKAGES_PACMAN_CUSTOM=\"spice-vdagent qemu-guest-agent\"/" ./alis-packages.conf