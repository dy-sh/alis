# installing qemu
sudo pacman -S --needed --noconfirm qemu-full virt-manager virt-viewer dnsmasq
sudo systemctl enable --now libvirtd.service

# start virtual network (bgidge virbr0)
sudo virsh net-start default
sudo virsh net-autostart default


# # recreating pool on specified folder
# # for qemu:///system
# sudo virsh pool-destroy default
# sudo virsh pool-undefine default
# sudo virsh pool-define-as --name default --type dir --target "/media/user/E-DATA-B/VM"
# sudo virsh pool-start default
# sudo virsh pool-autostart default
# # for qemu:///session
# virsh --connect=qemu:///session pool-destroy default
# virsh --connect=qemu:///session pool-undefine default
# virsh --connect=qemu:///session pool-define-as --name default --type dir --target "/media/user/E-DATA-B/VM"
# virsh --connect=qemu:///session pool-start default
# virsh --connect=qemu:///session pool-autostart default