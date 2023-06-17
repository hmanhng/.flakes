#!/usr/bin/env bash

disk=/dev/nvme0n1
efiPart=$disk"p1"
rootPart=$disk"p2"

#parted $disk --script mklabel gpt mkpart primary fat32 1MiB 512MB set 1 esp on mkpart primary ext4 512MB 100%
mkfs.fat -F 32 -n boot $efiPart &>/dev/null
mkfs.ext4 -F -L nixos $rootPart &>/dev/null
parted $disk print

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
