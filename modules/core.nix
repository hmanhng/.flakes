{ config, pkgs, user, ... }:
{
  # Change default shell to fish
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];

  time.timeZone = "Asia/Ho_Chi_Minh";

  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    systemPackages = with pkgs; [
      sops
      git
    ];
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

  system.stateVersion = "22.11";
}
