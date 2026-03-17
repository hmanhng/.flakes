{
  config,
  pkgs,
  ...
}:
{
  # Change default shell to fish
  # https://nixos.wiki/wiki/Fish#Setting_fish_as_your_shell
  programs.fish = {
    enable = true;
    vendor.functions.enable = false;
    vendor.config.enable = false;
  };
  environment.shells = with pkgs; [ fish ];

  users.users.root.initialHashedPassword = "$6$X8/X.cOzzY2d.ak9$VyhhkfKFgxFiKfbPQt6AzkL3duOr43B.O27N6eJy07tgZvOyzdygARwXv7R2dXBOegrTk2F.N7NC9RkBi/sff0";

  users.users.hmanhng = {
    isNormalUser = true;
    shell = pkgs.fish;
    initialHashedPassword = config.users.users.root.initialHashedPassword;
    extraGroups = [
      "input"
      "libvirtd"
      "networkmanager"
      "plugdev"
      "transmission"
      "video"
      "wheel"
    ];
  };

  # services.getty.autologinUser = "hmanhng";
}
