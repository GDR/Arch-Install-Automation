#!/usr/bin/env bash

source ./global_functions.sh

# Set network

if ! check_internet_connection ; then
    echo "Need internet connection"
    exit 1;
fi

# Install aur

if ! grep -Fxq "[archlinuxfr]" /etc/pacman.conf ; then
    echo "[archlinuxfr]
    SigLevel = Never
    Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf
fi
pacman --noconfirm -Sy yaourt

# Add GDR user and set password

# Install git

install_with_pacman git

# Install vim

install_with_pacman vim

# Install awesome wm

# Install google-chrome

# Install docker

# Install android-studio