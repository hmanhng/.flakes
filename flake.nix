{
  description = "Hmanhng's NixOS configuration";

  outputs = inputs @ {flake-parts, ...}: let
    user = "hmanhng";
  in
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];
      imports = [
        ./hosts
        ./home/profiles
        ./modules
        ./lib
        ./pkgs
        {_module.args = {inherit user;};}
      ];
      perSystem = {
        config,
        pkgs,
        ...
      }: {
        # set flake-wide pkgs to the one exported by ./lib
        imports = [{_module.args.pkgs = config.legacyPackages;}];
        devShells = {
          #run by `nix devlop` or `nix-shell`(legacy)
          default = import ./shell.nix {inherit pkgs;};
          #run by `nix develop .#<name>`
          secret = with pkgs;
            mkShell {
              name = "secret";
              nativeBuildInputs = [sops age gnupg ssh-to-age ssh-to-pgp];
              shellHook = ''
                export PS1="\e[0;31m(Secret)\$ \e[m"
              '';
            };
        };
        formatter = pkgs.alejandra;
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nur.url = "github:nix-community/NUR";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    hyprland.url = "github:hyprwm/Hyprland";
    hypr-contrib.url = "github:hyprwm/contrib";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    impermanence.url = "github:nix-community/impermanence"; # Systems with ephemeral root storage.
    sops-nix.url = "github:Mic92/sops-nix";

    disko.url = "github:nix-community/disko";

    yazi.url = "github:sxyazi/yazi";

    spicetify-nix = {
      url = "github:MichaelPachec0/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nh.url = "github:viperML/nh";

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bitwarden-menu.url = "github:firecat53/bitwarden-menu";

    catppuccin-starship = {
      url = "github:catppuccin/starship";
      flake = false;
    };
    carapace = {
      url = "github:rsteube/carapace-bin";
      flake = false;
    };
  };
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      # "https://helix.cachix.org"
      "https://hmanhng.cachix.org"
      "https://viperml.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      # "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "hmanhng.cachix.org-1:+pXFpN2CtS0rNUdCdeiOu6QUWMVBX0nCbWREhfiiKtI="
      "viperml.cachix.org-1:qZhKBMTfmcLL+OG6fj/hzsMEedgKvZVFRRAhq7j8Vh8="
    ];
  };
}
