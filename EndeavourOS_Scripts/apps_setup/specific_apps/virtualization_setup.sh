#!/bin/bash

# Force user to run this script with root permissions using sudo from non root user.
if ! [ "$(id -u)" = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

if [ "$SUDO_USER" ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
    if [ "$real_user" == "root" ]; then
        echo "This script should be run with sudo from non root user."
        exit 1
    fi
fi

if sudo -u "$real_user" ls -la "/etc/sudoers.d/" > /dev/null 2>&1; then
    echo "This script should be run with sudo from a user that does not have root privleges."
    exit 1
fi

# --- #

pacman -Syy
yes | pacman -S archlinux-keyring
yes | pacman -S qemu virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat dmidecode
yes | pacman -S ebtables iptables

pacman -S libguestfs

systemctl enable libvirtd.service
systemctl start libvirtd.service

conf_file="/etc/libvirt/libvirtd.conf"

search_string_1="#unix_sock_group = \"libvirt"\"
replacement_string_1="unix_sock_group = \"libvirt"\"

search_string_2="#unix_sock_rw_perms = \"0770"\"
replacement_string_2="unix_sock_rw_perms = \"0770"\"

sed -i "s/$search_string_1/$replacement_string_1/" "$conf_file"
sed -i "s/$search_string_2/$replacement_string_2/" "$conf_file"

usermod -a -G libvirt "$real_user"
sudo -u "$real_user" newgrp libvirt

systemctl restart libvirtd.service

# AMD Processor #
sudo modprobe -r kvm_amd
sudo modprobe kvm_amd nested=1

echo "options kvm-intel nested=1" | sudo tee /etc/modprobe.d/kvm-intel.conf

