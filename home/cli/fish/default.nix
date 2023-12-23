{
  pkgs,
  osConfig,
  ...
}: {
  programs.fish = {
    enable = true;
    loginShellInit = ''
    '';
    plugins =
      (with pkgs.fishPlugins; [
        {
          name = "done";
          src = done.src;
        }
        {
          name = "autopair";
          src = autopair.src;
        }
      ])
      ++ [
        # {
        #   name = "autopair.fish";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "jorgebucaran";
        #     repo = "autopair.fish";
        #     rev = "1.0.4";
        #     sha256 = "0mfx43n3ngbmyfp4a4m9a04gcgwlak6f9myx2089bhp5qkrkanmk";
        #   };
        # }
      ];
    interactiveShellInit = ''set fish_greeting ""'';
    shellAliases = {
      l = "eza -F --color=always --group-directories-first";
      ls = "eza -Falhg --icons --git --color=always --group-directories-first"; # my preferred listing
      la = "eza -Fa --color=always --group-directories-first"; # all files and dirs
      ll = "eza -Flhg --icons --git --color=always --group-directories-first"; # long format
      lt = "eza -FaT -L 3 -I \".git\" --icons --color=always --group-directories-first"; # tree listing
      "l." = "eza -Fa | grep -E \"^\\.\"";

      e = "emacsclient -c -nw -a 'emacs -nw'";
      v = "nvim";
      vi = "nvim";
      suvi = "sudo nvim";
      nf = "nvim $(fzf)";
      ef = "e $(fzf)";
      f = "fzf";

      r = "yazi"; # change ranger -> yazi -- faster
      y = "yazi";
      n = "neofetch";

      wget = "wget --hsts-file=\"\$XDG_DATA_HOME/wget-hsts\"";

      nhb = "nh os boot -H ${osConfig.networking.hostName}";
      nht = "nh os test -H ${osConfig.networking.hostName}";
      nhs = "nh os switch -H ${osConfig.networking.hostName}";
      fc = "nix flake check";
      fl = "cd ~/.flakes";

      xdg-ninja = ", xdg-ninja";
    };
  };
  home.file.".config/fish/functions/owf.fish".text = import ./functions/owf.nix;
  home.file.".config/fish/functions/xdg-get.fish".text = import ./functions/xdg-get.nix;
  home.file.".config/fish/functions/xdg-set.fish".text = import ./functions/xdg-set.nix;
  home.file.".config/fish/conf.d/nord.fish".text = import ./conf.d/nord_theme.nix;
  xdg.configFile."fish/functions/hmanhng.fish".source = ./functions/hmanhng.fish;
}
