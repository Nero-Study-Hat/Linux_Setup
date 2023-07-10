#!/bin/bash

if ! [ "$(id -u)" = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

yay -S \
brave-bin \ # chromium based browser
code \ # text editor
cool-retro-term \ # terminal emulator
kwin-bismuth # window tiling


#  Maybe install.
yay -S \
direnv # for bash scripting