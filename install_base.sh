#!/usr/bin/env bash

source ./global_functions.sh

# Set network

if ! check_internet_connection ; then
    echo "Need internet connection"
    exit 1;
fi

# Install aur

if ! grep -Fxq "[archlinuxfr]" ; then
    echo "[archlinuxfr]
    SigLevel = Never
    Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf
fi
pacman --noconfirm -Sy yaourt
# Add GDR user and set password

# Install git

# Install vim

# Install awesome wm

# Install google-chrome

# Install docker

# Install android-studio