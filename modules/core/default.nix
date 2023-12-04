{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./boot.nix
    ./nix.nix
  ];
  # Change default shell to fish
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [fish];

  time.timeZone = lib.mkDefault "Asia/Ho_Chi_Minh";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "vi_VN";
    LC_IDENTIFICATION = "vi_VN";
    LC_MEASUREMENT = "vi_VN";
    LC_MONETARY = "vi_VN";
    LC_NAME = "vi_VN";
    LC_NUMERIC = "vi_VN";
    LC_PAPER = "vi_VN";
    LC_TELEPHONE = "vi_VN";
    LC_TIME = "vi_VN";
  };

  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    systemPackages = with pkgs; [
      git
    ];
  };

  # don't ask for password for wheel group
  security.sudo.wheelNeedsPassword = false;

  services.getty.autologinUser = "hmanhng";
  users.users.hmanhng = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "audio" "networkmanager" "input" "libvirtd" "plugdev"];
  };

  # compresses half the ram for use as swap
  zramSwap.enable = true;

  system.stateVersion = lib.mkDefault "23.05";
}
