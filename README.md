# How to install?

## You might want to use my minimal ISO with pre-installed neovim, git, and support for binary cache substituters.
[**ISO**](https://github.com/hmanhng/.flakes/releases/download/ISO/minimal.iso)

### I don't have time to write instructions, so please refer to the file [**script/install.sh**](https://github.com/hmanhng/.flakes/blob/tmpfs/script/install.sh) for installation steps (this is the script I use to install on my own machine).

> **Warning**  
> **Please don't blindly use my repository.**
  - Instead, fork this repository and make some changes such as the [**username**](https://github.com/hmanhng/.flakes/blob/tmpfs/flake.nix#L23) and [**password**](https://github.com/hmanhng/.flakes/blob/tmpfs/hosts/laptop/default.nix#L5).
  - And replace your [**hardware-configuration.nix**](https://github.com/hmanhng/.flakes/blob/tmpfs/hosts/laptop/hardware-configuration.nix) file in the `/etc/nixos/hardware-configuration.nix` directory.

> **Note**  
> **My system uses `root on tmpfs`.**
  - If you want to install normally, please refer to the following documentation at [**NixOS manual**](https://nixos.org/manual/nixos/stable/index.html#sec-installation-manual-partitioning) and replace it accordingly [**here**](https://github.com/hmanhng/.flakes/blob/tmpfs/script/install.sh#L29-L34).
  - And disable [**impermanence**](https://github.com/hmanhng/.flakes/blob/tmpfs/hosts/laptop/default.nix#L35-L68) module.
