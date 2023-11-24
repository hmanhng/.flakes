#!/usr/bin/env bash

clear
if [ "$EUID" -ne 0 ]; then
  echo "Run with sudo/doas."
  exit 1 # Thoát chương trình với mã lỗi 1
fi
set -e

flake_dir="$(cd "$(dirname "$0")"/../.. && pwd)"

while true; do
  # Lấy danh sách tên thiết bị disk vào mảng
  disks=($(lsblk -o NAME,TYPE | grep disk | awk '{print $1}'))

  # In danh sách tên thiết bị disk
  echo "List disk:"
  for ((i = 0; i < ${#disks[@]}; i++)); do
    echo "$(($i + 1)). ${disks[$i]}"
  done

  # Yêu cầu người dùng chọn một số
  if [ "${#disks[@]}" -eq 1 ]; then
    read -p $'\e[1;32mChoose (1): \e[0m' choice
  else
    read -p $'\e[1;32mChoose (1-'${#disks[@]}$'): \e[0m' choice
  fi

  # Kiểm tra nếu lựa chọn hợp lệ và in ra lựa chọn
  if [[ $choice =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 -a "$choice" -le "${#disks[@]}" ]; then
    disk="/dev/"${disks[$(($choice - 1))]}
    echo "Your choice: $disk"
    break
  else
    clear
    echo "Invalid selection."
  fi
done

#parted $disk --script mklabel gpt mkpart primary fat32 1MiB 512MB set 1 esp on mkpart primary ext4 512MB 100%
parted $disk print
if [[ "$disk" = *"nvme0n1" ]]; then
  disk+="p"
fi

read -p $'\e[1;34mEFI partition (enter Number): \e[0m' answer
efiPart=$disk$answer
mkfs.vfat -n boot $efiPart

read -p $'\e[1;34mRoot partition (enter Number): \e[0m' answer
rootPart=$disk$answer

# LUKS
cryptsetup --verify-passphrase -v luksFormat "$rootPart"
cryptsetup open "$rootPart" enc

# LVM
pvcreate /dev/mapper/enc
vgcreate lvm /dev/mapper/enc
lvcreate --extents 100%FREE --name root lvm

mkfs.btrfs /dev/lvm/root

mount -t btrfs /dev/lvm/root /mnt
# We first create the subvolumes outlined above:
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix

# We then take an empty *readonly* snapshot of the root subvolume,
# which we'll eventually rollback to on every boot.
btrfs subvolume snapshot -r /mnt/root /mnt/root-blank

umount /mnt

mount -o compress=zstd,noatime,subvol=root /dev/lvm/root /mnt
mkdir /mnt/{home,nix}
mount -o compress=zstd,noatime,subvol=home /dev/lvm/root /mnt/home
mount -o compress=zstd,noatime,subvol=nix /dev/lvm/root /mnt/nix

mkdir /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot

# Set uuid crypt disk
sed 's/by-uuid\/[^"]*/by-uuid\/'"$(blkid -s UUID -o value /dev/$rootPart)"'/g' "$flake_dir"/modules/boot.nix

nixos-generate-config --root /mnt
lsblk -f
