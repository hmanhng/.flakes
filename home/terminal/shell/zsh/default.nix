{
  config,
  pkgs,
  ...
}:
{
  programs = {
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableSyntaxHighlighting = true;
      dotDir = ".config/zsh";
      history.path = "${config.xdg.dataHome}/zsh/zsh_history";
      plugins = [
        {
          name = "zsh-autocomplete";
          src = pkgs.fetchFromGitHub {
            owner = "marlonrichert";
            repo = "zsh-autocomplete";
            rev = "23.05.02";
            sha256 = "08h5jdm2nrdzjn8dfv21ax1yvyxbn6czfwbgdx50zihdd4j7nnqx";
          };
        }
        {
          name = "zsh-autopair";
          src = pkgs.fetchFromGitHub {
            owner = "hlissner";
            repo = "zsh-autopair";
            rev = "master";
            sha256 = "0q9wg8jlhlz2xn08rdml6fljglqd1a2gbdp063c8b8ay24zz2w9x";
          };
        }
      ];
      shellAliases = {
        l = "exa -F --color=always --group-directories-first";
        ls = "exa -Falhg --color=always --group-directories-first"; # my preferred listing
        la = "exa -Fa --color=always --group-directories-first"; # all files and dirs
        ll = "exa -Flhg --color=always --group-directories-first"; # long format
        lt = "exa -FaT -L 3 --icons --color=always --group-directories-first"; # tree listing
        "l." = "exa -Fa | grep -E \"^\\.\"";

        j = "z";
        ji = "zi";

        vi = "nvim";
        suvi = "doas nvim";

        r = "ranger";
        n = "nitch";

        nrf = "doas nixos-rebuild switch --flake ~/.flakes/.#laptop";
        ncg = "nix-collect-garbage -d && doas nix-env -p /nix/var/nix/profiles/system --delete-generations old && doas nix-collect-garbage -d";
        fl = "cd ~/.flakes";
      };
      initExtra = ''
        autoload -Uz colors && colors
        # completions
        zstyle ':autocomplete:*' widget-style menu-select
        # zstyle ':autocomplete:*' fzf-completion yes
        zstyle ':autocomplete:*' recent-dirs zoxide
        zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}
        zstyle ':completion:*:aliases' list-colors '=*=2;38;5;205'
        zstyle ':completion:*:builtins' list-colors '=*=1;38;5;105'
        zstyle ':completion:*:options' list-colors '=^(-- *)=34'
        zstyle ':completion:*:commands' list-colors '=*=1;36'
        zstyle ':completion:*' list-colors 'reply=( "=(#b)(*$VAR)(?) *=00=$color[green]=$color[bg-green]" )'
        zmodload zsh/complist

        bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
        bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
      '';
    };
  };
}
