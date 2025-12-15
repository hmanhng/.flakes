{inputs, ...}: {
  imports = [inputs.catppuccin.homeModules.catppuccin];
  catppuccin = {
    enable = false;
    cache.enable = true;
    flavor = "macchiato"; # "latte", "frappe", "macchiato", "mocha"

    mako.enable = false; # FIXME: https://github.com/nix-community/home-manager/issues/6971
    bat.enable = true;
    btop.enable = true;
    delta.enable = true;
    fcitx5.enable = true;
    foot.enable = false;
    fzf.enable = true;
    # obs.enable = true;
    qutebrowser.enable = true;
    # starship.enable = true;
    yazi.enable = true;
    zathura.enable = true;
  };

  theme = {
    wallpaper = let
      url = "https://images.unsplash.com/photo-1529528744093-6f8abeee511d?ixlib=rb-4.0.3&q=85&fm=jpg&crop=fit&cs=srgb&w=2560";
      sha256 = "18r5hmzglifysjmwn5j89gbbk56lbfb3f2jzwp432lr8gb5n7q8v";
      ext = "jpg";
    in
      builtins.fetchurl {
        name = "wallpaper-${sha256}.${ext}";
        inherit url sha256;
      };
  };
}
