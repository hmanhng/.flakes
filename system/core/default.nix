{lib, ...}: {
  imports = [
    ./users.nix
    ./security.nix
    ../nix
  ];

  time.timeZone = lib.mkDefault "Asia/Ho_Chi_Minh";
  time.hardwareClockInLocalTime = true;

  i18n.defaultLocale = "en_US.UTF-8";

  # compresses half the ram for use as swap
  zramSwap.enable = true;

  system.stateVersion = lib.mkDefault "23.11";
}
