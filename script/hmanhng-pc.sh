#!/usr/bin/env bash

disk=/dev/nvme0n1

#parted $disk --script mklabel gpt mkpart primary fat32 1MiB 512MB set 1 esp on mkpart primary ext4 512MB 100%
parted $disk print
# Format EFI
read -p $'\e[1;34mEFI partition (enter Number): \e[0m' answer
efiPart=$disk"p"$answer
mkfs.fat -F 32 -n boot $efiPart &>/dev/null
# Format Root
read -p $'\e[1;34mRoot partition (enter Number): \e[0m' answer
rootPart=$disk"p"$answer
mkfs.ext4 -F -L nixos $rootPart &>/dev/null

mount -t tmpfs none /mnt
mkdir -p /mnt/{boot,nix,etc/nixos}
mount /dev/disk/by-label/nixos /mnt/nix
mount /dev/disk/by-label/boot /mnt/boot
mkdir -p /mnt/nix/persist/etc/nixos
mount -o bind /mnt/nix/persist/etc/nixos /mnt/etc/nixos &>/dev/null

nixos-generate-config --root /mnt &>/dev/null

flake_path="$(cd "$(dirname "$0")"/.. && pwd)"
cd $flake_path
nixos-install --no-channel-copy --no-root-passwd --flake .#laptop
