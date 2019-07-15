# Install Arch

## Initial setup

* Boot from Arch Live USB

## Setup Network

```bash
# Bring the wifi adapter up
ip link set wlp2s0 up

# Connect to the wifi and authorize in Unifi
iw dev wlp2s0 connect Purgatory
iw dev wlp2s0 link

# Get an IP
ifconfig
dhcpcd
ping google.com
```

## Prepare Date

```bash
# Get the date correct
timedatectl set-ntp true
timedatectl status
```

## Prepare Disk

```bash
# fdisk if needed

# EFI partition needs to be FAT
mkfs.fat -F32 /dev/nvme0n1p1

# Enable swap
mkswap /dev/nvme0n1p2
swapon /dev/nvme0n1p2

# Our main drive
mkfs.ext4 /dev/nvme0n1p3

# Mount all the things
mount /dev/nvme0n1p3 /mnt
mkdir /mnt/efi
mount /dev/nvme0n1p1 /mnt/efi
```

## Install Arch Base

```bash
# Configure mirrors closest to you
nano /etc/pacman.d/mirrorlist

# Install Arch Linux
pacstrap /mnt base

# Save the disk layout
# It might be smart to remember the UUID of your disk here
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot into the system
arch-chroot /mnt
```

## Setup Date and Locale

```bash
# Pick Brussels as our timezone
ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime
hwclock --systohc

# Get an US map configured
nano /etc/locale.gen
# Uncomment en_US.UTF-8 UTF-8

locale-gen

nano /etc/locale.conf
> LANG=en_US.UTF-8
```

## Setup Host

```bash
# Name our machine
nano /etc/hostname
> blue

# Configure localhost
nano /etc/hosts
> 127.0.0.1 localhost
> ::1 localhost
```

## Setup Wifi Tools

```bash
pacman -S iw networkmanager
systemctl enable NetworkManager.service
```

## Change Console Font

```bash
pacman -S terminus-font

# Set the font for the current console
setfont ter-m22n

# Set the font for future boots
nano /etc/vconsole.conf
> FONT=ter-m22n
```

## Prepare EFI

```bash
# Generate boot images
mkinitpcio -p linux

# Install Intel Microcode
pacman -S intel-ucode iucode-tool

# Copy everything to our EFI partition
cp /boot/* /efi/

# Install systemd-boot
bootctl --path=/efi install

# Configure our boot loader to use 'arch'
nano /efi/loader/loader.conf
> default         arch
> timeout         3
> console-mode    max
> editor          no

# Configure our kernel
nano /efi/loader/entries/arch.conf
> title   Arch Linux
> linux   /vmlinuz-linux
> initrd  /intel-ucode.img
> initrd  /initramfs-linux.img
> options root=UUID=xxxxxx rw
```

## Setup User

```bash
# Enable 'sudo' for the wheel group
pacman -S sudo
nano /etc/sudoers
# Uncomment wheel group

# Add our daily user
useradd -m -G wheel -s /bin/bash cumpsd
passwd cumpsd
```

## Cleanup and Reboot

```bash
# Set a password
passwd

# Get out of chroot
exit

# Make sure all write operations are done
umount -R /mnt

# Cross fingers
reboot

# Pull out Live USB stick
```

## Get running after reboot, login with normal user

```bash
# Bring the wifi adapter up
sudo ip link set wlp2s0 up

# Connect to the wifi and authorize in Unifi
sudo iw dev wlp2s0 connect Purgatory
sudo iw dev wlp2s0 link

# Get an IP
sudo dhcpcd
ping google.com
```

## Prepare Surface Kernel

```bash
# Install development tools
sudo pacman -S base-devel git

# Clone the Surface patches and prepare for compilation
git clone https://github.com/dmhacker/arch-linux-surface
cd arch-linux-surface
sudo sh setup.sh
sudo sh configure.sh

# Compile the Surface specific kernel
sudo chown -R cumpsd:cumpsd build-[VERSION]
cd build-[VERSION]
MAKEFLAGS="-j8" makepkg -sc
# This takes quite a bit

# Install the new kernel
sudo pacman -U linux-surface-[VERSION]-1-x86_64.pkg.tar.xz
sudo pacman -U linux-surface-headers-[VERSION]-1-x86_64.pkg.tar.xz
sudo pacman -U linux-surface-docs-[VERSION]-1-x86_64.pkg.tar.xz

# Update the EFI partition
sudo mkinitcpio -p linux-surface
sudo cp /boot/* /efi/
```

## Update Bootloader and Reboot

```bash
sudo nano /efi/loader/entries/arch.conf
> title   Arch Linux (5.1.15-1-surface)
> linux   /vmlinuz-linux-surface
> initrd  /intel-ucode.img
> initrd  /initramfs-linux-surface.img
> options root=UUID=xxxxxx rw

sudo reboot
```

## Check Microcode

```bash
dmesg | grep microcode
bsdtar -Oxf /efi/intel-ucode.img | iucode_tool -tb -lS -
grep microcode /proc/cpuinfo
```
