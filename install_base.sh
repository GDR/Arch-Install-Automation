#!/usr/bin/env bash

echo "[archlinuxfr]
SigLevel = Never
Server = http://repo.archlinux.fr/\$arch"
pacman --noconfirm -Sy yaourt