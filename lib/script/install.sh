#!/usr/bin/env bash

set -e

flake_dir="$(cd "$(dirname "$0")"/../.. && pwd)"

nixos_install() {
    cd $flake_dir
    sed -i '/nh = {/,+4 s/^/#/' modules/nix.nix # Comment nh module , error with nixos-install
    sed -i '/inputs\.nh\./ s/^/#/' modules/default.nix
    nixos-install --no-channel-copy --no-root-passwd --flake .#laptop
}
mkdir -p /mnt/nix/persist
nixos_install
sed -i '/nh = {/,+4 s/^#*//' modules/nix.nix # Comment nh module , error with nixos-install
sed -i '/inputs\.nh\./ s/^#*//' modules/default.nix
cp -r "$flake_dir" /mnt/nix/persist/.flakes
