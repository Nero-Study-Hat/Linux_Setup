#!/bin/bash
# Application Installs
#
# General Utility
# Brave Browser
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser
#
# IT Editors
sudo dnf install cool-retro-term
sudo dnf install gedit
# IT System
sudo dnf install timeshift
sudo dnf install gparted
# Visual Studio Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code
# Github Desktop
sudo rpm --import https://mirror.mwt.me/ghd/gpgkey
sudo sh -c 'echo -e "[shiftkey]\nname=GitHub Desktop\nbaseurl=https://mirror.mwt.me/ghd/rpm\nenabled=1\ngpgcheck=0\nrepo_gpgcheck=1\ngpgkey=https://mirror.mwt.me/ghd/gpgkey" > /etc/yum.repos.d/shiftkey-desktop.repo'
sudo dnf install github-desktop
# Appearance
sudo dnf install lightly
sudo dnf install bismuth
#
# Virtual Box
sudo dnf -y install @development-tools
sudo dnf -y install kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras
sudo dnf search virtualbox
sudo dnf install VirtualBox
# Fun
sudo dnf install steam
# Screenshot
sudo dnf install flameshot
# Extra
sudo dnf install htop
sudo dnf install neofetch
sudo dnf install cmatrix
echo Done
