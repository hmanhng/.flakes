#!/usr/bin/env bash

clear
set -e

flake_dir="$(cd "$(dirname "$0")"/../.. && pwd)"
common_dir="$flake_dir/lib/disko"

function ask {
  while true; do
    echo -n "Would you like to edit this layout? (y/n): "
    read choice
    if [ "$choice" = "y" ]; then
      nvim $partition_layout
      break
    elif [ "$choice" = "n" ]; then
      break
    else
      echo "Invalid input, please try again."
    fi
  done
}
# Select the disk partition layout and edit it
while true; do
  lsblk -f
  echo "Please select a disk partition layout:"
  echo "1. ext4-single-luks"
  echo "2. btrfs-single"
  echo "3. btrfs-single-luks"
  echo "4. zfs-single-luks"
  read -p $'\e[1;32mEnter your choice(number): \e[0m' choice

  case $choice in
  1)
    partition_layout="$common_dir/ext4-single-luks.nix"
    ask
    #to set luks password
    read -p $'\e[1;31mEnter LUKS password (important!): \e[0m' -r luks_pass
    echo -n "$luks_pass" >/tmp/secret.key
    break
    ;;
  2)
    partition_layout="$common_dir/btrfs-single.nix"
    ask
    break
    ;;
  3)
    partition_layout="$common_dir/btrfs-single-luks.nix"
    ask
    #to set luks password
    read -p $'\e[1;31mEnter LUKS password (important!): \e[0m' -r luks_pass
    echo -n "$luks_pass" >/tmp/secret.key
    # read -p $'\e[1;31mEnter Additional LUKS password (important!): \e[0m' -r luks_pass
    # echo -n "$luks_pass" > /tmp/additionalSecret.key
    break
    ;;
  4)
    partition_layout="$common_dir/zfs-single-luks.nix"
    ask
    #to set luks password
    read -p $'\e[1;31mEnter LUKS password (important!): \e[0m' -r luks_pass
    echo -n "$luks_pass" >/tmp/secret.key
    break
    ;;
  *)
    echo "Invalid choice, please try again."
    ;;
  esac
done

nix run github:nix-community/disko -- --mode disko "$partition_layout"

nixos-generate-config --no-filesystems --root /mnt
cd /mnt/etc/nixos
cp hardware-configuration.nix "$flake_dir"/hosts/laptop/hardware-configuration.nix

relative_path="../../lib/disko"
layout_filepath="$relative_path/$(basename $partition_layout)"

sed -i "/imports\ =/cimports\ = [(import\ $layout_filepath\ {})]++" "$flake_dir"/hosts/laptop/hardware-configuration.nix
nix-shell -p alejandra --run "alejandra $flake_dir/hosts/laptop/hardware-configuration.nix"

lsblk -f
