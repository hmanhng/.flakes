{pkgs, ...}: {
  programs = {
    neovim = {
      enable = true;
      withPython3 = true;
      withNodeJs = true;
      extraPackages = [
      ];
      #-- Plugins --#
      plugins = with pkgs.vimPlugins; [
      ];
      #-- --#
    };
  };
  home = {
    packages = with pkgs; [
      #-- LSP --#
      #nodePackages.bash-language-server
      #install_lsp
      #lua-language-server
      #gopls
      #pyright
      #zk
      #rust-analyzer
      #clang-tools
      #haskell-language-server
      #-- tree-sitter --#
      tree-sitter
      #-- format --#
      stylua
      #black
      #nixpkgs-fmt
      #rustfmt
      #beautysh
      #nodePackages.prettier
      # stylish-haskell
      #-- Debug --#
      #lldb

      #-- Latex --#
      #texlive.combined.scheme-full
    ];
  };

  # home.file.".config/nvim/init.lua".source = ./init.lua;
  # home.file.".config/nvim/lua" = {
  #   source = ./lua;
  #   recursive = true;
  # };
  # home.file.".config/nvim/stylua.toml".source = ./stylua.toml;
}
