{
  user,
  ...
}: let
  # Password for root and ${user}
  initialHashedPassword = "$6$X8/X.cOzzY2d.ak9$VyhhkfKFgxFiKfbPQt6AzkL3duOr43B.O27N6eJy07tgZvOyzdygARwXv7R2dXBOegrTk2F.N7NC9RkBi/sff0";
in {
  imports = [./hardware-configuration.nix];

  users.users.root.initialHashedPassword = initialHashedPassword;
  services.getty.autologinUser = "${user}";
  users.users.${user} = {
    initialHashedPassword = initialHashedPassword;
    isNormalUser = true;
    extraGroups = ["wheel" "video" "audio" "networkmanager"];
  };
}
