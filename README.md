`alis` is an unofficial Arch Linux auto-installation script. Using this script, it is very easy to install the system in a virtual machine or on a physical disk.

This repository is a fork of https://github.com/picodotdev/alis

## How to install on a physical disk

First of all, download the [Arch Linux installer](https://archlinux.org/download/), create an installation flash drive and boot from it.

After booting from the USB flash drive, you will see a command prompt.

Download the script:

```bash
curl -sL https://raw.githubusercontent.com/dy-sh/alis/master/download.sh | bash

# or use short link:
curl -sL rb.gy/worly | bash 
# or:
curl -sL https://t.ly/gedVj | bash
```
Edit the config:

```bash
nano alis.conf

# or:
vim alis.conf
```

If you have only one disk and there are no partitions on it, then you can leave all settings by default. 
If there are several disks, then in the script you need to specify which disk to use.

```bash
DEVICE="/dev/nvme0n1"
PARTITION_MODE="manual"
PARTITION_MOUNT_POINTS=("2=/boot" "5=/" "!3=/home") 
```

Correctly write the partition number for `/boot` and `/` in the `PARTITION_MOUNT_POINTS`. 
The partition number can be determined using `lsblk` or `fdisk -l`.

Run the script:

```bash
./alis.sh 
```

## How to install in a QEMU virtual machine

Just run che command:

```bash
curl -sL https://raw.githubusercontent.com/dy-sh/alis/master/download-install-qemu.sh | bash
```
The command downloads the script and runs it. The script downloads the Arch Linux, creates a virtual machine and installs the system automatically. No action is required from the user.

To install QEMU on Arch Linux, you can run `install_qemu.sh`.

If you need to configure the parameters of the virtual machine and the Arch being installed, clone the repository:

```bash
git clone https://github.com/dy-sh/alis
```

Options for starting a virtual machine:

```bash
# Fully automatic installation
alis-kvm-virt-install-auto.sh

# Start the VM, manually configure the config, and then run the
installation./alis-kvm-virt-install-manual.sh
nano alias.conf
./alis.sh
```

In the last line of the script `alis-kvm-virt-install-auto.sh ` it is possible to change the installer profile.




