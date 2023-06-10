#!/usr/bin/env bash

Part=/dev/nvme0n1
efiPart=$Part"p1"
rootPart=$Part"p2"

while true; do
	read -p $'\e[1;34mScript will format your device\nContinue running? (yes/no): \e[0m' answer
	answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')
	case $answer in
	yes | y)
		echo "Continue running"
		break
		;;
	no | n)
		echo "Stop"
		exit 0 # Exit the program with exit code 0
		;;
	*)
		echo "Invalid answer!"
		;;
	esac
done
parted $Part --script mklabel gpt mkpart primary fat32 1MiB 512MB set 1 esp on mkpart primary ext4 512MB 100%
mkfs.fat -F 32 $efiPart &>/dev/null
mkfs.ext4 -F $rootPart &>/dev/null
parted $Part print

mount -t tmpfs none /mnt
mkdir -p /mnt/{boot,nix,etc/nixos}
mount $rootPart /mnt/nix
mount $efiPart /mnt/boot
mkdir -p /mnt/nix/persist/etc/nixos
mount -o bind /mnt/nix/persist/etc/nixos /mnt/etc/nixos &>/dev/null

nixos-generate-config --root /mnt &>/dev/null

# Copy hardware-configuration to $flake_path
flake_path="$(cd "$(dirname "$0")"/.. && pwd)"
cp /mnt/etc/nixos/hardware-configuration.nix $flake_path/hosts/laptop/hardware-configuration.nix
sed -i '/swapDevices/a\  zramSwap.enable = true;' $flake_path/hosts/laptop/hardware-configuration.nix
sed -i '/tmpfs/a\      options = [ "defaults" "size=10G" "mode=755"  ];' $flake_path/hosts/laptop/hardware-configuration.nix

# Choice Installer version
while true; do
	echo "Full or Minimal ?:"
	echo "1. Full"
	echo "2. Minimal (without GUI)"
	read -p $'\e[1;34mEnter your choice (number): \e[0m' choice
	case $choice in
	1)
		echo "Install full packages"
		break
		;;
	2)
		sed -i '/modules\/desktop/s/^/# /' $flake_path/hosts/laptop/{default.nix,home.nix}
		echo "Install minimal packages"
		break
		;;
	*)
		echo "Invalid choice, please try again."
		;;
	esac
done

cd $flake_path
nixos-install --no-channel-copy --no-root-passwd --flake .#laptop
