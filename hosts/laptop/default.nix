{ config, pkgs, user, ... }:

let
  # Password for root and ${user}
  initialHashedPassword = "$6$X8/X.cOzzY2d.ak9$VyhhkfKFgxFiKfbPQt6AzkL3duOr43B.O27N6eJy07tgZvOyzdygARwXv7R2dXBOegrTk2F.N7NC9RkBi/sff0";
in
{
  imports =
    [
      ./hardware-configuration.nix
      ../../secrets/secrets.nix
    ] ++ [
      ../../modules/desktop
    ];

  # Change default shell to fish
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];

  users.users.root.initialHashedPassword = initialHashedPassword;
  services.getty.autologinUser = "${user}";
  users.users.${user} = {
    initialHashedPassword = initialHashedPassword;
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" ];
    packages = (with pkgs; [
      sops
    ]) ++ (with config.nur.repos;[
      # linyinfeng.icalingua-plus-plus
    ]);
  };
  programs.git.enable = true; # Why git here (both in home-manager) ? ... if no have doas will error when rebuild

  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/etc/nixos" # bind mounted from /nix/persist/etc/nixos to /etc/nixos
      "/etc/NetworkManager/system-connections"
      # "/etc/v2raya"
      "/var/log"
      "/var/lib"
      # "/etc/secureboot"
    ];
    files = [
      "/etc/machine-id"
    ];
    users.${user} = {
      directories = [
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        "Desktop"
        ".cache"
        ".config"
        ".local"
        ".flakes"
        # "Kvm"
        # { directory = ".gnupg"; mode = "0700"; }
        { directory = ".ssh"; mode = "0700"; }
        ".mozilla"
      ];
      files = [
      ];
    };
  };

  security.sudo = {
    enable = false;
    extraConfig = ''
      ${user} ALL=(ALL) NOPASSWD:ALL
    '';
  };
  security.doas = {
    enable = true;
    extraConfig = ''
      permit nopass ${user}
    '';
  };

}
