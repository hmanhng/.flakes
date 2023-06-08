#!/usr/bin/env bash
function trap_ctrlc {
	echo "Ctrl-C caught...exiting."
	exit 1
}
trap "trap_ctrlc" 2

flake_input=(
	emacs-overlay
	flake-parts
	home-manager
	hypr-contrib
	hyprland
	hyprpicker
	impermanence
	neovim-nightly-overlay
	nixpkgs
	nur
	sops-nix
)
for item in "${flake_input[@]}"; do
	echo -e "\033[1;34m${item}: \033[0m"
	nix flake lock --update-input "$item"
done
