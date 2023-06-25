{ lib, pkgs, user, ... }:

{
  programs.fish = {
    enable = true;
    loginShellInit = ''
    '';
    /* plugins = [
      {
      name = "autopair.fish";
      src = pkgs.fetchFromGitHub {
      owner = "jorgebucaran";
      repo = "autopair.fish";
      rev = "1.0.4";
      sha256 = "0mfx43n3ngbmyfp4a4m9a04gcgwlak6f9myx2089bhp5qkrkanmk";
      };
      }
      ]; */
    shellAliases = {
      l = "exa -F --color=always --group-directories-first";
      ls = "exa -Falhg --color=always --group-directories-first"; # my preferred listing
      la = "exa -Fa --color=always --group-directories-first"; # all files and dirs
      ll = "exa -Flhg --color=always --group-directories-first"; # long format
      lt = "exa -FaT -L 3 --icons --color=always --group-directories-first"; # tree listing
      "l." = "exa -Fa | grep -E \"^\\.\"";

      v = "nvim";
      vi = "nvim";
      suvi = "doas nvim";
      nf = "nvim $(fzf)";
      f = "fzf";

      j = "z";
      ji = "zi";

      r = "lfub"; # change ranger -> lf -- faster
      lf = "lfub";
      n = "neofetch";

      wget = "wget --hsts-file=\"\$XDG_DATA_HOME/wget-hsts\"";

      nrb = "cd ~/.flakes && nixos-rebuild build --flake ~/.flakes/.#laptop";
      nrf = "doas nixos-rebuild switch --flake ~/.flakes/.#laptop";
      nrt = "doas ~/.flakes/result/bin/switch-to-configuration test";
      ncg = "nix-collect-garbage -d && doas nix-env -p /nix/var/nix/profiles/system --delete-generations old && doas nix-collect-garbage -d";
      fl = "cd ~/.flakes";
    };
  };
  home.packages = with pkgs; [ fishPlugins.autopair ];
  home.file.".config/fish/fish_variables".text = import ./fish_variables.nix;
  home.file.".config/fish/functions/owf.fish".text = import ./functions/owf.nix;
  home.file.".config/fish/functions/xdg-get.fish".text = import ./functions/xdg-get.nix;
  home.file.".config/fish/functions/xdg-set.fish".text = import ./functions/xdg-set.nix;
  # home.file.".config/fish/functions/fish_prompt.fish".source = ./functions/fish_prompt.fish;
  home.file.".config/fish/conf.d/nord.fish".text = import ./conf.d/nord_theme.nix;
  xdg.configFile."fish/functions/hmanhng.fish".source = ./functions/hmanhng.fish;
  programs.zoxide.enable = true;
  programs.starship.enable = true;
  programs.exa.enable = true;
  xdg.configFile."starship.toml".source = ./starship.toml;
}
