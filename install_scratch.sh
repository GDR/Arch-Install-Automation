#!/usr/bin/env bash

source ./global_functions.sh

# Constants

# First have to wipe data on several partitions:
# /dev/sda1 -- uEFI partition
# /dev/sda2 -- Swap partition
# /dev/sda3 -- Root partition
# /dev/sda4 -- Home partition

mkfs.vfat -F32  -n BOOT /dev/sda1
mkswap          -L SWAP /dev/sda2
mkfs.ext4 -F    -L ROOT /dev/sda3
mkfs.ext4 -F    -L HOME /dev/sda4

# After we have to mount partitions

mount /dev/sda3 ${MOUNTPOINT}
mkdir -p ${MOUNTPOINT}/boot/efi
mkdir -p ${MOUNTPOINT}/home
mount /dev/sda1 ${MOUNTPOINT}/boot/efi
mount /dev/sda4 ${MOUNTPOINT}/home
swapon /dev/sda2

mkdir -p ${MOUNTPOINT}/var/cache/pacman
mount /dev/sdb1 ${MOUNTPOINT}/var/cache/pacman

# Install base system

pacstrap ${MOUNTPOINT} base base-devel

# Generate filesystem table

genfstab -U ${MOUNTPOINT} >> /mnt/etc/fstab

# Set timezone
ln -s ${MOUNTPOINT}/usr/share/zoneinfo/Europe/Moscow /mnt/etc/localtime
arch_chroot "hwclock --systohc"

# Set hostname
echo "Arch-Germany" > ${MOUNTPOINT}/etc/hostname

# Set locale
echo "en_US.UTF-8 UTF-8" > ${MOUNTPOINT}/etc/locale.gen
arch_chroot "locale-gen"
echo "LANG=en_US.UTF-8" > ${MOUNTPOINT}/etc/locale.conf

arch_chroot "mkinitcpio -p linux"

# Install grub

arch_chroot "pacman -Sy grub efibootmgr --noconfirm"
arch_chroot "grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub"
arch_chroot "grub-mkconfig -o /boot/grub/grub.cfg"

# Copy this to new OS
cp -r $(pwd) ${MOUNTPOINT}/root

reboot