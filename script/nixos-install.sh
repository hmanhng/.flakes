#!/usr/bin/env bash

flake_path="$(cd "$(dirname "$0")"/.. && pwd)"
cd $flake_path
nixos-install  --no-channel-copy --no-root-passwd --flake .#laptop
