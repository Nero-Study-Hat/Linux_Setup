#!/bin/bash

# Dependencies
yay -S \
konsave \
lightly-qt \
kvantum-qt5-git \
latte-dock-git

mkdir -p ~/.local/share/kwin/effects
tar -xf burn_my_windows_kwin4.tar.gz -C ~/.local/share/kwin/effects
rm burn_my_windows_kwin4.tar.gz