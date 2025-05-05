{
  config,
  pkgs,
  inputs,
  ...
}: let
  icons = ''
    [aws]
    symbol = "  "

    [buf]
    symbol = " "

    [c]
    symbol = " "

    [conda]
    symbol = " "

    [dart]
    symbol = " "

    [directory]
    read_only = " "

    [docker_context]
    symbol = " "

    [elixir]
    symbol = " "

    [elm]
    symbol = " "

    [fossil_branch]
    symbol = " "

    [git_branch]
    symbol = " "

    [golang]
    symbol = " "

    [guix_shell]
    symbol = " "

    [haskell]
    symbol = " "

    [haxe]
    symbol = "⌘ "

    [hg_branch]
    symbol = " "

    [java]
    symbol = " "

    [julia]
    symbol = " "

    [lua]
    symbol = " "

    [meson]
    symbol = "喝 "

    [nim]
    symbol = " "

    [nix_shell]
    symbol = " "

    [nodejs]
    symbol = " "

    [os.symbols]
    Alpine = " "
    Amazon = " "
    Android = " "
    Arch = " "
    CentOS = " "
    Debian = " "
    DragonFly = " "
    Emscripten = " "
    EndeavourOS = " "
    Fedora = " "
    FreeBSD = " "
    Garuda = "﯑ "
    Gentoo = " "
    HardenedBSD = "ﲊ "
    Illumos = " "
    Linux = " "
    Macos = " "
    Manjaro = " "
    Mariner = " "
    MidnightBSD = " "
    Mint = " "
    NetBSD = " "
    NixOS = " "
    OpenBSD = " "
    openSUSE = " "
    OracleLinux = " "
    Pop = " "
    Raspbian = " "
    Redhat = " "
    RedHatEnterprise = " "
    Redox = " "
    Solus = "ﴱ "
    SUSE = " "
    Ubuntu = " "
    Unknown = " "
    Windows = " "

    [package]
    symbol = " "

    [pijul_channel]
    symbol = "🪺 "

    [python]
    symbol = " "

    [rlang]
    symbol = "ﳒ "

    [ruby]
    symbol = " "

    [rust]
    symbol = " "

    [scala]
    symbol = " "

    [spack]
    symbol = "🅢 "
  '';
in {
  home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

  programs.starship = {
    enable = true;

    settings =
      builtins.fromTOML icons
      // {
        add_newline = false;
        username = {
          style_user = "green bold";
          style_root = "red bold";
          format = "[$user]($style) ";
          disabled = false;
          show_always = true;
        };
        hostname = {
          ssh_only = false;
          format = "on [$hostname](bold purple) ";
          trim_at = ".";
          disabled = false;
        };
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[✗](bold red)";
        };
        directory = {
          read_only = " 🔒";
          truncate_to_repo = false;
          truncation_length = 10;
          style = "bold italic blue";
        };

        git_status = {
          format = "([\\[$all_status$ahead_behind\\]]($style) )";
          stashed = "[\${count}*](green)";
          modified = "[\${count}+](yellow)";
          deleted = "[\${count}-](red)";
          conflicted = "[\${count}~](red)";
          ahead = "⇡\${count}";
          behind = "⇣\${count}";
          untracked = "[\${count}?](blue)";
          staged = "[\${count}+](green)";
        };
        git_state = {
          style = "bold red";
          format = "[$state( $progress_current/$progress_total) ]($style)";
          rebase = "rebase";
          merge = "merge";
          revert = "revert";
          cherry_pick = "cherry";
          bisect = "bisect";
          am = "am";
          am_or_rebase = "am/rebase";
        };
        cmd_duration = {
          min_time = 4;
          show_milliseconds = false;
          disabled = false;
          style = "bold italic red";
        };

        # We don't use terraform workspaces so don't consume the space
        terraform = {
          disabled = true;
        };

        # Directory config, truncation_length is subpath count not char count
        # don't truncate to git repo (not sure how i feel about this one yet)

        kubernetes = {
          disabled = false;
        };

        sudo = {
          disabled = true;
        };

        line_break.disabled = false;

        # Display which shell we're in
        # Do we actually need this? We use xonsh all the time.
        env_var.STARSHIP_SHELL = {
          format = "🪼 [$env_value]($style) ";
          style = "fg:green";
        };

        # palette = "catppuccin_${flavour}";
      };
  };
}
