#!/usr/bin/env bash
set -eu


 # ./alis-cloud-init-ssh.sh -b sid -i 192.168.122.61 -c alis-config-efi-ext4-luks-systemd.sh

# for connecting to qemu VM:
# ./alis-cloud-init-ssh.sh -t qemu -n arch-vm

# for connecting to qemu VM with config:
# ./alis-cloud-init-ssh.sh -t qemu -n arch-vm -c alis-config-efi-ext4-grub-gnome-qemu.sh


GITHUB_USER="dy-sh"
BRANCH="master"
BRANCH_QUALIFIER=""
IP_ADDRESS=""
VM_TYPE="qemu" # qemu | virtualbox
VM_NAME="arch-vm"
CONFIG_FILE_SH="alis-config-efi-ext4-systemd.sh"

while getopts "b:c:i:n:t:u:" arg; do
  case $arg in
    b)
      BRANCH="$OPTARG"
      ;;
    c)
      CONFIG_FILE_SH="$OPTARG"
      ;;
    i)
      IP_ADDRESS="$OPTARG"
      ;;
    n)
      VM_NAME="$OPTARG"
      ;;
    t)
      VM_TYPE="$OPTARG"
      ;;
    u)
      GITHUB_USER=${OPTARG}
      ;;
    *)
      echo "Unknown option: $arg"
      exit 1
      ;;
  esac
done

if [ "$BRANCH" == "sid" ]; then
  BRANCH_QUALIFIER="-sid"
fi

if [ "$IP_ADDRESS" == "" ] && [ "$VM_TYPE" == "virtualbox" ] && [ "$VM_NAME" != "" ]; then
  IP_ADDRESS=$(VBoxManage guestproperty get "${VM_NAME}" "/VirtualBox/GuestInfo/Net/0/V4/IP" | cut -f2 -d " ")
fi

if [ "$IP_ADDRESS" == "" ] && [ "$VM_TYPE" == "qemu" ] && [ "$VM_NAME" != "" ]; then
  MAC_ADDRESS=$(virsh --connect qemu:///session dumpxml arch-vm | grep "mac address" | awk -F\' '{ print $2}')
  IP_ADDRESS=$(arp -an | grep $MAC_ADDRESS | awk '{print $2}' | sed 's/[()]//g')
fi

echo "Connecting to SSH by IP:'$IP_ADDRESS' ..."

# set -x
ssh-keygen -R "$IP_ADDRESS"
ssh-keyscan -H "$IP_ADDRESS" >> ~/.ssh/known_hosts

ssh -t -i cloud-init/alis.key root@"$IP_ADDRESS" "bash -c \"curl -sL https://raw.githubusercontent.com/${GITHUB_USER}/alis/${BRANCH}/download${BRANCH_QUALIFIER}.sh | bash -s -- -b ${BRANCH}\""

if [ "$CONFIG_FILE_SH" == "" ]; then
  ssh -t -i cloud-init/alis.key root@"$IP_ADDRESS"
else
  ssh -t -i cloud-init/alis.key root@"$IP_ADDRESS" "bash -c \"configs/$CONFIG_FILE_SH\""
  ssh -t -i cloud-init/alis.key root@"$IP_ADDRESS" "bash -c \"./alis.sh -w\""
fi
