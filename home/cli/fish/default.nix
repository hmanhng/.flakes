{
  pkgs,
  osConfig,
  ...
}: {
  programs.bash = {
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
  programs.fish = {
    enable = true;
    plugins =
      (with pkgs.fishPlugins; [
        {
          name = "tide";
          src = tide.src;
        }
        {
          name = "done";
          src = done.src;
        }
        {
          name = "autopair";
          src = autopair.src;
        }
        {
          name = "fzf-fish";
          src = fzf-fish.src;
        }
        {
          name = "forgit";
          src = forgit.src;
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
    loginShellInit = ''
    '';
    interactiveShellInit = ''
      set fish_greeting ""

      # "nvim" as $EDITOR
      set -x EDITOR "nvim"

      # "nvim" as manpager
      set -x MANPAGER "nvim +Man!"

      # fzf-fish
      set fzf_preview_dir_cmd eza --all --color=always
      set fzf_fd_opts --hidden

      ### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
      set fish_color_normal brcyan
      set fish_color_autosuggestion "#7d7d7d"
      set fish_color_command "#7bc275" # green
      set fish_color_error "#ff6c6b"
      set fish_color_quote --bold "#ffffff"
      set fish_color_param --bold green
    '';
    shellAbbrs = {
      j = "z";
    };
    shellAliases = {
      # adding flags
      df = "df -h"; # human-readable sizes
      free = "free -m"; # show sizes in MB
      grep = "grep --color=auto"; # colorize output (good for log files)

      l = "eza -F --color=always --group-directories-first";
      ls = "eza -F -alhg --icons --git --color=always --group-directories-first"; # my preferred listing
      la = "eza -F -a --color=always --group-directories-first"; # all files and dirs
      ll = "eza -F -lhg --icons --git --color=always --group-directories-first"; # long format
      lt = "eza -F -aT -L 3 -I \".git\" --icons --color=always --group-directories-first"; # tree listing
      "l." = "eza -F -a | grep -E \"^\\.\"";

      e = "emacs -nw";
      v = "nvim";
      vi = "nvim";
      suvi = "sudo nvim";
      nf = "nvim $(fzf)";
      ef = "e $(fzf)";
      f = "fzf";

      r = "yazi"; # change ranger -> yazi -- faster
      y = "yazi";
      n = "nitch";

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
  # home.file.".config/fish/conf.d/nord.fish".text = import ./conf.d/nord_theme.nix;
  xdg.configFile."fish/functions/hmanhng.fish".source = ./functions/hmanhng.fish;
}
