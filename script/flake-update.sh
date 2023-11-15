#!/usr/bin/env bash
function trap_ctrlc {
	echo "Ctrl-C caught...exiting."
	exit 1
}
trap "trap_ctrlc" 2

flake_input=(
	nixpkgs
	home-manager
	flake-parts
	nur
	emacs-overlay
	neovim-nightly-overlay
	hyprland
	hypr-contrib
	hyprpicker
	impermanence
	sops-nix
	yazi
	spicetify-nix
	nh
	nix-index-db
)
for item in "${flake_input[@]}"; do
	echo -e "\033[1;34m${item}: \033[0m"
	nix flake lock --update-input "$item"
done
