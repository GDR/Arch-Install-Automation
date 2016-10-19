#!/usr/bin/env bash

MOUNTPOINT="/mnt"

run_quiet() {
    $@ > /dev/null 2>&1
}

check_internet_connection() {
    if run_quiet "ping -q -c 1 -W 1 8.8.8.8" ; then
      return 0
    else
      return 1
    fi
}

install_with_pacman() {
    pacman -Sy --noconfirm $1
}

arch_chroot() {
    arch-chroot ${MOUNTPOINT} $@
}