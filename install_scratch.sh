#!/usr/bin/env bash

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

mount /dev/sda3 /mnt
mkdir -p /mnt/boot/efi
mkdir -p /mnt/home
mount /dev/sda1 /mnt/boot/efi
mount /dev/sda4 /mnt/home
swapon /dev/sda2

mkdir -p /mnt/var/cache/pacman
mount /dev/sdb1 /mnt/var/cache/pacman

# Install base system

pacstrap /mnt base base-devel

# Generate filesystem table

genfstab -U /mnt >> /mnt/etc/fstab

# Set timezone
ln -s /mnt/usr/share/zoneinfo/Europe/Moscow /mnt/etc/localtime
arch-chroot /mnt hwclock --systohc

# Set hostname
echo "Arch-Germany" > /mnt/etc/hostname

# Set locale
echo "en_US.UTF-8 UTF-8" > /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf

arch-chroot /mnt mkinitcpio -p linux

# Install grub

arch-chroot /mnt pacman -Sy grub efibootmgr --noconfirm
arch-chroot /mnt grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
arch-chroot /mnt grub-mkconfig -o /boot/grub/grub.cfg