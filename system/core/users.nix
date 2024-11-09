{
  config,
  pkgs,
  ...
}: {
  # Change default shell to fish
  programs.fish = {
    enable = true;
    vendor.functions.enable = false;
    vendor.config.enable = false;
  };
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [fish];

  users.users.root.initialHashedPassword = "$6$X8/X.cOzzY2d.ak9$VyhhkfKFgxFiKfbPQt6AzkL3duOr43B.O27N6eJy07tgZvOyzdygARwXv7R2dXBOegrTk2F.N7NC9RkBi/sff0";

  users.users.hmanhng = {
    isNormalUser = true;
    initialHashedPassword = config.users.users.root.initialHashedPassword;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
      "input"
      "libvirtd"
      "plugdev"
    ];
  };

  # services.getty.autologinUser = "hmanhng";
}
