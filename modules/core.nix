{pkgs, ...}: {
  # Change default shell to fish
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [fish];

  time.timeZone = "Asia/Ho_Chi_Minh";

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

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  system.stateVersion = "23.05";
}
