#!/bin/bash

# First have to wipe data on several partitions:
# /dev/sda1 -- uEFI partition
# /dev/sda2 -- Swap partition
# /dev/sda3 -- Root partition
# /dev/sda4 -- Home partition

mkfs.vfat -F32  -n BOOT /dev/sda1
mkswap          -L SWAP /dev/sda2
mkfs.ext4       -L ROOT /dev/sda3
mkfs.ext4       -L HOME /dev/sda4

# After we have to mount partitions

mount /dev/sda3 /mnt
mkdir -p /mnt/boot/efi
mkdir -p /mnt/home
mount /dev/sda1 /mnt/boot/efi
mount /dev/sda4 /mnt/home
swapon /dev/sda2

# Install base system

pacstrap /mnt base base-devel

# Generate filesystem table

genfstab -U /mnt >> /mnt/etc/fstab

# Change root into the new system

# Set timezone
ln -s /mnt/usr/share/zoneinfo/Europe/Moscow /mnt/etc/localtime
arch-chroot /mnt hwclock --systohc

# Set hostname
echo 'Arch-Germany' > /mnt/etc/hostname

