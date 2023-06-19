#!/usr/bin/env bash

disk=/dev/nvme0n1
flake_dir="$(cd "$(dirname "$0")"/.. && pwd)"
hardware_configuration=$flake_dir"/hosts/laptop/hardware-configuration.nix"

copy_hardware_configuration() {
    nixos-generate-config --root /mnt &>/dev/null
    # Copy hardware-configuration to $hardware-configuration
    cp /mnt/etc/nixos/hardware-configuration.nix $hardware_configuration
    perl -i -pe 'if ($in_section) { s/by-uuid\/[^"]+/by-label\/nixos/; $in_section = 0; } elsif (/fileSystems."\/nix" =/) { $in_section = 1; }' $hardware_configuration
    perl -i -pe 'if ($in_section) { s/by-uuid\/[^"]+/by-label\/boot/; $in_section = 0; } elsif (/fileSystems."\/boot" =/) { $in_section = 1; }' $hardware_configuration
    sed -i '/tmpfs/a\      options = [ "defaults" "size=10G" "mode=755"  ];' $hardware_configuration
    sed -i '/swapDevices/a\  zramSwap.enable = true;' $hardware_configuration
}

format_device() {
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
}

mount_tmpfs() {
    mount -t tmpfs none /mnt
    mkdir -p /mnt/{boot,nix,etc/nixos}
    mount /dev/disk/by-label/nixos /mnt/nix
    mount /dev/disk/by-label/boot /mnt/boot
    mkdir -p /mnt/nix/persist/etc/nixos
    mount -o bind /mnt/nix/persist/etc/nixos /mnt/etc/nixos &>/dev/null
}

nixos_install() {
    cd $flake_dir
    nixos-install --no-channel-copy --no-root-passwd --flake .#laptop
}

format_device
mount_tmpfs
copy_hardware_configuration
nixos_install
