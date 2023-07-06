#!/bin/bash

# Set up drivers.


# Set up partion sym links.


# Install apps.
yes | yay -S \
nvidia-inst \
brave-bin \
cool-retro-term

# Manage dotfiles.
cd || exit
mkdir .dotfiles/cool-retro-term

