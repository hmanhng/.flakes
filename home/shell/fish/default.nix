{pkgs, ...}: {
  programs.fish = {
    enable = true;
    loginShellInit = ''
    '';
    /*
     plugins = [
    {
    name = "autopair.fish";
    src = pkgs.fetchFromGitHub {
    owner = "jorgebucaran";
    repo = "autopair.fish";
    rev = "1.0.4";
    sha256 = "0mfx43n3ngbmyfp4a4m9a04gcgwlak6f9myx2089bhp5qkrkanmk";
    };
    }
    ];
    */
    interactiveShellInit = ''set fish_greeting ""'';
    shellAliases = {
      l = "eza -F --color=always --group-directories-first";
      ls = "eza -Falhg --color=always --group-directories-first"; # my preferred listing
      la = "eza -Fa --color=always --group-directories-first"; # all files and dirs
      ll = "eza -Flhg --color=always --group-directories-first"; # long format
      lt = "eza -FaT -L 3 --icons --color=always --group-directories-first"; # tree listing
      "l." = "eza -Fa | grep -E \"^\\.\"";

      e = "emacs";
      ee = "emacsclient -c -a 'emacs'";
      ei = "emacsclient -c -nw -a 'emacs -nw'";
      v = "nvim";
      vi = "nvim";
      suvi = "sudo nvim";
      nf = "nvim $(fzf)";
      f = "fzf";

      r = "yazi"; # change ranger -> yazi -- faster
      y = "yazi";
      n = "neofetch";

      wget = "wget --hsts-file=\"\$XDG_DATA_HOME/wget-hsts\"";

      nhb = "nh os boot -H laptop";
      nht = "nh os test -H laptop";
      nhs = "nh os switch -H laptop";
      fc = "nix flake check";
      fl = "cd ~/.flakes";
    };
  };
  home.packages = with pkgs; [fishPlugins.autopair];
  home.file.".config/fish/functions/owf.fish".text = import ./functions/owf.nix;
  home.file.".config/fish/functions/xdg-get.fish".text = import ./functions/xdg-get.nix;
  home.file.".config/fish/functions/xdg-set.fish".text = import ./functions/xdg-set.nix;
  home.file.".config/fish/conf.d/nord.fish".text = import ./conf.d/nord_theme.nix;
  xdg.configFile."fish/functions/hmanhng.fish".source = ./functions/hmanhng.fish;
  xdg.configFile."starship.toml".source = ./starship.toml;
}
