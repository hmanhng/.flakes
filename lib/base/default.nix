{lib}: rec {
  editor = "emacsclient";

  browser = "firefox";

  launcher = "rofi";

  # linuxmobile font -> AestheticIosevka Nerd Font Mono
  terminal = {
    name = "kitty";
    font = "Maple Mono";
    opacity = 0.8;
    size = 19;
  };

  # TODO: Change this later
  wallpaper = builtins.fetchurl {
    url = "https://i.imgur.com/6zpmPd8.png";
    sha256 = "sha256-X3I/rNGko+vAadD9jxqp/xbvML/KbuSMfOy/YHI+Ro0=";
  };
}
