#!/usr/bin/env bash

set -e

flake_dir="$(cd "$(dirname "$0")"/../.. && pwd)"

nixos_install() {
  cd $flake_dir
  sed -i '/lanzaboote\.nix/ s/^/#/' hosts/default.nix
  nixos-install --impure --no-channel-copy --no-root-passwd --flake .#laptop
}
mkdir -p /mnt/nix/persist
nixos_install
sed -i '/lanzaboote\.nix/ s/^#*//' hosts/default.nix
cp -r "$flake_dir" /mnt/nix/persist/.flakes
