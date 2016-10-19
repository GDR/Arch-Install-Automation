#!/usr/bin/env bash

source ./global_functions.sh

# Set network

if ! check_internet_connection ; then
    echo "Need internet connection"
    exit 1;
fi

# Install aur

if ! grep -Fxq "[archlinuxfr]" /etc/pacman.conf ; then
  echo -e "[archlinuxfr]\nSigLevel = Never\nServer = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf
fi

install_with_pacman yaourt

# Add yaourt.rc

# Add .gitconfig

# Add GDR user and set password

# Install git

install_with_pacman git

# Install vim

install_with_pacman vim

# Install awesome wm

# Install google-chrome

# Install docker

# Install android-studio