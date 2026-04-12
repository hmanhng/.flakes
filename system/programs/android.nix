{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.android-tools
    pkgs.scrcpy
  ];

  users.users.hmanhng.extraGroups = [ "adbusers" ];
}
