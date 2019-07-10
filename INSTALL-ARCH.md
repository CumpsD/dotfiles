# Install Arch

## Initial setup

* Boot from Arch Live USB

## Setup Network

```bash
ip link set wlp2s0 up
iw dev wlp2s0 connect Purgatory
# Authorize in Unifi
iw dev wlp2s0 link
ifconfig
dhclient
```

## Prepare Date

```bash
timedatectl set-ntp true
timedatectl status
```

## Prepare Disk

```bash
#fdisk if needed

mkfs.ext4 /dev/nvme0n1p3
mkswap /dev/nvme0n1p2
swapon /dev/nvme0n1p2
mkfs.fat -F32 /dev/nvme0n1p1

mount /dev/nvme0n1p3 /mnt
mkdir /mnt/efi
mount /dev/nvme0n1p1 /mnt/efi
```

## Install Arch Base

```bash
nano /etc/pacman.d/mirrorlist
pacstrap /mnt base

genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt
```

## Setup Date and Locale

```bash
ln -sf /usr/share/zoneinfo/Europe/Brussels /etc/localtime
hwclock --systohc

nano /etc/locale.gen
locale-gen
nano /etc/locale.conf
LANG=en_US.UTF-8
```

## Setup Host

```bash
nano /etc/hostname

nano /etc/hosts
127.0.0.1 localhost
::1 localhost
```

## Change Console Font

```bash
pacman -S terminus-font
setfont ter-m22n
nano /etc/vconsole.conf
FONT=ter-m22n
```

## Prepare EFI

```bash
mkinitpcio -p linux
pacman -S intel-ucode iucode_tool
cp /boot/* /efi

bootctl --path=/efi install
nano /efi/loader/loader.conf
cp /usr/share/systemd/bootctl/arch.conf /efi/loader/entries/
nano /efi/loader/entries/arch.conf
```

## Setup User

```bash
visudo
# Uncomment wheel group

useradd -m -G wheel -s /bin/bash cumpsd
exit
```

## Cleanup and Reboot

```bash
passwd
exit
umount -R /mnt
reboot
```

## Prepare Surface Kernel

```bash
pacman -S base-devel
git clone https://github.com/dmhacker/arch-linux-surface
sudo sh setup.sh
sudo sh configure.sh

cd build-[VERSION]
MAKEFLAGS="-j8" makepkg -sc

sudo pacman -U linux-surface-[VERSION]-1-x86_64.pkg.tar.xz
sudo pacman -U linux-surface-headers-[VERSION]-1-x86_64.pkg.tar.xz
sudo pacman -U linux-surface-docs-[VERSION]-1-x86_64.pkg.tar.xz

cp /boot/* /efi
sudo /usr/bin/mkinitcpio -p linux-surface
```

## Update Bootloader and Reboot

```bash
nano /efi/loader/loader.conf
nano /efi/loader/entries/arch.conf
reboot
```

## Check Microcode

```bash
dmesg | grep microcode
bsdtar -Oxf /efi/intel-ucode.img | iucode_tool -tb -lS -
grep microcode /proc/cpuinfo
```
